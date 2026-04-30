#import "/lib/global.typ": *
#import "@preview/diagraph:0.3.6": *
#import "./2.common.typ": * 

== HCIRCUIT

Problém hamiltonovské kružnice (Hamiltonian Circuit, HCIRCUIT) 
je obdobou problému HCYCLE definovaný pro neorientované grafy.

Uvažujme neorientovaný graf:
$
  G = (V,E),
$

kde $V$ je množina vrcholů 
a $E subset.eq {{u,v} | u,v in V and u eq.not v}$
je množina neorientovaných hran,
přičemž každá hrana spojuje dva různé vrcholy.

Řekneme, že graf $G$ obsahuje hamiltonovskou kružnici, 
pokud v něm existuje uzavřená cesta, 
která prochází každým vrcholem grafu právě jednou.

#rozhod-forma
/ Vstup: 
  Neorientovaný graf $G = (V,E)$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovskou kružnici? 

#kladna-odpo

Mějme graf $G = (V,E)$, kde:

$
  V = {x_0, x_1, x_2, x_3, x_4, x_5} \
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
  }.
$

#figure(
  raw-render(```dot
    graph {
      layout=circo

      node [
        shape=circle 
        width=0.1
      ]

      x_0
      x_1
      x_2
      x_3
      x_4
      x_5

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]
      
      "x_4" -- "x_2"
      "x_5" -- "x_0"
      "x_0" -- "x_2"

      edge [color=red penwidth=2]

      "x_0" -- "x_1"
      "x_2" -- "x_1"
      "x_3" -- "x_2"
      "x_5" -- "x_3"
      "x_4" -- "x_5"
      "x_4" -- "x_0"

    }
  ```, height: 25%),
  caption: [Instance problému HCIRCUIT s kladnou odpovědí],
)

Graf $G$ je hamiltonovský, protože obsahuje hamiltonovskou kružnici danou uzavřenou cestou:
$
  P = (x_0, x_4, x_5, x_3, x_2, x_1, x_0).
$

#zaporna-odpo

Mějme graf strom:

#figure(
  raw-render(```dot
    graph Tree {
      layout=dot
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -- B
      A -- C
      B -- D
      B -- E
      C -- F
    }
  ```, width: 35%),
  caption: [Instance problému HCIRCUIT se zápornou odpovědí],
)

Tento graf neobsahuje hamiltonovskou kružnici, protože je acyklický.



