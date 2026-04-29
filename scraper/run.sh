#!/bin/bash

CMD="node ./main.js"


$CMD    "hcircuit-tsp"        "Yes(2)"          "No(2)"
$CMD    "hcycle-hcircuit"     "Yes(2)"          "No(2)"
$CMD    "3sat-ssp"            "Yes-TeX(1)"      "No(1)"
$CMD    "3sat-3cg"            "Yes-TeX(2)"      "No(1)"
$CMD    "3sat-hcycle"         "Yes(2)"          "No(2)"


DEST="../assets/screenshots/"
mv *.png $DEST
