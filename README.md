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
