<script lang="ts">
    import Router, { link } from "svelte-spa-router";
    import Home from "./lib/UI/Pages/Home.svelte";
    import ThreeSATToHCycle from "./lib/UI/Pages/3SAT-to-HCycle.svelte";
</script>

<h1>NP2</h1>

<nav>
    <a use:link href="/">NP2</a>
    <a use:link href="/3sat-hcycle">3-SAT to H-Cycle</a>
</nav>

<Router routes={{
    "/": Home,
    "/3sat-hcycle": ThreeSATToHCycle,
}} />

