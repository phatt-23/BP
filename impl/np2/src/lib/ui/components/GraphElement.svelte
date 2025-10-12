<script lang="ts">
    import cytoscape, { type ElementDefinition } from "cytoscape";
    import { type GraphInstance } from '../../models/GraphInstance'
    import { drawConvexHullsFor3DM, layoutGraphToCy, styleCy, type GraphLayout } from '../../reductions/cy-graph'

    type Props = { 
        graph: GraphInstance;
        layout?: GraphLayout
    };

    let { graph, layout = "default" }: Props = $props();

    let graphContainer: HTMLElement;

    $effect(() => {
        let cy = cytoscape({ 
            container: graphContainer, 
        });
        
        layoutGraphToCy(cy, graph, layout);
        styleCy(cy, layout);

        if (layout == "3DM-from-3-SAT") {
            drawConvexHullsFor3DM(cy, graph);
        }
    });
</script>

<div id="cy" bind:this={graphContainer}></div>

<style>
    #cy {
        width: 80%;
        height: 50em;
        border: solid black;
    }
</style>
