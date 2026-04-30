#import "/lib/global.typ": *
#import "@preview/diagraph:0.3.6": *
#import "./2.common.typ": *

== TSP

Uvažujme ohodnocený neorientovaný graf:
$
  G = (V,E),
$ 
kde $V$ je množina vrcholů a $E subset.eq {{u,v} | u,v in V and u eq.not v}$
je množina neorientovaných hran.
Každé hraně je přiřazena nezáporná váha pomocí funkce:

$
  w : E -> NN.
$

Problém obchodního cestujícího (Traveling Salesman Problem, TSP) je optimalizační problém,
jehož cílem je nalézt hamiltonovskou kružnici v grafu $G$ 
s minimální celkovou cenou, kde cena kružnice je dána součtem vah jejích hran.

Stejně jako každý optimalizační problém lze i TSP převést na odpovídající problém rozhodovací.

Řekneme, že graf $G$ obsahuje hamiltonovskou kružnici s cenou nejvýše $k in NN$, 
pokud existuje posloupnost vrcholů:

$
  P = (v_1, v_2, ..., v_(lr(|V|) - 1), v_lr(|V|), v_1),
$

která splňuje následující podmínky:
- každý vrchol z množiny $V$ se v posloupnosti $P$ vyskytuje právě jednou 
  s výjimkou počátečního a koncového vrcholu $v_1$,
- platí ${v_i,v_(i+1)} in E$ pro $1 <= i < lr(|V|)$ a ${v_lr(|V|), v_1} in E$,
- celková cena kružnice splňuje $sum_i^lr(|V|) w({v_i, v_(i+1)}) <= k$.

Abychom získali optimální řešení,
kterým je uzavřená cesta s nejnižší cenou splňující zmíněné podmínky, 
budeme hodnotu $k$ snižovat do té doby, než bude odpověď záporná.
V tu chvíli víme, že cena optimální cesty je $k + 1$ a žádná jiná cesta s nižší cenou neexistuje.

#rozhod-forma

/ Vstup: 
  Ohodnocený neorientovaný graf $G$ a konstanta $k in NN$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovskou kružnici s cenou nejvýše $k$?

#opt-pr-instance

Mějme graf $G = (V,E)$:

#figure(
  raw-render(```dot
    graph {
      rankdir=LR
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      edge [label="2"]
      A -- F
      B -- D 
      C -- E

      edge [label="1"]
      A -- B 
      B -- C 
      C -- D 
      D -- E 
      E -- F 
      F -- A 
    }
  ```, width: 84%),
  caption: [Instance problému TSP - ohodnocený neorientovaný graf],
)

Pro $k = 8$ existuje možné řešení 
a odpověď na rozhodovací otázku je kladná.

#figure(
  raw-render(```dot
    graph {
      rankdir=LR
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -- F [label="2"]
      B -- D [color=red penwidth=2 label="2"]
      C -- E [color=red penwidth=2 label="2"]
      A -- B [color=red penwidth=2 label="1"]
      B -- C [label="1"]
      C -- D [color=red penwidth=2 label="1"]
      D -- E [label="1"]
      E -- F [color=red penwidth=2 label="1"]
      F -- A [color=red penwidth=2 label="1"]
    }
  ```, width: 80%),
  caption: [Řešení problému TSP pro $k = 8$],
)

Pro $k = 6$ existuje také možné řešení. Odpověď na rozhodovací otázku je kladná.

#figure(
  raw-render(```dot
    graph {
      rankdir=LR
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -- F [label="2"]
      B -- D [label="2"]
      C -- E [label="2"]
      A -- B [color=red penwidth=2 label="1"]
      B -- C [color=red penwidth=2 label="1"]
      C -- D [color=red penwidth=2 label="1"]
      D -- E [color=red penwidth=2 label="1"]
      E -- F [color=red penwidth=2 label="1"]
      F -- A [color=red penwidth=2 label="1"]
    }
  ```, width: 80%),
  caption: [Řešení problému TSP pro $k = 6$],
) <tsp-opt-reseni>

Pro $k = 5$ žádné řešení neexistuje, tudíž odpověď na rozhodovací otázku je záporná
a nejnižší dosažitelná cena je $k + 1 = 5 + 1 = 6$.
Cesta $(A,B,C,D,E,F,A)$ zobrazená na @tsp-opt-reseni[obrázku] o celkové ceně $6$ je optimálním řešením.


