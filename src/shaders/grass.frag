#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in float v;
layout(location = 1) in vec3 n;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec4 color = vec4(52.0, 140.0, 49.0, 255.0) / 255.0;

    vec3 lightDir = normalize(vec3(0, 0, 1));
    float diffuseTerm = clamp(dot(n, lightDir), 0.0, 1.0);
    float ambientTerm = 0.2;
    float lightIntensity = diffuseTerm + ambientTerm; 

    outColor = color * lightIntensity;
}
