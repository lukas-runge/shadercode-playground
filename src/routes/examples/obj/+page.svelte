<script lang="ts">
	import WebGLCanvas from '$lib/components/WebGLCanvas.svelte';
	import { vertexShader, fragmentShader, geometry } from './example';
</script>

<WebGLCanvas {vertexShader} {fragmentShader} {geometry} fullscreen={true} />
