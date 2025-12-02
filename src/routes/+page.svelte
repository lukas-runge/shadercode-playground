<script lang="ts">
	import { onMount } from 'svelte';
	import vertexShaderSource from './shader.vert?raw';
	import fragmentShaderSource from './shader.frag?raw';

	let canvas: HTMLCanvasElement;

	onMount(() => {
		// Set canvas to fullscreen
		canvas.width = window.innerWidth;
		canvas.height = window.innerHeight;

		const gl = canvas.getContext('webgl2');
		if (!gl) return;

		// Compile shaders
		const vertexShader = gl.createShader(gl.VERTEX_SHADER)!;
		gl.shaderSource(vertexShader, vertexShaderSource);
		gl.compileShader(vertexShader);

		const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER)!;
		gl.shaderSource(fragmentShader, fragmentShaderSource);
		gl.compileShader(fragmentShader);

		// Create program
		const program = gl.createProgram()!;
		gl.attachShader(program, vertexShader);
		gl.attachShader(program, fragmentShader);
		gl.linkProgram(program);
		gl.useProgram(program);

		// Get uniform locations
		const uTimeLocation = gl.getUniformLocation(program, 'uTime');
		const uAspectLocation = gl.getUniformLocation(program, 'uAspect');

		gl.uniform1f(uAspectLocation, canvas.width / canvas.height);

		// Create empty VAO (required for WebGL2)
		const vao = gl.createVertexArray();
		gl.bindVertexArray(vao);

		// Enable depth testing for 3D
		gl.enable(gl.DEPTH_TEST);

		// Animation loop
		function render(time: number) {
			if (!gl) return;

			gl.clearColor(0.1, 0.1, 0.1, 1.0);
			gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

			// Update time uniform
			gl.uniform1f(uTimeLocation, time * 0.001);

			gl.drawArrays(gl.TRIANGLES, 0, 36);
			requestAnimationFrame(render);
		}

		requestAnimationFrame(render);
	});
</script>

<canvas bind:this={canvas}></canvas>
