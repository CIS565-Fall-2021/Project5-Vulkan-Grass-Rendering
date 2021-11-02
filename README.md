Vulkan Grass Rendering
==================================

<img src="img\final.gif" height="500px"/>

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Anthony Mansur
  - https://www.linkedin.com/in/anthony-mansur-ab3719125/

- Tested on: Windows 10, AMD Ryzen 5 3600, Geforce RTX 2060 Super (personal)

### Introduction

For this project, we use [Vulkan](https://www.vulkan.org/) to implement a grass simulator and renderer based on the research paper,  [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) . We use compute shaders to perform physics calculations on Bezier curves that represent individual grass blades in our application. Since rendering every grass blade on every frame is fairly inefficient, we also use compute shaders to cull grass blades that do not contribute to a given frame. The remaining blades are then passed to a graphics pipeline. In this pipeline, we have a vertex shader that transforms our Bezier control points, tessellation shaders to dynamically create the grass geometry from the Bezier curves, and a fragment shader to shade the grass blades. 

### Grass Model

<img src="img\blade_model.jpg" height="300px"/>

To render the grass, we take in as input several control points for every grass blade. These control points are:

- `v0`: the position of the grass blade on the geometry
- `v1`: a Bezier curve guide that is always "above" v0 with respect to the grass blade's up vector 
- `v2`: a physical guide for which we simulate forces on 
- `up`: the blade's up vector, which corresponds to the normal of the geometry that the grass blade resides on at v0

These control points are four-dimensional vectors, with the fourth coordinate representing per-blade characteristics that helps us simulate and tessellate our grass blades correctly:

- **Orientation**: the orientation of the grass blade's face
- **Height**: the height of the grass blade
- **Width**: the width of the grass blade's face
- **Stiffness coefficient**: the stiffness of our grass blade, which will affect the force computations on our blade (used in physics simulation)

### Rendering

<img src="img\grass-types.png" height="200px"/>

Once we have passed the control points for every grass blade, we can render four different types of grass blades, as described in the research paper. As described in the introduction, our pipeline includes the tessellation shaders to render these blades as quadratic bezier curves. The result of our render is shown below:

<img src="img\no-force.gif" height="450px"/>



### Simulation

We first simulate the grass blades and then render it every frame, using the time difference between every frame as our time step for the physics simulation. The forces are applied to the control point `v2`, with the added constraint that the length of the grass blade remains constant. 

The three types of forces the simulation computes are:

- **Gravity:** both the environmental and the "front" gravity
- **Recovery:** the counter-force that brings our grass blade back into equilibrium (using Hooke's law)
- **Wind:** primitive wind function that has a direction and strength and varies with respect to time and the position of the grass blade. 

|             Gravity + Recovery              |            Gravity + Recovery + Wind            |
| :-----------------------------------------: | :---------------------------------------------: |
| <img src="img\no-wind.gif" height="300px"/> | <img src="img\strong-wind.gif" height="300px"/> |



### Performance Analysis

We use several culling techniques to reduce the amount of grass blades we simulate and render for performance reasons. The three different types of tests we perform are:

- **Orientation**: To minimize anti-aliasing effects, we eliminate grass blades when their front-facing direction is nearly perpendicular to the view vector
- **View-frustum**: Remove any grass blades that isn't inside our viewing frustum
- **Distance**: Reduce the number of grass blades as a function of distance from the camera



To see these effects in extreme, see the following gifs:

|                    Orientation test                     |                  View-Frustum test                  |                    Distance test                     |
| :-----------------------------------------------------: | :-------------------------------------------------: | :--------------------------------------------------: |
| <img src="img\orientation-culling.gif" height="250px"/> | <img src="img\frustum-culling.gif" height="250px"/> | <img src="img\distance-culling.gif" height="250px"/> |



We then see how much our frames per second changes as we add these culling techniques and add more blades. To perform this test, we make the plane width 100 by 100, and we change the camera position to be 20 units from the origin, with a phi angle of -35 degrees.



<img src="img\performance.png" height="500px"/>



As we can see from the performance analysis, each culling technique improves our frames per second, with the view-frustum test being the most impactful and the orientation test being the least, as expected. This trend follows as we increase the number of blades. 
