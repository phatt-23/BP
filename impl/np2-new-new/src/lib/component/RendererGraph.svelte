<!--
Created by phatt-23 on 12/10/2025
-->

<script lang="ts">
    import { cytoscapeStyles } from "$lib/core/cytoscapeStyles";
    import type { Graph } from "$lib/instance/Graph.svelte";
    import cytoscape, { type ElementDefinition } from "cytoscape";

    type Props = {
        graph: Graph;
        style?: keyof typeof cytoscapeStyles;
    }

    let { graph, style = 'DEFAULT_STYLE' }: Props = $props();
    let graphContainer: HTMLElement;
    let cy: cytoscape.Core; 

    $effect(() => {
        const nodes: ElementDefinition[] = graph.nodes.map(n => ({
            data: { id: n.id, label: n.id },
            position: n.position,
            classes: n.classes,
        }));

        const edges: ElementDefinition[] = graph.edges.map(e => ({
            data: { id: e.id, source: e.from, target: e.to },
            classes: e.classes,
        }));

        // Save current viewport if cytoscape instance already exists
        const currentPan = cy ? cy.pan() : { x: 0, y: 0 };
        const currentZoom = cy ? cy.zoom() : 1;

        // Initialize cytoscape only once
        if (!cy) {
            cy = cytoscape({
                container: graphContainer,
                wheelSensitivity: 5.0,
                style: cytoscapeStyles[style],
            });
        } else {
            cy.elements().remove();
        }

        cy.add([...nodes, ...edges]);
        cy.style(cytoscapeStyles[style]);

        // Restore viewport
        cy.zoom(currentZoom);
        cy.pan(currentPan);
    });
</script>

<section>
    <h2>Graph Renderer</h2>

    <div bind:this={graphContainer} id="cy"></div>
</section>

<style>
    #cy {
        width: 90%;
        height: 100em;
        border: solid black;
    }
</style>