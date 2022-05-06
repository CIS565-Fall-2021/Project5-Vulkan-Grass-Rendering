#version 450
#extension GL_ARB_separate_shader_objects : enable

// NOTE: this is the configuration for the TSE
layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4 tes_v1[];
layout(location = 1) in vec4 tes_v2[];
layout(location = 2) in vec4 tes_up[];

layout(location = 0) out vec3 fs_pos;
layout(location = 1) out vec3 fs_n;

vec3 lerp(vec3 v1, vec3 v2, float u){
    return (1 - u) * v1 + u * v2;
}

void main() {

    vec3 v0 = gl_in[0].gl_Position.xyz;
    float theta = gl_in[0].gl_Position.w;
    vec3 v1 = tes_v1[0].xyz;
    vec3 v2 = tes_v2[0].xyz;
    vec3 up = tes_up[0].xyz;
    float w = tes_v2[0].w; //width

    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    // De Casteljau's Algorithm
    vec3 a = lerp(v0, v1, v);
    vec3 b = lerp(v1, v2, v);
    vec3 c = lerp(a, b, v);

    // Calculate bitangent vector along the width of the blade
    vec3 t1 = vec3(-cos(theta), 0, sin(theta));
    normalize(t1);

    vec3 t0 = normalize(b - a);

    fs_n = normalize(cross(t0, t1));

    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;

    float t = u + 0.5*v - u*v;
    vec3 pos = lerp(c0, c1, t);

    fs_pos = pos;  // vertex position in world space

    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);  // transform to clip space
}
