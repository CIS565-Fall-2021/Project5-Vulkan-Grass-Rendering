#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare fragment shader inputs
layout(location = 0) in vec3 nor;
layout(location = 1) in float param_height;

layout(location = 0) out vec4 outColor;

void main() {
    // DONE: Compute fragment color
    vec4 light_green = vec4(127.f, 212.f, 78.f, 255.f) / 255.f;
    vec4 dark_green  = vec4(26.f, 102.f, 26.f, 255.f) / 255.f;
    vec4 color = mix(light_green, dark_green, 1 - param_height);

    outColor = color;
}
