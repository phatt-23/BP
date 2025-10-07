<!-- phatt 2025-10-06 -->
<!-- Orchestrates the run of a reduction, holds the input, steps and final result. -->
<!-- 3-SAT to Hamiltonian cycle reduction page -->

<script lang="ts">
    import { currentInstance, reductionSteps, currentStepIndex } from "../../stores";
    import { get } from "svelte/store";
    import { threeSatToHCycle } from "../../Reductions/threeSatToHCycle"; 
    import CNFRenderer from "../Components/InstanceRenderer/CNFRenderer.svelte";
    import GraphRenderer from "../Components/InstanceRenderer/GraphRenderer.svelte";
    import StepPlayer from "../Components/StepPlayer.svelte";
    import type { GraphInstance } from "../../Models/Instances/Graph";
    import { exampleCNF } from "../../Models/Demos/3-CNF-demos";
    import CNFEditor from "../Components/CNFEditor.svelte";
    import CertificateView from "../Components/CertificateViews/CertificateView.svelte";
    import { ThreeSatSolver } from "../../Models/Solvers/ThreeSatSolver";
    import HamiltonianCycleView from "../Components/CertificateViews/HamiltonianCycleCertificateView.svelte";

    let step = $derived( $reductionSteps[$currentStepIndex] );
    let graph: GraphInstance = $derived( step?.outputSnapshot! );
    let cnf = $derived( $currentInstance );
    let certificate: Record<string, boolean> | null = $state(null);
    let hCertificate: any | null = $state(null);

    $effect(() => {
        if (!get(currentInstance)) {
            currentInstance.set(exampleCNF);
            const { steps } = threeSatToHCycle(exampleCNF);
            reductionSteps.set(steps);
            currentStepIndex.set(0);
        }
    });

    function checkCertificate() {
        if (cnf) {
            const solver = new ThreeSatSolver(cnf);
            certificate = solver.solve();
        }
    }

    function runFullReduction() {
        const { steps, witnessMap } = threeSatToHCycle(cnf);
        reductionSteps.set(steps);
        currentStepIndex.set(steps.length - 1);

        const solver = new ThreeSatSolver(cnf);
        certificate = solver.solve();
        if (certificate) {
            hCertificate = witnessMap(certificate);
        } else {
            hCertificate = null;
        }
  }
</script>

<h2>3-SAT &RightArrow; Hamiltonian Cycle Reduction</h2>

<CNFEditor initial={exampleCNF}></CNFEditor>

{#if step}
    <h3>{step.title}</h3>
    <p>{@html step.description}</p>

    <div class="panes">
        <div>
            <h4>3-SAT Input</h4>
            <CNFRenderer cnf={cnf!} />
        </div>
        <div>
            <h4>Graph Output</h4>
            <GraphRenderer graph={graph} highlight={step.highlight?.targetIds ?? []} />
        </div>
    </div>

    <StepPlayer />
{/if}

<button onclick={runFullReduction}>Run Full Reduction + Certificate</button>

{#if certificate}
  <div class="certificates">
    <CertificateView {cnf} {certificate} />
    <HamiltonianCycleView witness={hCertificate} />
  </div>
{/if}

<style>
.panes {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}
</style>