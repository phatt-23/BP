<!--
    Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import type { ErrorMessage } from "$lib/core/assert";
    import { CNF3 } from "$lib/instance/CNF3.svelte";

    type Props = {
        cnf: CNF3 | null;
        onChange: (cnf: CNF3) => void;
        onWrongFormat?: (message: ErrorMessage) => void;
    }

    let { cnf, onChange, onWrongFormat }: Props = $props();

    let text = $state(cnf?.asString() ?? '');

    const onTextChange = () => {
        const result = CNF3.fromString(text);

        if (typeof result == "string") {
            if (onWrongFormat) {
                onWrongFormat(result);
            }
            return;
        }

        if (onChange) {
            onChange(result);
        }
    };

    $effect(() => {
        if (cnf) text = cnf.asString()
    })
</script>

<div class="cnf-editor">
    <h2>CNF Editor</h2>
    <p><i>Removes duplicate clauses automatically.</i></p>

    <textarea bind:value={text} onchange={onTextChange}>
    </textarea>
</div>

<style>
    textarea { width: 100%; height: 20em; }
</style>