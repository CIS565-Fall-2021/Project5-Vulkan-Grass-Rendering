#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec3 n;
layout (location = 1) in vec2 uv;

layout(location = 0) out vec4 frag_color;

void main() {
    vec4 color_top = vec4(0, 0.788, 0.263, 1.0);
    vec4 color_bottom = vec4(0, 0.439, 0.294, 1.0);
    frag_color = mix(color_bottom, color_top, uv[1]);
}
