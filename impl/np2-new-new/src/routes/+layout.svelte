<script lang="ts">
	import Header from '../lib/component/Header.svelte';
	import '../app.css';
    import type { LayoutProps } from './$types';

	import { instanceToInstance, plainToInstance } from 'class-transformer';
    import { Serializer } from '$lib/core/Serializer';

	let { data, children }: LayoutProps = $props();
</script>

<div class="app">
	<Header />

	<main>
		{@render children()}
	</main>

	<footer>
		<p>
			Written by TRA0163, <a href="https://github.com/phatt-23">github</a>
		</p>
	</footer>
</div>

<style>
	.app {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}

	main {
		flex: 1;
		display: flex;
		flex-direction: column;
		padding: 1rem;
		width: 100%;
		max-width: 64rem;
		margin: 0 auto;
		box-sizing: border-box;
	}

	footer {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 12px;
	}

	footer a {
		font-weight: bold;
	}
</style>
