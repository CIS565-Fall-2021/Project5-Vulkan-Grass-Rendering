#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
  mat4 view;
  mat4 proj;
}
camera;

// Declare tessellation evaluation shader inputs and outputs
//  The number of control points for each input batch is defined in
//    `layout(vertices = ???) out;`
//  in the tessellation control shader
layout(location = 0) in vec4 v0[];  // v0.w -- orientation
layout(location = 1) in vec4 v1[];  // v1.w -- height
layout(location = 2) in vec4 v2[];  // v2.w -- width
layout(location = 3) in vec4 up[];  // up.w -- stiffness

layout(location = 0) out vec4 pos;
layout(location = 1) out vec4 nor;
layout(location = 2) out vec2 uv;

void main() {
  float u = gl_TessCoord.x;
  float v = gl_TessCoord.y;

  // Use u and v to parameterize along the grass blade and output
  //  positions for each vertex of the grass blade
  // Implements De Casteljau's algorithm as described in paper
  //
  vec3 t1 = vec3(sin(v0[0].w), 0.f, cos(v0[0].w));  // bitangent
  vec3 a  = vec3(v0[0] + v * (v1[0] - v0[0]));
  vec3 b  = vec3(v1[0] + v * (v2[0] - v1[0]));
  vec3 c  = a + v * (b - a);
  vec3 c0 = c - v2[0].w * t1;
  vec3 c1 = c + v2[0].w * t1;
  vec3 t0 = normalize(b - a);          // interpolated tangent
  vec3 n  = normalize(cross(t0, t1));  // interpolated normal

  // vertex for basic shape
  // use quad
  float t = u;
  vec3 p  = mix(c0, c1, t);

  // calculate outputs
  pos         = vec4(p, 1.f);
  nor         = vec4(n, 0.f);
  uv          = vec2(u, v);
  gl_Position = camera.proj * camera.view * pos;
}
