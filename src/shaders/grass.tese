#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUp[];

layout(location = 0) out float height;
layout(location = 1) out vec3 n;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = vec3(inV0[0]);
    vec3 v1 = vec3(inV1[0]);
    vec3 v2 = vec3(inV2[0]);
    float width = inV2[0].w;
    float ori = inV0[0].w;
    vec3 t1 = normalize(vec3(cos(ori), 0.0, sin(ori)));

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    vec3 t0 = normalize(b - a);
    n = normalize(cross(t0, t1));

    float t = u - u * v;
    height = v;
    gl_Position = camera.proj * camera.view * vec4(mix(c0, c1, t), 1.0);
}
