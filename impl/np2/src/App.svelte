<script>
    import Router, { link } from "svelte-spa-router";
    import { onMount } from "svelte";
    import cyCanvas from "cytoscape-canvas";
    import cytoscape from "cytoscape";

    import Home from "./routes/Home.svelte";
    import R_3SAT_HCycle from "./routes/3SAT-HCycle.svelte";
    import R_3SAT_SSP from "./routes/3SAT-SSP.svelte";
    import R_3SAT_3DM from "./routes/3SAT-3DM.svelte";
    import R_HCycle_HCircuit from "./routes/HCycle-HCircuit.svelte";
    import R_HCircuit_TSP from "./routes/HCircuit-TSP.svelte";

    // initialize cy canvas plugin
    onMount(() => {
        cyCanvas(cytoscape);
    });

    // define route elements
    const routes = {
        "/": Home,
        "/3sat-hcycle": R_3SAT_HCycle,
        "/3sat-3dm": R_3SAT_3DM,
        "/3sat-ssp": R_3SAT_SSP,
        "/hcycle-hcircuit": R_HCycle_HCircuit,
        "/hcircuit-tsp": R_HCircuit_TSP,
    };
</script>

<!-- nav bar -->
<nav>
    <a use:link href="/">NP2</a>
    <a use:link href="/3sat-hcycle">3-SAT to H-Cycle</a>
    <a use:link href="/hcycle-hcircuit">H-Cycle to H-Circuit</a>
    <a use:link href="/hcircuit-tsp">HamCircuit to TSP</a>
    <a use:link href="/3sat-ssp">3-SAT to SSP</a>
    <a use:link href="/3sat-3dm">3-SAT to 3DM</a>
</nav>

<!-- the current route element gets put here -->
<Router {routes} />

<style>
    a {
        padding: 10px;
        border: solid black;
    }
</style>
