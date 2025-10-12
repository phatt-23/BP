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
    }

    let { steps }: Props<ProblemInstance, ProblemInstance> = $props();
</script>

<h2>Reduction Stepper</h2>

{#each steps as step, i}
    <h2>{step.title}</h2>
    <p>
        {@html step.description}
    </p>
{/each}

