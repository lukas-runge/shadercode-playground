#version 300 es
uniform float uTime;
uniform float uAspect;
out vec3 vColor;

void main() {
    // Generate cube vertices from vertex ID (6 faces * 2 triangles * 3 vertices = 36)
    int vertexIndex = gl_VertexID;
    int faceIndex = vertexIndex / 6;
    int vertInFace = vertexIndex % 6;

    // Cube vertices
    vec3 cubeVertices[8] = vec3[8](vec3(-0.5f, -0.5f, -0.5f), // 0
    vec3(0.5f, -0.5f, -0.5f), // 1
    vec3(0.5f, 0.5f, -0.5f), // 2
    vec3(-0.5f, 0.5f, -0.5f), // 3
    vec3(-0.5f, -0.5f, 0.5f), // 4
    vec3(0.5f, -0.5f, 0.5f), // 5
    vec3(0.5f, 0.5f, 0.5f), // 6
    vec3(-0.5f, 0.5f, 0.5f)  // 7
    );

				// Face indices (each face is 2 triangles)
    int faces[36] = int[36](
    // Front face
    4, 5, 6, 4, 6, 7,
    // Back face
    1, 0, 3, 1, 3, 2,
    // Top face
    7, 6, 2, 7, 2, 3,
    // Bottom face
    0, 1, 5, 0, 5, 4,
    // Right face
    5, 1, 2, 5, 2, 6,
    // Left face
    0, 4, 7, 0, 7, 3);

    // Colors for each face
    vec3 faceColors[6] = vec3[6](vec3(1.0f, 0.0f, 0.0f), // Front - red
    vec3(0.0f, 1.0f, 0.0f), // Back - green
    vec3(0.0f, 0.0f, 1.0f), // Top - blue
    vec3(1.0f, 1.0f, 0.0f), // Bottom - yellow
    vec3(1.0f, 0.0f, 1.0f), // Right - magenta
    vec3(0.0f, 1.0f, 1.0f)  // Left - cyan
    );

    vColor = faceColors[faceIndex];

    vec3 pos = cubeVertices[faces[vertexIndex]];

    // Rotate the cube
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