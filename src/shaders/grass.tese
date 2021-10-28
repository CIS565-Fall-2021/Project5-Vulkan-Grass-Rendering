#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

// functions
float noise1D(vec2 p);

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec4 v0 = vec4(gl_in[0].gl_Position.xyz, 1.f);
    vec4 v1 = vec4(in_v1[0].xyz, 1.f);
    vec4 v2 = vec4(in_v2[0].xyz, 1.f);
    vec4 up = vec4(in_up[0].xyz, 1.f);
    float theta = gl_in[0].gl_Position.w;
    float height = in_v1[0].w;
    float width = in_v2[0].w;

    // TODO: Assumes up is (0, 1, 0), should be changed to a more generic solution
    vec4 t1 = vec4(cos(theta) * up.x + sin(theta) * up.z, 
                   0, 
                   -sin(theta) * up.x + cos(theta) * up.z, 
                   1.f); 

    vec4 a = v0 + v * (v1 - v0);
    vec4 b = v1 + v * (v2 - v0);
    vec4 c = a + v * (b - a);
    vec4 c0 = c - width * t1;
    vec4 c1 = c + width * t1;
    vec4 t0 = normalize(b-a);
    vec4 n = vec4(cross(normalize(t0.xyz), normalize(t1.xyz)), 1.f);

    float rand = noise1D(vec2(v0.x, v0.z));

    float t;
    if (rand > 0.75)
    {
        // quad
        t = u;
    } 
    else if (rand > 0.5)
    {
        // triangles
        t = u + 0.5 * v - u * v;
    }
    else if (rand > 0.25)
    {
        // quadratic
        t = u - u * v * v;
    }
    else
    {
        // triangle-tip
        float thresh = noise1D(vec2(c0.x, c1.x));
        t = 0.5 + (u - 0.5) * (1 - max(v - thresh, 0)/(1 - thresh));
    }

    // 3D displacement
    vec4 d = width * n * (0.5 - abs(u - 0.5) * (1 - v));

    // TODO: width correction?

    gl_Position = (1 - t) * c0 + t * c1 + d;
}

// Taken from CIS 460
float noise1D(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}
