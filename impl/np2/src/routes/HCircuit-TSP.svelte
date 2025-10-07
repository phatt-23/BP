<script lang="ts">
    import { reduce } from "../lib/reductions/reduce";
    import { getRandomDemo, graphDemos } from "../lib/demos/demos";
    import { 
        formatGraphToInputString, 
        parseGraphInput, 
        parseGraphInstance, 
        VerifyGraphInstanceFormat, 
        type Graph 
    } from "../lib/models/graph";

    import GraphElement from "../lib/ui/components/GraphElement.svelte";
    import ReductionPanel from "../lib/ui/components/ReductionPanel.svelte";
    
    let hamCircuitInstance = $state(getRandomDemo(graphDemos));
    let hamCircuitInput = $state("");
    let tspInput = $state("");
    let hamCircuitGraph = $state<Graph>({ vertices: [], edges: []});
    let tspGraph = $state<Graph>({ vertices: [], edges: []});

    function onConvertClick() {
        if (!VerifyGraphInstanceFormat(hamCircuitInstance)) {
            hamCircuitInput = "WRONG FORMAT!";
            return;
        }

        hamCircuitGraph = parseGraphInstance(hamCircuitInstance);
        hamCircuitInput = formatGraphToInputString(hamCircuitGraph);
    
        tspInput = reduce("HamCircuit-TSP", hamCircuitInput);
        tspGraph = parseGraphInput(tspInput);
    }
</script>

<h1>HamCircuit to TSP</h1>
<hr />
<ReductionPanel
    inProblem={"HamCircuit"}
    outProblem={"TSP"}
    bind:inInstance={hamCircuitInstance}
    inInput={hamCircuitInput}
    outInput={tspInput}
    onConvertClick={onConvertClick}
    demoInstances={graphDemos}
/>

<h2>HamCircuit Graph</h2>
<GraphElement layout={"HamCircuit"} graph={hamCircuitGraph}/>

<h2>TSP Graph</h2>
<GraphElement layout={"TSP"} graph={tspGraph}/>
