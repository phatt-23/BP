// Created by phatt-23 on 12/10/2025

import type { StylesheetStyle } from 'cytoscape';

export const cytoscapeStyles: Record<string, StylesheetStyle[]> = {
    'DEFAULT': [
        {
            selector: 'node',
            style: {
                'label': 'data(id)',
                'text-valign': 'top',
                'color': '#000',
                'background-color': '#61bffc',
                'text-outline-color': '#fff',
                'text-outline-width': 2,
                'border-color': 'black',
                'border-style': 'solid',
                'border-width': 2,
            },
        },
        {
            selector: 'edge',
            style: {
                'curve-style': 'bezier',
                'line-color': 'black',
                'width': 2
            }
        }
    ],
    '3SAT-HCYCLE': [
        {
            selector: 'node',
            style: {
                'label': 'data(id)',
                'font-size': 12,
                'text-valign': 'top',
                'background-color': 'blue',
                'border-color': 'black',
                'border-style': 'solid',
                'border-width': 2,
            },
        },
        {
            selector: 'node.true',  // vrchol na konci rady 
            style: { 'background-color': 'green' },
        },
        {
            selector: 'node.false',  // vrchol na druhem konci rady
            style: { 'background-color': 'red' },
        },
        {
            selector: 'node.source, node.inbetween, node.target',  // prechodne vrcholy mezi rady promennych
            style: {
                'background-color': 'white',
                'border-style': 'solid',
                'border-color': 'black',
            },
        },
        {
            selector: 'node.clause',  // vrchol reprezentujici klauzuli
            style: { 'background-color': 'orange' },
        },
        {
            selector: 'node.guarantee',  // mezi outgoing a incoming hranami
            style: { 'opacity': 0.5 },
        },
        {
            selector: 'edge',
            style: {
                'line-color': 'black',
                'target-arrow-color': 'black',
                'target-arrow-shape': 'chevron',
                'curve-style': 'bezier',
                'arrow-scale': 1.0,
            },
        },
        {
            selector: 'edge.muted',  // hrany, u kterych neni dulezite jejich viditelnost
            style: {
                'line-opacity': 0.2,
                'line-color': 'black',
            },
        },
        {
            selector: 'edge.clause',
            style: {
                'curve-style': 'bezier',
                'width': 3,
                'line-opacity': 1,
                'arrow-scale': 2.0,
            },
        },
        {
            selector: 'edge.true_in',  // true incoming edge
            style: {
                'target-arrow-color': 'green',
                'line-color': 'green',
                'line-style': 'dashed',
            },
        },
        {
            selector: 'edge.true_out',  // true outcoming edge
            style: {
                'target-arrow-color': 'green',
                'line-color': 'green',
            },
        },
        {
            selector: 'edge.false_in',  // false incoming edge
            style: {
                'target-arrow-color': 'red',
                'line-color': 'red',
                'line-style': 'dashed',
            },
        },
        {
            selector: 'edge.false_out',  // false outcoming edge
            style: {
                'target-arrow-color': 'red',
                'line-color': 'red',
            },
        },
        {
            selector: 'edge.solved',  
            style: {
                'line-opacity': 0.2,
            },
        },
        {
            selector: 'edge.solved.used',  
            style: {
                'line-opacity': 1,
            },
        },
    ],
    'UNDIRECTED': [
        {
            selector: 'node',
            style: {
                'label': 'data(id)',
                'text-valign': 'top',
                'color': '#000',
                'background-color': '#61bffc',
                'text-outline-color': '#fff',
                'text-outline-width': 2,
                'border-color': 'black',
                'border-style': 'solid',
                'border-width': 2,
            },
        },
        {
            selector: 'edge',
            style: {
                'curve-style': 'bezier',
                'line-color': 'black',
                'width': 2
            }
        }
    ],
    'DIRECTED': [
        {
            selector: 'node',
            style: {
                'label': 'data(id)',
                'text-valign': 'top',
                'color': '#000',
                'background-color': '#61bffc',
                'text-outline-color': '#fff',
                'text-outline-width': 2,
                'border-color': 'black',
                'border-style': 'solid',
                'border-width': 2,
            },
        },
        {
            selector: 'edge',
            style: {
                'line-color': 'black',
                'target-arrow-shape': 'triangle',
                // 'target-arrow-shape': 'chevron',
                'target-arrow-color': 'black',
                'curve-style': 'bezier',
                'arrow-scale': 2.0,
                'width': 2
            },
        },
    ],
    'TSP': [
        {
            selector: 'node',
            style: {
                'label': 'data(id)',
                'text-valign': 'top',
                'color': '#000',
                'background-color': '#61bffc',
                'text-outline-color': '#fff',
                'text-outline-width': 2,
                'border-color': 'black',
                'border-style': 'solid',
                'border-width': 2,
            },
        },
        {
            selector: 'edge',
            style: {
                'label': 'data(weight)',
                'curve-style': 'bezier',
                'line-color': 'black',
                'text-background-color': '#fff',
                'text-background-opacity': 1,
                'text-background-padding': 4,
                'width': 2
            }
        },
        {
            selector: 'edge.solid',
            style: {
                'line-opacity': 1.0,
            }
        },
        {
            selector: 'edge.muted',
            style: {
                'line-opacity': 0.2,
            }
        },
    ]
};