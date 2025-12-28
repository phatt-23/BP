<!-- Created by phatt-23 on 27/12/2025 -->

<script lang="ts">
    import type { Snippet } from "svelte";
    import Card from "../Card.svelte";
    import Spinner from "../Spinner.svelte";
    import type { ReductionStore } from "$lib/state/ReductionStore.svelte";
    import type { Writable } from "svelte/store";

    type Props<I,O,IC,OC> = {
        title: () => ReturnType<Snippet>,
        editor: () => ReturnType<Snippet>,
        redStore: Writable<ReductionStore<I,O,IC,OC>>,
        isSolving: Writable<boolean>,
        solveMessage: Writable<string>,
        reduce: () => {},
        solve: () => {},
        showStepper: Writable<boolean>,
    };

    let { 
        title,
        editor,
        redStore,
        isSolving,
        solveMessage,
        reduce,
        solve,
        showStepper,
    }: Props<any,any,any,any> = $props();

</script>

<Card>
    {#snippet header()}
        {@render title()}    
    {/snippet}

    {#snippet body()}
        {@render editor()}

        <div class="controls">
            <div class="left-controls">
                <button 
                    disabled={!$redStore.hasInInstance() 
                        || $redStore.hasOutInstance() 
                        || $redStore.inInstance?.isEmpty()
                        || $isSolving} 
                    onclick={reduce}
                >
                    Reduce
                </button>

                <button
                    disabled={!$redStore.hasInstances() 
                        || $redStore.hasOutCertificate()
                        || $redStore.inInstance?.isEmpty()
                        || $isSolving}
                    onclick={solve}
                >
                    {#if $isSolving}
                        Solving...
                    {:else}
                        Solve
                    {/if}
                </button>

                <button class="dev" onclick={() => { 
                    reduce();

                    showStepper.update(s => { 
                        s = true; 
                        return s; 
                    });
                }}>
                    Reduce and Show steps
                </button>

                <button class="dev" onclick={() => { 
                    reduce(); 
                    solve();
                }}>
                    Reduce and Solve
                </button>

                <div>
                    {#if $isSolving}
                        <Spinner>{$solveMessage}</Spinner>
                    {/if}
                </div>
            </div>

            <div class="right-controls">
                <label class="checkbox-wrapper">
                    <input type="checkbox" bind:checked={$showStepper}>
                    <span>Show steps</span>
                </label>
            </div>
        </div>
    {/snippet}
</Card>

<style lang="sass">

.controls
    display: flex
    justify-content: space-between

.left-controls
    display: flex
    align-items: center
    gap: 0.25rem

.right-controls
    align-items: center
    align-content: center

</style>