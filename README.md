Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Zirui Zang
  * [LinkedIn](https://www.linkedin.com/in/zirui-zang/)
* Tested on: Windows 10, AMD Ryzen 7 3700X @ 3.60GHz 32GB, RTX2070 SUPER 8GB (Personal)

## Physics-based Grass Simulation in Vulkan
<p align="center">
<img src="img/no_cull.gif"
     alt="deer"
     width="600"/>
</p>

Vulkan is a low-overhead, cross-platform API, open standard for 3D graphics and computing.
This project implements grass simulation using Vulkan graphics pipeline. 
The simulation is based on this [paper].
[paper]:https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf

## Physics Features

Three force simulations are implemented:
| No Force | w/ Gravity | 
| ----------- | ----------- | 
| ![](img/no_force.gif) | ![](img/g.gif) |

| w/ Gravity & Recovery | w/ Gravity & Recovery & Wind |
| ----------- | ----------- | 
| ![](img/gr.gif) | ![](img/grw.gif) |

## Optimization Features

| Orientation Cull | View-frustum Cull | Distance Cull |
| ----------- | ----------- | ----------- |
| ![](img/cull1.gif) | ![](img/cull2.gif) | ![](img/cull3.gif) |
