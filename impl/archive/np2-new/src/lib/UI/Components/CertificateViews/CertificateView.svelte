<script lang="ts">
    import type { CNF3Instance } from "../../../Models/Instances/CNF";


    type Props = {
        cnf: CNF3Instance;
        certificate: Record<string, boolean> | null;
    };

    const { cnf, certificate = null }: Props = $props();
</script>

<div class="certificate">
  <h3>Certificate</h3>
  {#if certificate}
    <ul>
      {#each Object.entries(certificate) as [v, val]}
        <li>{v} = {val ? 'TRUE' : 'FALSE'}</li>
      {/each}
    </ul>
  {:else}
    <p>No satisfying assignment found (unsatisfiable or untested).</p>
  {/if}
</div>

<style>
.certificate { background:#f1f1f1; padding:1rem; border-radius:1rem; }
li { font-family:monospace; }
</style>
