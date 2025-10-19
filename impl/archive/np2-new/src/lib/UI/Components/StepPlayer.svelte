<!-- phatt 2025-10-06 -->
<!-- Has controls for prev/next and a step list. -->

<script lang="ts">
  import { currentStepIndex, reductionSteps } from "../../stores";
  import { get } from "svelte/store";

  function next() {
    const idx = get(currentStepIndex);
    if (idx < get(reductionSteps).length - 1) 
        currentStepIndex.set(idx + 1);
  }

  function prev() {
    const idx = get(currentStepIndex);
    if (idx > 0) 
        currentStepIndex.set(idx - 1);
  }
</script>

<div class="step-player">
  <button on:click={prev}>Prev</button>
  <span>Step { $currentStepIndex + 1 } / { get(reductionSteps).length }</span>
  <button on:click={next}>Next</button>
</div>

<style>
.step-player { display:flex; gap:0.5rem; align-items:center; margin-top:1rem; }
button { padding:0.3rem 0.6rem; border-radius:6px; }
</style>