#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
  mat4 view;
  mat4 proj;
}
camera;

// Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
  // Compute fragment color
  vec3 dark_green  = vec3(0.0, 0.2, 0.0);
  vec3 light_green = vec3(0.0, 0.8, 0.0);
  vec3 light       = normalize(vec3(1.0, 1.0, 1.0));

  // 1. compute color; mixing from dark to light green
  vec3 color = mix(dark_green, light_green, uv.y);

  // 2. compute lambertian shading
  float lambert_diffuse = dot(vec3(nor), light);
  float lambert_ambient = 0.2;
  float light_intensity = clamp(lambert_diffuse, 0, 1) + lambert_ambient;

  outColor = vec4(light_intensity * color, 1.0);
}
