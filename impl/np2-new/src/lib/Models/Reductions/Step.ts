// phatt 2025-10-06

// each step is documentation and executable
// stores inputSnapshot and outputSnapshot
// has apply() to recompute
// mapping stores ids
// witnessMap() shows how a solution to the target yields solution of the source

export interface Step<S = any, T = any> {
    id: string;
    title: string;                                  // short desc
    description: string;                            // human explanation 
    inputKind: string;                              // 3-SAT
    outputKind: string;                             // 3DM
    inputSnapshot?: S;                              // captured input state
    outputSnapshot?: T;                             // captured produced output state
    mapping?: Record<string, string[]>;             // source elem id -> target elem ids
    highlight?: {                                   // UI highlighting
        sourceIds?: string[];
        targetIds?: string[];
    };
    apply?: (input: S) => T;                        // apply this step
    verify?: (input: S, output: T) => boolean;      // sanity check
    witnessMap?: (targetCertificate: any) => any;   // map target witness to source witness
}

// const step: Step<CNF3Instance, ThreeDMInstance> = {
//   id: 's1',
//   title: 'Create triple gadgets for clause C1',
//   description: '<p>For clause C1 = (x ∨ ¬y ∨ z) create triples ...</p>',
//   inputKind: '3SAT', outputKind: '3DM',
//   inputSnapshot: cnfInstance,
//   apply: (cnf) => { /* create triples for clause C1 only */ },
//   outputSnapshot: threeDmAfterStep,
//   mapping: {
//     'clause-C1': ['t1','t2','t3'], // UI can highlight these
//     'var-x': ['x1','x2']
//   },
//   highlight: { sourceIds: ['clause-C1'], targetIds: ['t1','t2','t3'] },
//   verify: (in_, out_) => /* quick check */,
//   witnessMap: (matching) => /* how to turn matching into variable assignment */
// }