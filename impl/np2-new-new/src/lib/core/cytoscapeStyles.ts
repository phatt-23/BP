// Created by phatt-23 on 12/10/2025

import type { StylesheetStyle } from "cytoscape";

export const cytoscapeStyles: Record<string, StylesheetStyle[]> = {
    'DEFAULT_STYLE': [
        {
            selector: 'node',
            style: {
                'label': 'data(id)',
                "text-valign": "top",
                'color': '#000',
                'background-color': '#61bffc',
                'text-outline-color': '#fff',
                'text-outline-width': 2,
                "border-color": "black",
                "border-style": "solid",
                "border-width": 2,
            },
        },
        {
            selector: 'edge',
            style: {
                'curve-style': 'bezier',
                'line-color': "black",
                'width': 2
            }
        }
    ],
    '3SAT-HCYCLE': [
        {
            selector: "node",
            style: {
                "label": "data(id)",
                "font-size": 12,
                "text-valign": "top",
                "background-color": "blue",
                "border-color": "black",
                "border-style": "solid",
                "border-width": 2,
            },
        },
        {
            selector: "node.true",
            style: { "background-color": "green" },
        },
        {
            selector: "node.false",
            style: { "background-color": "red" },
        },
        {
            selector: "node.source, node.inbetween, node.target",
            style: {
                "background-color": "white",
                "border-style": "solid",
                "border-color": "black",
            },
        },
        {
            selector: "node.clause",
            style: { "background-color": "orange" },
        },
        {
            selector: "node.guarantee",
            style: { "opacity": 0.5 },
        },
        {
            selector: "edge",
            style: {
                "line-color": "black",
                "target-arrow-color": "black",
                "target-arrow-shape": "chevron",
                "curve-style": "bezier",
                "arrow-scale": 1.0,
            },
        },
        {
            selector: "edge.noise",
            style: {
                "line-opacity": 0.2,
                "line-color": "black",
            },
        },
        {
            selector: "edge.clause",
            style: {
                "curve-style": "bezier",
                "width": 3,
                "line-opacity": 1,
                "arrow-scale": 2.0,
            },
        },
        {
            selector: "edge.clause.true",
            style: {
                "target-arrow-color": "green",
                "line-color": "green",
            },
        },
        {
            selector: "edge.clause.false",
            style: {
                "target-arrow-color": "red",
                "line-color": "red",
            },
        },
        {
            selector: "edge.clause.out",
            style: { "line-style": "dashed" },
        },
    ]
};