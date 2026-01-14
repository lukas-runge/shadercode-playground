#version 300 es
uniform float uTime;
uniform float uAspect;
in vec3 aPosition;
in vec3 aNormal;
out vec3 vColor;

void main() {
    vec3 pos = aPosition * 0.5f;

    // Rotate the model
    float angle = uTime;
    float s = sin(angle);
    float c = cos(angle);

    // Rotate around Y axis
    mat3 rotationY = mat3(c, 0.0f, s, 0.0f, 1.0f, 0.0f, -s, 0.0f, c);

    // Rotate around X axis
    float angleX = uTime * 0.7f;
    float sx = sin(angleX);
    float cx = cos(angleX);
    mat3 rotationX = mat3(1.0f, 0.0f, 0.0f, 0.0f, cx, -sx, 0.0f, sx, cx);

    pos = rotationY * rotationX * pos;

    // Rotate normal for lighting
    vec3 normal = rotationY * rotationX * aNormal;

    // Simple lighting based on normal
    vec3 lightDir = normalize(vec3(1.0f, 1.0f, 1.0f));
    float diffuse = max(dot(normal, lightDir), 0.0f);
    vColor = vec3(0.8f, 0.6f, 0.4f) * (0.3f + 0.7f * diffuse);

    // Perspective projection
    float fov = 1.5f;
    float near = 0.1f;
    float far = 100.0f;

    // Move camera back
    pos.z -= 2.0f;

    // Perspective divide
    float f = 1.0f / tan(fov / 2.0f);
    vec4 projected = vec4(pos.x * f / uAspect, pos.y * f, pos.z * (far + near) / (near - far) + (2.0f * far * near) / (near - far), -pos.z);

    gl_Position = projected;
}
