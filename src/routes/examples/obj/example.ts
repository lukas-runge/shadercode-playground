import vertexShader from './shader.vert?raw';
import fragmentShader from './shader.frag?raw';
import objFile from '$lib/assets/3d-models/torus.obj?raw';
import { parseObj } from '$lib/helpers/parseObj';

const geometry = parseObj(objFile);

export { vertexShader, fragmentShader, geometry };
