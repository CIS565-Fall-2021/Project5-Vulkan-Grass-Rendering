#version 450
#extension GL_ARB_separate_shader_objects : enable

#define TESSLEVEL 10.0

// NOTE: The TCS takes an input patch and emits an output patch.
// The group of CPs (Control Points) is called a patch
// The input patch is the vertices from vertex shader.
// The output patch are the control points for the bezier curve?

//layout(vertices = 3) out;  // output patch control points
layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4 tcs_v1[];
layout(location = 1) in vec4 tcs_v2[];
layout(location = 2) in vec4 tcs_up[];

layout(location = 0) out vec4 tes_v1[];
layout(location = 1) out vec4 tes_v2[];
layout(location = 2) out vec4 tes_up[];

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];


/*
float GetTessLevel(float d0, float d1){
    float avg = (d0 + d1)/2.0;
    if (avg <= 2.0)
        return 10.0;
    else if (avg <= 5.0)
        return 7.0;
    else
        return 3.0;
}
*/

// NOTE: This function is executed once per output CP and the builtin variable gl_InvocationID contains the index of the current invocation.
void main() {
    
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    tes_v1[gl_InvocationID] = tcs_v1[gl_InvocationID];
    tes_v2[gl_InvocationID] = tcs_v2[gl_InvocationID];
    tes_up[gl_InvocationID] = tcs_up[gl_InvocationID];
    
    // NOTE: The TLs determine the Tessellation level of detail - how many triangles to generate for the patch 
    gl_TessLevelInner[0] = TESSLEVEL;
    gl_TessLevelInner[1] = TESSLEVEL;
    gl_TessLevelOuter[0] = TESSLEVEL;
    gl_TessLevelOuter[1] = TESSLEVEL;
    gl_TessLevelOuter[2] = TESSLEVEL;
    gl_TessLevelOuter[3] = TESSLEVEL;
}
