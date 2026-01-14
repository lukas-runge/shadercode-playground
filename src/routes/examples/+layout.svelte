<script lang="ts">
	import { page } from '$app/stores';

	let { children } = $props();

	const exampleNames: Record<string, string> = {
		'/examples/cube': 'Rotating Cube',
		'/examples/obj': '3D OBJ Model'
	};

	const exampleName = $derived(exampleNames[$page.url.pathname] || 'Example');
</script>

<div class="example-page">
	<nav class="top-bar">
		<div class="container">
			<a href="/" class="back-link" aria-label="Go back to home">
				<svg
					class="icon"
					viewBox="0 0 24 24"
					fill="none"
					stroke="currentColor"
					stroke-width="2"
					stroke-linecap="round"
					stroke-linejoin="round"
				>
					<path d="M19 12H5M12 19l-7-7 7-7" />
				</svg>
			</a>
			<div class="title">{exampleName}</div>
		</div>
	</nav>

	<main class="example-content">
		{@render children()}
	</main>
</div>

<style>
	.example-page {
		width: 100%;
		height: 100vh;
		display: flex;
		flex-direction: column;
	}

	.top-bar {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		height: 56px;
		background: rgba(0, 0, 0, 0.6);
		backdrop-filter: blur(20px) saturate(180%);
		border-bottom: 1px solid rgba(255, 255, 255, 0.08);
		z-index: 100;
	}

	.container {
		max-width: 100%;
		margin: 0 auto;
		height: 100%;
		padding: 0 20px;
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
	}

	.back-link {
		position: absolute;
		left: 20px;
		display: flex;
		align-items: center;
		justify-content: center;
		width: 36px;
		height: 36px;
		color: rgba(255, 255, 255, 0.7);
		text-decoration: none;
		border-radius: 6px;
		transition: all 0.2s ease;
	}

	.back-link:hover {
		color: rgba(255, 255, 255, 1);
		background: rgba(255, 255, 255, 0.08);
	}

	.back-link .icon {
		width: 20px;
		height: 20px;
	}

	.title {
		font-size: 14px;
		font-weight: 500;
		color: rgba(255, 255, 255, 0.9);
		letter-spacing: -0.01em;
	}

	.example-content {
		flex: 1;
		width: 100%;
		height: 100%;
	}
</style>
