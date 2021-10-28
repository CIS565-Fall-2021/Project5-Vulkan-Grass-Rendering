#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

layout(location = 0) out vec4 out_v1[];
layout(location = 1) out vec4 out_v2[];
layout(location = 2) out vec4 out_up[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID]; 
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID]; 
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

	// TODO: Set level of tesselation
    float o = 64, i = min(o * (in_v2[0].w/in_v1[0].w), 64); // TODO: change based on distance from camera 
    gl_TessLevelInner[0] = i;
    gl_TessLevelInner[1] = i;
    gl_TessLevelOuter[0] = o;
    gl_TessLevelOuter[1] = o;
    gl_TessLevelOuter[2] = o;
    gl_TessLevelOuter[3] = o;
}
