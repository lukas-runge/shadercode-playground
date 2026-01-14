export function parseObj(objText: string) {
	const vertices: number[] = [];
	const normals: number[] = [];

	const lines = objText.split('\n');
	const objVertices: number[][] = [];
	const objNormals: number[][] = [];

	for (const line of lines) {
		const parts = line.trim().split(/\s+/);
		if (parts[0] === 'v') {
			objVertices.push([parseFloat(parts[1]), parseFloat(parts[2]), parseFloat(parts[3])]);
		} else if (parts[0] === 'vn') {
			objNormals.push([parseFloat(parts[1]), parseFloat(parts[2]), parseFloat(parts[3])]);
		} else if (parts[0] === 'f') {
			// Parse face: supports both v/vt/vn and v//vn formats
			const faceIndices = [];
			for (let i = 1; i < parts.length; i++) {
				const indices = parts[i].split('/');
				const vertexIndex = parseInt(indices[0]) - 1;
				const normalIndex = parseInt(indices[indices.length - 1]) - 1; // Last index is always normal
				faceIndices.push({ v: vertexIndex, n: normalIndex });
			}

			// Convert quad to two triangles if needed
			if (faceIndices.length === 4) {
				// Triangle 1: 0, 1, 2
				vertices.push(...objVertices[faceIndices[0].v]);
				normals.push(...objNormals[faceIndices[0].n]);
				vertices.push(...objVertices[faceIndices[1].v]);
				normals.push(...objNormals[faceIndices[1].n]);
				vertices.push(...objVertices[faceIndices[2].v]);
				normals.push(...objNormals[faceIndices[2].n]);

				// Triangle 2: 0, 2, 3
				vertices.push(...objVertices[faceIndices[0].v]);
				normals.push(...objNormals[faceIndices[0].n]);
				vertices.push(...objVertices[faceIndices[2].v]);
				normals.push(...objNormals[faceIndices[2].n]);
				vertices.push(...objVertices[faceIndices[3].v]);
				normals.push(...objNormals[faceIndices[3].n]);
			} else if (faceIndices.length === 3) {
				// Already a triangle
				for (const fv of faceIndices) {
					vertices.push(...objVertices[fv.v]);
					normals.push(...objNormals[fv.n]);
				}
			}
		}
	}

	return { vertices, normals, facesCount: vertices.length / 3 };
}
