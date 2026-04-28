== Redukce HCIRCUIT na TSP

=== Instance s kladnou odpovědí

Neorientovaný graf obsahující hamiltonovskou kružnici:
$
  V = \{A, B, C, D, E, F\}, 
  E = \{\{A,B\}, \{B,C\}, \{C,D\}, \{D,E\}, \{E,F\}, \{F,A\}, \{A,C\}, \{B,E\}, \{B,F\}\}
$

Instance ukazuje přidání hran s vyšší vahou
a nastavení cílové hodnoty $k = |V|$.

#figure(
  image("../assets/screenshots/hcircuit-tsp-ex1-graph.png"),
  caption: [Výsledný graf po redukci (kladná odpověď)]
)

=== Instance se zápornou odpovědí

Graf neobsahující hamiltonovskou kružnici:
$
  V = \{A, B, C, D\}, 
  E = \{\{A,B\}, \{B,C\}, \{C,A\}, \{C,D\}\}
$

Demonstruje případ, kdy neexistuje cesta s cenou $k = |V|$,
protože graf neobsahuje hamiltonovskou kružnici.

#figure(
  image("../assets/screenshots/hcircuit-tsp-no-input.png"),
  caption: [Vstupní neorientovaný graf (záporná odpověď)]
)

#figure(
  image("../assets/screenshots/hcircuit-tsp-no-output.png"),
  caption: [Kompletní graf s ohodnocením hran (záporná odpověď)]
)

*Poznámka:* V aplikaci jsou pro tuto redukci k dispozici další 2 ukázkové instance
(jednodušší graf s hamiltonovskou kružnicí a graf s vyšším počtem vrcholů bez cyklu).
