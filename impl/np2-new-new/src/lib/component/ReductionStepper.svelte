<!--
Created by phatt-23 on 12/10/2025
-->

<script lang="ts">
    import { ProblemInstance } from '$lib/instance/ProblemInstance';
    import type { ReductionStep } from '$lib/reduction/ReductionStep';

    type Props<
        I extends ProblemInstance, 
        O extends ProblemInstance
    > = {
        steps: ReductionStep<I,O>[];
        stepIndex: number;
        onNextClick?: () => void;
        onPrevClick?: () => void;
    }

    let { 
        steps, 
        stepIndex, 
        onNextClick = undefined, 
        onPrevClick = undefined 
    }: Props<ProblemInstance, ProblemInstance> = $props();

    const totalStepCount = steps.length;

    let showAll = $state(false);

    function prevClick() {
        if (onPrevClick && stepIndex > 0) {
            onPrevClick();
        }
    }

    function nextClick() {
        if (onNextClick && stepIndex < (totalStepCount - 1)) {
            onNextClick();
        }
    }
</script>

<h1>Reduction Stepper</h1>

<label for="showAllCheckbox">Show all</label>
<input type="checkbox" bind:checked={showAll} name="showAllCheckbox">

{#if showAll}
    <!-- Shows all the steps at once -->
    {#each steps as step, i}
        <h2>Step #{i + 1}: {step.title}</h2>
        <p>{@html step.description}</p>
    {/each} 
{:else}
    {#if stepIndex < steps.length}
        {@const step = steps[stepIndex]}
        <h2>Step #{stepIndex + 1}: {step.title}</h2>
        <p>{@html step.description}</p>
    {/if}

    <button onclick={prevClick}>Previous</button>
    <button onclick={nextClick}>Next</button>

    <span>{stepIndex + 1}/{totalStepCount}</span>
{/if}


