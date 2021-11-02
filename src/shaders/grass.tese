#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out float vCoord;

// functions
float noise1D(vec2 p);

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
	vCoord = v;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = gl_in[0].gl_Position.xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;
    vec3 up = in_up[0].xyz;
    float theta = in_v0[0].w;
    float height = in_v1[0].w;
    float width = in_v2[0].w;

    // TODO: Assumes up is (0, 1, 0), should be changed to a more generic solution
    vec3 t1 = vec3(cos(theta), 0, -sin(theta)); 

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    vec3 t0 = normalize(b-a);
    vec3 norm = cross(normalize(t0.xyz), normalize(t1.xyz));

    float rand = noise1D(vec2(v0.x, v0.z));

    float t;
    if (rand > 0.99)
    {
        // quad
        t = u;
    } 
    else if (rand > 0.4)
    {
        // triangles
        t = u + 0.5 * v - u * v;
    }
    else if (rand > 0.2)
    {
        // quadratic
        t = u - u * v * v;
    }
    else
    {
        // triangle-tip
        float thresh = noise1D(vec2(v0.x, v0.z));
        t = 0.5 + (u - 0.5) * (1 - max(v - thresh, 0)/(1 - thresh));
    }

    // 3D displacement
    vec3 d = width * norm * (0.5 - abs(u - 0.5) * (1 - v));

    // TODO: width correction?
    gl_Position = camera.proj * camera.view * vec4((1 - t) * c0 + t * c1 + d, 1.f);
}

// Taken from CIS 460
float noise1D(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}
