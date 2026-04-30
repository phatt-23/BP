#import "@preview/diagraph:0.3.6": *

= Redukce mezi vybranými problémy 

Tato kapitola tvoří teoretické jádro práce 
a je věnována redukcím mezi vybranými NP-úplnými problémy. 
Cílem je nejen formálně popsat jednotlivé převody, 
ale především objasnit jejich princip 
a usnadnit jejich pochopení.

V této práci se zaměřujeme na následující redukce:
- redukci problému 3-SAT na problémy HCYCLE, SSP a 3-CG,
- redukci problému HCYCLE na problém HCIRCUIT,
- redukci problému HCIRCUIT na problém TSP.

#figure(
  raw-render(```dot
    digraph Reductions {
      node [ penwidth=0.0 fixedsize=true ]
      edge [ penwidth=1 style=solid ]

      A [label="3-SAT"]
      B [label="HCYCLE"]
      C [label="SSP"]
      D [label="3-CG"]
      E [label="HCIRCUIT"]
      F [label="TSP"]
      A -> B
      A -> C
      A -> D
      B -> E
      E -> F
    }
  ```),
  caption: [Graf redukcí mezi problémy],
)

Pro každý převod si popíšeme polynomiální algoritmus, 
který převede libovolnou instanci problému $A$ na instanci problému $B$ tak, 
aby byla zachována odpověď na otázku rozhodovacího problému. 

Nejprve uvedeme základní myšlenku převodu, 
následně konceptuálně popíšeme jednotlivé kroky algoritmu 
a poté zdůvodníme jeho korektnost,
tj. že původní instance má kladnou odpověď právě tehdy,
když má kladnou odpověď i instance převedená.

Ve většině popisovaných redukcí využíváme tzv. konstrukční prvky
(v anglické literatuře často označované jako _gadgets_).
Konstrukční prvek je vymezená část instance cílového problému, 
která svým chováním simuluje určitý prvek nebo vlastnost instance původního problému.
Tyto konstrukční prvky umožňují převést logickou strukturu jedné úlohy 
do struktury jiné úlohy tak, 
aby byly zachovány podstatné vlastnosti řešení.
V případě redukcí na grafové problémy mají konstrukční prvky podobu vhodně navržených podgrafů. 
Při redukcích na problém SSP jsou konstrukčními prvky jednotlivá čísla vstupní množiny
a cílová hodnota.


#pagebreak()
#include "3.3sat-hcycle.typ"
#pagebreak()
#include "3.3sat-ssp.typ"
#pagebreak()
#include "3.3sat-3cg.typ"
#pagebreak()
#include "3.hcycle-hcircuit.typ"
#pagebreak()
#include "3.hcircuit-tsp.typ"
#pagebreak()
