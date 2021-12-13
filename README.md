Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Zhihao Ruan
* Tested on: Windows 10 Home 21H1 Build 19043.1288, Ryzen 7 3700X @ 3.59GHz 48GB, RTX 2060 Super 8GB

![](img/overall.gif)

## Highlights
This project implements physically-based grass rendering & culling with Vulkan compute shaders:
- Physically-based real-time rendering of grass blades;
- 3 different culling tests: orientation culling, view-frustum culling, distance culling;
- Tessellating Bezier curves into grass blades with GLSL tessellation shader

A detailed instruction of this project can be found [here](INSTRUCTION.md).

## Vulkan
[Vulkan](https://vulkan-tutorial.com/) is considered as the next-generation graphics API developed by [Khronos group](https://www.khronos.org/), in replacement for the old OpenGL. It is fast, high-performance, and cross-platform. However, the downside of this API is that it exposes all details of GPU hardware to users for possible customization, so that it generally takes a significantly large amount of code for users to set up the rendering pipeline than OpenGL.

This project sets up a standard Vulkan graphics pipeline with compute shaders & tessellation shaders. The goal of this project is to implement the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) for effective grass simulation in 3D rendering. 

## [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
Grass is a critical component in 3D graphics. Almost every modern video games have some scenes that involve the rendering of grass. It is also a typical example of massive parallelization, as with the power of GPU one can easily think of ways to render every grass blade with a single GPU thread for photorealistic effects. However, approximations are still needed, and the paper chooses Bezier curves. Bezier curves are a special family of curve that produces smooth splines geometry in 3D space. The generation of Bezier curve requires pre-defining multiple control points, and the curve would then be generated following a fixed function that interpolates between adjacent control points (for more details, see [Wikipedia](https://en.wikipedia.org/wiki/B%C3%A9zier_curve)).

![](img/blade_model.jpg)

### Basic Geometry
From the paper, a single grass blade can be defined as a Bezier curve with 3 control points: `v0`, `v1`, `v2`. `v0` is the base point specifying the 3D position of the base of the grass blade, `v1` is the guide for the curve that is always "above" `v0` and defines the blade's up direction, and `v2` is the control points where we execute all kinds of simulation forces. The paper provides a very detailed usage for tweaking basic 3D geometry shapes for rendering with Bezier curves (see Section 6.3 of paper). 

### Physics Simulation
As for physical simulation, we define the following basic forces:
- **Gravity force** that pulls `v2` to the ground, creating bends on the blade;
- **Recovery force** that tends to recover the up-straight pose of the blade;
- **Wind force** that produces random displacement on the tip of the blade (specifically, on `v2`).

### Blade Culling
Blade culling is an optimization technique that the paper mentions to improve FPS in real-time rendering. By culling we do not wish to render the grass blades that:
- are too far away;
- are outside the camera's view frustum;
- are not facing towards the camera.

Culling tests are conducted in the compute shader so that the number of grass blades that need rendering varies with the position and orientation of the camera.

## Visual Effects
The following images demonstrates effects due to different culling operations:
|       Orientation Culling        |       View-Frustum Culling        |       Distance Culling        |
| :------------------------------: | :-------------------------------: | :---------------------------: |
| ![](img/orientation_culling.gif) | ![](img/view_frustum_culling.gif) | ![](img/distance_culling.gif) |

The following image demonstrates the up-straight pose of the blade (no physics forces, no culling):

![](img/blade_upstraight.png)

## Performance Analysis 
The following FPS tests on different culling options is conducted with `NUM_BLADES = 1 << 18`:

![](img/performance_analysis.png)

We can see that orientation culling improves the rendering FPS the most, while all the others also have some improvements on the FPS.
