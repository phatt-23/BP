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
        indent?: number,
        onNextClick?: () => void;
        onPrevClick?: () => void;
    }

    let { 
        steps, 
        stepIndex, 
        indent = 0,
        onNextClick = undefined, 
        onPrevClick = undefined 
    }: Props<ProblemInstance, ProblemInstance> = $props();

    const totalStepCount = steps.length;

    let showAll = $state(false);
    let showInterSteps = $state(false);
    let childStepIndex = $state(0);

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

<section style="padding-left: {indent * 100}px; border: solid black 1px">
    <h1>Reduction Stepper</h1>

    <div>
        <label for="showAllCheckbox">Show all</label>
        <input type="checkbox" bind:checked={showAll} name="showAllCheckbox">
    </div>

    {#if showAll}

        <!-- Shows all the steps at once -->
        {#each steps as step, i}
            <h2>Step #{i + 1}: {step.title}</h2>
            <p>{@html step.description}</p>

            {#if showInterSteps && step.interSteps != undefined}
                <!-- svelte-ignore svelte_self_deprecated -->
                <svelte:self
                    steps={step.interSteps} 
                    stepIndex={childStepIndex}
                    indent={indent + 1}
                    onPrevClick={() => {
                        if (childStepIndex > 0)
                            childStepIndex = childStepIndex - 1;
                    }}
                    onNextClick={() => {
                        if (childStepIndex < step.interSteps!.length)
                            childStepIndex = childStepIndex + 1;
                    }}
                />
            {/if}

        {/each} 
    {:else}
        {#if stepIndex < steps.length}
            {@const step = steps[stepIndex]}

            <h2>Step #{stepIndex + 1}: {step.title}</h2>
            <p>{@html step.description}</p>
        {/if}

        <div>
            <button onclick={prevClick}>Previous</button>
            <button onclick={nextClick}>Next</button>
            <span>{stepIndex + 1}/{totalStepCount}</span>
        </div>
    {/if}
</section>
