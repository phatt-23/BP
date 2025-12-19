//
// Created by phatt-23 on 11/10/2025
//

export type Id = string;

// 3SAT to HCYCLE
export const PREFIX_AND_ID_DELIM = ':';

export const NODE_ID_PREFIX = 'n:';
export const NODE_ID_PREFIX_SPECIAL = 'n%:';
export const EDGE_ID_PREFIX = 'e:';
export const SOURCE_NODE_ID = 'source';
export const TARGET_NODE_ID = 'target';

export const NODE_ID_PREFIX_CLAUSE = 'n%c:';
export const NODE_ID_PREFIX_INBETWEEN = 'n%i:';
export const NODE_ID_PREFIX_TRUE = 'n%t:';
export const NODE_ID_PREFIX_FALSE = 'n%f:';

// HCYCLE to HCIRCUIT
export const NODE_IN_POSTFIX = '_in';
export const NODE_GAP_POSTFIX = '_gap';
export const NODE_OUT_POSTFIX = '_out';

// 3SAT to SSP
export const VARIABLE_TRUE_PREFIX = 'T:';
export const VARIABLE_FALSE_PREFIX = 'F:';
export const CLAUSE_FILLER_PREFIX_ONE = 'filler1:';
export const CLAUSE_FILLER_PREFIX_TWO = 'filler2:';

export const cutNodeIdPrefix = (id: string) => {
    if (id.startsWith(NODE_ID_PREFIX)) {
        return id.slice(NODE_ID_PREFIX.length);
    }
    return id;
}
