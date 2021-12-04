#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Done: Declare fragment shader inputs
layout(location = 0) in vec2 inUV;
layout(location = 1) in float inHeight;

layout(location = 0) out vec4 outColor;

void main() {
    // Done: Compute fragment color
    vec3 lightGreen = vec3(199.0, 232.0, 146.0) * (1.0 / 255.0);
    vec3 medGreen = vec3(119.0, 150.0, 69.0) * (1.0 / 255.0);
    vec3 darkGreen = vec3(59.0, 79.0, 26.0) * (1.0 / 255.0);
    float t = inUV.y * inHeight / 2.5f; // max height of 2.5

    vec3 color = mix(mix(lightGreen, medGreen, t), mix(medGreen, darkGreen, t), t);

    outColor = vec4(color, 1.0);
}
