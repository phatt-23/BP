#!/bin/env bash

for in_file in $(ls assets/plantuml/*.puml); do
    OUT_FILE=$(echo "$in_file" | sed s/\.puml$/\.svg/)
    echo "Compiling '$in_file' into svg file '$OUT_FILE'"

    plantuml --svg --verbose -o output "$in_file" 
    mv assets/plantuml/output/*.svg $OUT_FILE
done
