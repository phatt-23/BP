<!-- phatt-23 2025-10-07 -->

<script lang="ts">
  import Cytoscape from "cytoscape";
  import { onMount } from "svelte";

  interface Props {
    witness: {
        nodes: any[];
        edges: any[];
        cycleNodes: string[];
    } | null 
  }

  const { witness }: Props = $props();

  let container: HTMLDivElement;

  onMount(() => {
    if (!witness) return;
    const cy = Cytoscape({
      container,
      elements: [...witness.nodes, ...witness.edges],
      style: [
        {
          selector: "node",
          style: {
            label: "data(label)",
            "background-color": "#999",
            "text-valign": "center",
            "text-halign": "center",
            color: "#fff",
            "font-size": "10px",
          },
        },
        {
          selector: "edge",
          style: {
            width: 2,
            "line-color": "#ccc",
            "target-arrow-shape": "triangle",
            "target-arrow-color": "#ccc",
            "curve-style": "bezier",
          },
        },
        {
          selector: `node[?cycle]`,
          style: {
            "background-color": "#ff6f00",
          },
        },
        {
          selector: `edge[?cycle]`,
          style: {
            "line-color": "#ff6f00",
            "target-arrow-color": "#ff6f00",
            width: 3,
          },
        },
      ],
      layout: { name: "circle" },
    });

    // highlight cycle edges/nodes
    cy.batch(() => {
      witness.cycleNodes.forEach((id) => {
        cy.$id(id).data("cycle", true);
      });
      witness.edges.forEach((e) => {
        cy.$id(`${e.data.source}->${e.data.target}`).data("cycle", true);
      });
    });
  });
</script>

{#if witness}
  <div class="certificate">
    <h3>Hamiltonian Cycle Certificate</h3>
    <div class="cycle">
      <strong>Visited in order:</strong>
      <ol>
        {#each witness.cycleNodes as id}
          <li>{id}</li>
        {/each}
      </ol>
    </div>
    <div bind:this={container} class="graph"></div>
  </div>
{:else}
  <p>No Hamiltonian certificate available.</p>
{/if}

<style>
.certificate { padding:1rem; background:#f4f4f4; border-radius:1rem; }
.graph { width:100%; height:400px; margin-top:1rem; border:1px solid #ccc; border-radius:0.5rem; }
.cycle ol { font-family:monospace; }
</style>