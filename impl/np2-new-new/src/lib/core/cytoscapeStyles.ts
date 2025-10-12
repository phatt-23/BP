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
};