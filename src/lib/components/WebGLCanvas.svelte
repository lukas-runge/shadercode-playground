<script lang="ts">
	import { onMount, onDestroy } from 'svelte';

	export let vertexShader: string;
	export let fragmentShader: string;
	export let geometry: { vertices: number[]; normals: number[]; facesCount: number } | null = null;
	export let fullscreen = false;

	let canvas: HTMLCanvasElement;
	let animationId: number;
	let gl: WebGL2RenderingContext | null;

	onMount(() => {
		if (fullscreen) {
			canvas.width = window.innerWidth;
			canvas.height = window.innerHeight;
		} else {
			const rect = canvas.getBoundingClientRect();
			canvas.width = rect.width * window.devicePixelRatio;
			canvas.height = rect.height * window.devicePixelRatio;
		}

		gl = canvas.getContext('webgl2');
		if (!gl) return;

		try {
			// Compile shaders
			const vertShader = gl.createShader(gl.VERTEX_SHADER)!;
			gl.shaderSource(vertShader, vertexShader);
			gl.compileShader(vertShader);

			if (!gl.getShaderParameter(vertShader, gl.COMPILE_STATUS)) {
				console.error('Vertex shader error:', gl.getShaderInfoLog(vertShader));
				return;
			}

			const fragShader = gl.createShader(gl.FRAGMENT_SHADER)!;
			gl.shaderSource(fragShader, fragmentShader);
			gl.compileShader(fragShader);

			if (!gl.getShaderParameter(fragShader, gl.COMPILE_STATUS)) {
				console.error('Fragment shader error:', gl.getShaderInfoLog(fragShader));
				return;
			}

			// Create program
			const program = gl.createProgram()!;
			gl.attachShader(program, vertShader);
			gl.attachShader(program, fragShader);
			gl.linkProgram(program);

			if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
				console.error('Program link error:', gl.getProgramInfoLog(program));
				return;
			}

			gl.useProgram(program);

			// Get uniform locations
			const uTimeLocation = gl.getUniformLocation(program, 'uTime');
			const uAspectLocation = gl.getUniformLocation(program, 'uAspect');

			if (uAspectLocation) {
				gl.uniform1f(uAspectLocation, canvas.width / canvas.height);
			}

			// Create VAO
			const vao = gl.createVertexArray();
			gl.bindVertexArray(vao);

			// Set up geometry if provided
			let vertexCount = 36; // Default for cube
			if (geometry) {
				// Get attribute locations
				const aPositionLocation = gl.getAttribLocation(program, 'aPosition');
				const aNormalLocation = gl.getAttribLocation(program, 'aNormal');

				// Create and bind position buffer
				if (aPositionLocation !== -1) {
					const positionBuffer = gl.createBuffer();
					gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
					gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(geometry.vertices), gl.STATIC_DRAW);
					gl.enableVertexAttribArray(aPositionLocation);
					gl.vertexAttribPointer(aPositionLocation, 3, gl.FLOAT, false, 0, 0);
				}

				// Create and bind normal buffer
				if (aNormalLocation !== -1) {
					const normalBuffer = gl.createBuffer();
					gl.bindBuffer(gl.ARRAY_BUFFER, normalBuffer);
					gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(geometry.normals), gl.STATIC_DRAW);
					gl.enableVertexAttribArray(aNormalLocation);
					gl.vertexAttribPointer(aNormalLocation, 3, gl.FLOAT, false, 0, 0);
				}

				vertexCount = geometry.facesCount;
			}

			// Enable depth testing
			gl.enable(gl.DEPTH_TEST);

			// Animation loop
			function render(time: number) {
				if (!gl) return;

				gl.clearColor(0.1, 0.1, 0.1, 1.0);
				gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

				if (uTimeLocation) {
					gl.uniform1f(uTimeLocation, time * 0.001);
				}

				gl.drawArrays(gl.TRIANGLES, 0, vertexCount);

				animationId = requestAnimationFrame(render);
			}

			animationId = requestAnimationFrame(render);
		} catch (e) {
			console.error('WebGL setup error:', e);
		}
	});

	onDestroy(() => {
		if (animationId) {
			cancelAnimationFrame(animationId);
		}
	});
</script>

<canvas bind:this={canvas}></canvas>

<style>
	canvas {
		width: 100%;
		height: 100%;
		display: block;
	}
</style>
