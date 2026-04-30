== Redukce HCIRCUIT na TSP

=== Instance s kladnou odpovědí

Ukázkovou instancí je neorientovaný graf obsahující hamiltonovskou kružnici:
$
  V = { x_0, x_1, x_2, x_3, x_4, x_5 } \
  E = {
    {x_0, x_1},
    {x_4, x_2},
    {x_5, x_3},
    {x_3, x_2},
    {x_5, x_0},
    {x_2, x_1},
    {x_4, x_5},
    {x_0, x_2},
    {x_4, x_0}
  }
$

Instance ukazuje přidání hran s vyšší vahou
a nastavení cílové hodnoty $k = |V|$.

#figure(
  image("../assets/screenshots/hcircuit-tsp-yes-page.png", height: 97%),
  caption: [Vstupní instance HCIRCUIT a výsledná instance TSP (kladná odpověď)]
)

#figure(
  grid(
    columns: 2,
    image("../assets/screenshots/hcircuit-tsp-yes-step-1.png"),
    image("../assets/screenshots/hcircuit-tsp-yes-step-2.png"),
    image("../assets/screenshots/hcircuit-tsp-yes-step-3.png"),
  ),
  caption: [Krokové zobrazení redukce HCIRCUIT na TSP (kladná odpověď)]
)

#pagebreak()

=== Instance se zápornou odpovědí

Ukázkovou instancí je graf neobsahující hamiltonovskou kružnici:
$
  V = {0,1,2,3,4}  \
  E = {
    {0, 1},
    {1, 2},
    {2, 3},
    {3, 4},
    {0, 2},
    {0, 3}
  }
$

Demonstruje případ, kdy neexistuje cesta s cenou $k = |V|$,
protože graf neobsahuje hamiltonovskou kružnici.

#figure(
  image("../assets/screenshots/hcircuit-tsp-no-page.png", height: 97%),
  caption: [Vstupní instance HCIRCUIT a výsledná instance TSP (záporná odpověď)]
)

