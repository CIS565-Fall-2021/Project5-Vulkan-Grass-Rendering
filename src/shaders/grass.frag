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
    
    // Lighting Parameters
    vec3 lightColor = vec3(1.0, 1.0, 1.0);
    vec3 albedo = vec3(0.0, 0.8, 0.0);
    vec3 lightPos = vec3(0.0, 10.0, 0.0);

    // Ambient Lighting
    float ka = 0.2;
    vec3 ambient = ka * lightColor;

    // Diffuse Lighting
    vec3 l = normalize(lightPos - pos);
    float kd = abs(dot(-n, l));
    vec3 diffuse = kd * lightColor;

    vec3 result = (ambient + diffuse) * albedo;

    outColor = vec4(result, 1.0);
}
