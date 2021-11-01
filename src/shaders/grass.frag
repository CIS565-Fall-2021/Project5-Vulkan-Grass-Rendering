#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in float vCoord;
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec4 grassColor = vec4(.24, .59, .09, 1.0);

    float verticalMultiplier = (1 - vCoord) * 0.1 + vCoord * 1.5;
    
    outColor = verticalMultiplier * grassColor;
} 
