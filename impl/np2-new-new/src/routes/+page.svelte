<!-- Created by phatt-23 on 12/10/2025 -->

<script>
	// symbol for reduction in poly-time 
	const rP = '&le;<sub>p</sub>';
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<section>
	<h1>
		NP-Complete problems 2
	</h1>

	<p>
		Showcasing reductions between these NP-complete problems:
	</p>

	<ul>
		<li>3SAT {@html rP} HCYCLE</li>
		<ul>
			<li>HCYCLE {@html rP} HCIRCUIT</li>
			<ul>
				<li>HCIRCUIT {@html rP} TSP</li>            
			</ul>
		</ul>
		<li>3SAT {@html rP} SSP</li>
		<li>3SAT {@html rP} 3DM</li>
		<ul>
			<li>3DM {@html rP} SSP</li>
		</ul>
	</ul>
</section>
