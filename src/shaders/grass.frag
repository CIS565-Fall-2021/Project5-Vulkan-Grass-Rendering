#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) out vec4 outColor;

layout(location = 0) in float lambertCoeff;
layout(location = 1) in vec2 uv;

void main() {
    // TODO: Compute fragment color

    // outColor = vec4(1.0);
    // outColor = lambertCoeff * vec4(0.0, 1.0, 0.0, 0.0);
    // vec4 color_top = vec4(100.0/255.0, 240.0/255.0, 90.0/255.0, 1.0);
    // vec4 color_bottom = vec4(146.0/255.0, 197.0/255.0, 130.0/255.0, 1.0);
    // outColor = lambertCoeff * mix(color_bottom, color_top, uv[1]);
    vec4 color_top = vec4(0, 240.0/255.0, 90.0/255.0, 1.0);
    vec4 color_bottom = vec4(0, 177.0/255.0, 103.0/255.0, 1.0);
    outColor = lambertCoeff * mix(color_bottom, color_top, uv[1]);
    // outColor = mix(color_bottom, color_top, uv[1]);

//     vec4 color_top = vec4(0, 0.788, 0.263, 1.0);
//     vec4 color_bottom = vec4(0, 0.439, 0.294, 1.0);
//     outColor = mix(color_bottom, color_top, uv[1]);
}
