<!-- phatt-23 2025-10-07 -->
<!-- Graph renderer using Cytoscape library -->

<script lang="ts">
    import cytoscape from "cytoscape";
    import { onMount } from "svelte";
    import type { GraphInstance } from "../../../Models/Instances/Graph"; 

    type Props = {
        graph: GraphInstance;
        highlight: string[];
    };

    const { graph, highlight }: Props = $props();

    let container: HTMLDivElement;

    $effect(() => {
        const cy = cytoscape({
            container,
            elements: [
                ...graph.nodes.map(n => ({ 
                    data: { id: n.id, label: n.label ?? n.id }, 
                    ...(n.position ?? ({}))
                })),
                ...graph.edges.map(e => ({ data: { id: e.id, source: e.from, target: e.to } })),
            ],
            // layout: { name: "cose" },
            style: [
                {
                    selector: "node",
                    style: {
                        label: "data(label)",
                        "text-valign": "center",
                        "background-color": ele =>
                        highlight.includes(ele.id()) ? "#f6b26b" : "#6fa8dc",
                        color: "#fff",
                        "font-size": "10px",
                    },
                },
                {
                    selector: "edge",
                    style: {
                        width: 2,
                        "line-color": "#999",
                        "target-arrow-shape": graph.directed ? "triangle" : "none",
                    },
                },
            ],
        });
        return () => cy.destroy();
    });
</script>

<div bind:this={container} style="width:100%;height:400px;"></div>
