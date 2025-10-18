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

    console.log('in editor:', JSON.stringify(cnf));

    let text = $state(cnf?.asString() ?? '');

    $effect(() => {
        if (cnf)
            text = cnf.asString()
    })

    const onTextChange = () => {
        const result = CNF3.fromString(text);

        if (typeof result == "string") {
            if (onWrongFormat)
                onWrongFormat(result);
            return;
        }

        if (onChange) {
            console.log('text changed new cnf:', result);
            onChange(result);
        }

    };
</script>

<div class="cnf-editor">
    <h2>CNF Editor</h2>
    <p>Removes duplicate clauses automatically</p>

    <textarea bind:value={text} onchange={onTextChange}>
    </textarea>
</div>

<style>
    textarea { width: 100%; height: 20em; }
</style>