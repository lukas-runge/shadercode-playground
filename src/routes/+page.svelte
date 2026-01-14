<script lang="ts">
	import ExampleCard from '$lib/components/ExampleCard.svelte';
	import * as cubeExample from './examples/cube/example';
	import * as objExample from './examples/obj/example';

	const examples = [
		{
			id: 'cube',
			title: 'Rotating Cube',
			description:
				'A colorful cube rendered with procedurally generated geometry in the vertex shader.',
			href: '/examples/cube',
			vertexShader: cubeExample.vertexShader,
			fragmentShader: cubeExample.fragmentShader,
			geometry: cubeExample.geometry
		},
		{
			id: 'obj',
			title: '3D OBJ Model',
			description: 'Load and render 3D models from OBJ files with custom shaders.',
			href: '/examples/obj',
			vertexShader: objExample.vertexShader,
			fragmentShader: objExample.fragmentShader,
			geometry: objExample.geometry
		}
	];
</script>

<div class="container">
	<header>
		<h1>ShaderCode Playground</h1>
		<p class="subtitle">Explore WebGL shader examples and experiments</p>
	</header>

	<main>
		<div class="examples-grid">
			{#each examples as example}
				<ExampleCard
					title={example.title}
					description={example.description}
					href={example.href}
					vertexShader={example.vertexShader}
					fragmentShader={example.fragmentShader}
					geometry={example.geometry}
				/>
			{/each}
		</div>
	</main>

	<footer>
		<p>Built with SvelteKit & WebGL</p>
	</footer>
</div>

<style>
	:global(body) {
		margin: 0;
		padding: 0;
		background: #0f0f0f;
		color: #fff;
		font-family:
			-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
	}

	.container {
		min-height: 100vh;
		padding: 40px 20px;
		max-width: 1200px;
		margin: 0 auto;
	}

	header {
		text-align: center;
		margin-bottom: 60px;
	}

	h1 {
		font-size: 48px;
		font-weight: 700;
		margin: 0 0 16px 0;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}

	.subtitle {
		font-size: 20px;
		color: #999;
		margin: 0;
	}

	main {
		margin-bottom: 60px;
	}

	.examples-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
		gap: 30px;
	}

	footer {
		text-align: center;
		padding-top: 40px;
		border-top: 1px solid #333;
		color: #666;
		font-size: 14px;
	}

	footer p {
		margin: 0;
	}

	@media (max-width: 768px) {
		h1 {
			font-size: 36px;
		}

		.subtitle {
			font-size: 16px;
		}

		.examples-grid {
			grid-template-columns: 1fr;
		}
	}
</style>
