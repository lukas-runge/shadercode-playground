<script lang="ts">
	import WebGLCanvas from './WebGLCanvas.svelte';

	export let title: string;
	export let description: string;
	export let href: string;
	export let vertexShader: string;
	export let fragmentShader: string;
	export let geometry: { vertices: number[]; normals: number[]; facesCount: number } | null = null;
</script>

<a {href} class="example-card group">
	<div class="canvas-container">
		<WebGLCanvas {vertexShader} {fragmentShader} {geometry} />
		<div class="overlay">
			<span class="view-text">View Example →</span>
		</div>
	</div>
	<div class="content">
		<h3>{title}</h3>
		<p>{description}</p>
	</div>
</a>

<style>
	.example-card {
		display: block;
		background: #1a1a1a;
		border-radius: 12px;
		overflow: hidden;
		transition:
			transform 0.3s ease,
			box-shadow 0.3s ease;
		text-decoration: none;
		color: inherit;
		border: 1px solid #333;
	}

	.example-card:hover {
		transform: translateY(-4px);
		box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
		border-color: #555;
	}

	.canvas-container {
		position: relative;
		width: 100%;
		height: 250px;
		background: #0a0a0a;
		overflow: hidden;
	}

	canvas {
		width: 100%;
		height: 100%;
		display: block;
	}

	.overlay {
		position: absolute;
		inset: 0;
		background: rgba(0, 0, 0, 0.6);
		display: flex;
		align-items: center;
		justify-content: center;
		opacity: 0;
		transition: opacity 0.3s ease;
	}

	.example-card:hover .overlay {
		opacity: 1;
	}

	.view-text {
		color: white;
		font-size: 18px;
		font-weight: 600;
		transform: translateY(10px);
		transition: transform 0.3s ease;
	}

	.example-card:hover .view-text {
		transform: translateY(0);
	}

	.content {
		padding: 20px;
	}

	h3 {
		margin: 0 0 8px 0;
		font-size: 20px;
		font-weight: 600;
		color: #fff;
	}

	p {
		margin: 0;
		font-size: 14px;
		color: #999;
		line-height: 1.5;
	}
</style>
