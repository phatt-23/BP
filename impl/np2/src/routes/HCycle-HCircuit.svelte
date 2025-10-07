<script lang="ts">
    import { reduce } from "../lib/reductions/reduce";
    import { graphDemos, getRandomDemo } from "../lib/demos/demos";
    import { 
        formatGraphToInputString, 
        parseGraphInput, 
        parseGraphInstance, 
        VerifyGraphInstanceFormat, 
        type Graph 
    } from "../lib/models/graph";

    import GraphElement from "../lib/ui/components/GraphElement.svelte";
    import ReductionPanel from "../lib/ui/components/ReductionPanel.svelte";

    let hamCycleInstance = $state(getRandomDemo(graphDemos));
    let hamCycleInput = $state("");
    let hamCircuitInput = $state("");

    let hamCycleGraph = $state<Graph>({ vertices: [], edges: [] }); 
    let hamCircuitGraph = $state<Graph>({ vertices: [], edges: [] }); 

    function onConvertClick() {
        if (!VerifyGraphInstanceFormat(hamCycleInstance)) {
            hamCycleInput = "WRONG FORMAT!";
            return;
        }

        hamCycleGraph = parseGraphInstance(hamCycleInstance);
        hamCycleInput = formatGraphToInputString(hamCycleGraph);
    
        hamCircuitInput = reduce("HamCycle-HamCircuit", hamCycleInput);
        hamCircuitGraph = parseGraphInput(hamCircuitInput);
    }
</script>

<h1>HamCycle to HamCircuit</h1>
<p>
    Hamiltonian Cycle Problem uses directed graph. 
    Meanwhile Hamiltonian Circuit Problem uses undirected graph.
</p>

<hr />
<ReductionPanel
    inProblem={"HamCycle"}
    outProblem={"HamCircuit"}
    bind:inInstance={hamCycleInstance}
    inInput={hamCycleInput}
    outInput={hamCircuitInput}
    onConvertClick={onConvertClick}
    demoInstances={graphDemos}
/>

<h2>HamCycle Graph</h2>
<GraphElement layout={"HamCycle"} graph={hamCycleGraph} />

<h2>HamCircuit Graph</h2>
<GraphElement layout={"HamCircuit-From-HamCycle"} graph={hamCircuitGraph} />

