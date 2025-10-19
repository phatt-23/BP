<!-- Created by phatt-23 on 19/10/2025 -->

<script lang="ts">
    import type { Certificate3SAT } from "$lib/solve/Certificate3SAT";


    type Props = {
        cert : Certificate3SAT;
    };

    let { cert }: Props = $props();

    console.debug('Assignments:', cert.assignments);
</script>

<main>
    <h2>CertRenderer 3SAT</h2>
    {#each cert.assignments as [varName, assgn],i}
        <div>{varName} &coloneq; {assgn == true ? 'T' : assgn == false ? 'F' : 'Either' }</div>
    {/each}
</main>