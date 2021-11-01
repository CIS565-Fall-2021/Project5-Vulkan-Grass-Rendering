#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 n;

layout(location = 0) out vec4 outColor;

void main() {

    vec3 lightPos = vec3(5.0, 5.0, 0.0);
    vec3 l = normalize(lightPos - pos);
    
    // Lambert's cosine law
    float lambertian = abs(dot(n, l));
    float kd = 1.0;
    vec4 diffuseColor = vec4(0.0, 0.8, 0.0, 1.0);

    outColor = kd * lambertian * diffuseColor;
}
