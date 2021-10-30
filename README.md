Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* (TODO) YOUR NAME HERE
* Tested on: (TODO) Windows 22, i7-2222 @ 2.22GHz 22GB, GTX 222 222MB (Moore 2222 Lab)

### (TODO: Your README)

*DO NOT* leave the README to the last minute! It is a crucial part of the
project, and we will not be able to grade you without a good README.

    Compute shader (shaders/compute.comp)
    Grass pipeline stages
        Vertex shader (`shaders/grass.vert')
        Tessellation control shader (shaders/grass.tesc)
        Tessellation evaluation shader (shaders/grass.tese)
        Fragment shader (shaders/grass.frag)
    Binding of any extra descriptors you may need

    renderer.cpp
    compute.comp
    grass.frag
    grass.tesc
    grass.tese
    grass.vert

v0(3) v1(3) v2(3) up(3) h w stiff theta -> 
glm::mat4(vec0|direction, vec1|height, vec2|width, up|stiffness)

vertex shader: 
    world pos, color, normal, texture -> 
    clip coords (vec4 where xyz/w is from -1,-1 to 1,1) and attributes


Vertex Shader
*Primitive Assembly

Tessellation Control Shader
*Tessellation Primitive Generator
Tessellation Evaluation Shader
*Primitive Assembly

Geometry Shader
*Primitive Assembly

*Rasterizer
Fragment Shader
