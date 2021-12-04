#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Done: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4[] inV0;
layout(location = 1) in vec4[] inV1;
layout(location = 2) in vec4[] inV2;

layout(location = 0) out vec2 outUV;
layout(location = 1) out float outHeight;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// Done: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = inV0[0].xyz;
    vec3 v1 = inV1[0].xyz;
    vec3 v2 = inV2[0].xyz;
    float orientation = inV0[0].w;
    float w = inV2[0].w;

    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);
    vec3 t1 = normalize(vec3(cos(orientation), 0.0, sin(orientation))); 
    vec3 c0  = c - w * t1;
    vec3 c1 = c + w * t1;

    //triangle shape
    float t = u + 0.5 * v - u * v;
    vec4 pos = vec4(mix(c0, c1, t), 1.0);

    outUV = vec2(u, v);
    outHeight = inV1[0].w;
    gl_Position = camera.proj * camera.view * pos;
}
