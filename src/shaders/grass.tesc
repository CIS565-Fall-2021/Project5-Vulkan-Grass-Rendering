#version 450
#extension GL_ARB_separate_shader_objects : enable

// defines the number of control points in the output patch
layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
  mat4 view;
  mat4 proj;
}
camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 list_v0[];
layout(location = 1) in vec4 list_v1[];
layout(location = 2) in vec4 list_v2[];
layout(location = 3) in vec4 list_up[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];
layout(location = 3) out vec4 out_up[];

void main() {
  // Don't move the origin location of the patch
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

  // Write shader outputs
  // Do not change Bezier control points here
  out_v0[gl_InvocationID] = list_v0[gl_InvocationID];
  out_v1[gl_InvocationID] = list_v1[gl_InvocationID];
  out_v2[gl_InvocationID] = list_v2[gl_InvocationID];
  out_up[gl_InvocationID] = list_up[gl_InvocationID];

  // Set level of tesselation
  gl_TessLevelInner[0] = 2.0;  // horizontal
  gl_TessLevelInner[1] = 2.0;  // vertical
  gl_TessLevelOuter[0] = 2.0;
  gl_TessLevelOuter[1] = 2.0;
  gl_TessLevelOuter[2] = 2.0;
  gl_TessLevelOuter[3] = 2.0;
}
