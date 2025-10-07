// phatt 2025-10-06

export type VarName = string;

export interface Literal {
    var: VarName;
    negated: boolean;
    id?: string;
}

export interface Clause {
    id: string;
    lits: [Literal, Literal, Literal];
}

export interface CNF3Instance {
    id: string;
    vars: VarName[];
    clauses: Clause[];
}