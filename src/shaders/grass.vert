
#version 450
#extension GL_ARB_separate_shader_objects : enable

// NOTE: The VS is executed on each patch (i.e. grass blade), containing all CPs. 
// The patch comprises several CPs from the vertex buffer.

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 in_v0;
layout (location = 1) in vec4 in_v1;
layout (location = 2) in vec4 in_v2;
layout (location = 3) in vec4 in_up;

layout(location = 0) out vec4 tcs_v1;
layout(location = 1) out vec4 tcs_v2;
layout(location = 2) out vec4 tcs_up;

out gl_PerVertex {
    vec4 gl_Position;
};

vec4 multiply(mat4 m, vec4 v) {
    vec4 ans = m * vec4(v.xyz, 1.0);
    ans.w = v.w;
    return ans;
}

void main() {
	// TODO: Write gl_Position and any other shader outputs

    // Convert all vectors from local space to world space

    tcs_v1 = multiply(model, in_v1);
    tcs_v2 = multiply(model, in_v2);
    tcs_up = multiply(model, in_up);

    // Store v0 as gl_Position
    gl_Position = multiply(model, in_v0);
}
