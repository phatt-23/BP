<script lang="ts">
    import { reduce } from "../lib/reductions/reduce";
    import { 
        parseGraphInput, 
        type Graph 
    } from "../lib/models/graph";
    import { 
        satDemos, 
        getRandomDemo
    } from "../lib/demos/demos";
    import { 
        verifySatInstanceFormat, 
        parseSatInstance, 
        formatSatToInputString, 
        type SatExpression 
    } from "../lib/models/sat";

    import SatFormula from "../lib/ui/components/SatFormula.svelte";
    import GraphElement from "../lib/ui/components/GraphElement.svelte";
    import ReductionPanel from "../lib/ui/components/ReductionPanel.svelte";

    let satInstance = $state(getRandomDemo(satDemos));
    let sat = $state<SatExpression>({ variables: [], clauses: [] });
    let satInput = $state("");
    let hamCycleInput = $state("");
    let hamCycleInputGraph = $state<Graph>({ vertices: [], edges: [] });

    function onConvertClick() {
        if (!verifySatInstanceFormat(satInstance)) {
            satInput = "WRONG FORMAT :(";
            return;
        }

        sat = parseSatInstance(satInstance);
        satInput = formatSatToInputString(sat);

        hamCycleInput = reduce("3SAT-HamCycle", satInput);
        hamCycleInputGraph = parseGraphInput(hamCycleInput);
    }
</script>

<h1>3-SAT to H-Cycle</h1>
<hr />

<ReductionPanel 
    inProblem={"3SAT"}
    outProblem={"HamCycle"}
    bind:inInstance={satInstance}
    inInput={satInput}
    outInput={hamCycleInput}
    onConvertClick={onConvertClick}
    demoInstances={satDemos}
/>

<h2>Boolean Formula</h2>
<SatFormula {sat} />

<h2>HamCycle Graph</h2>
<GraphElement layout={"HamCycle-From-3SAT"} graph={hamCycleInputGraph}></GraphElement>


