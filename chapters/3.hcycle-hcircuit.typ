#import "@preview/diagraph:0.3.6": *

#import "/lib/global.typ": *
#load-bib(main: false)

== Redukce HCYCLE na HCIRCUIT <sec-redukce-hcycle-hcircuit>

Tato redukce vychází z @sawa-ti-slides-06.

V této redukci převádíme
instanci problému HCYCLE, tedy orientovaný graf,
na instanci problému HCIRCUIT, tedy neorientovaný graf.
Je založena na konstrukci konstrukčních prvků pro vrcholy.

Pro každý vrchol $v in V(G)$ vstupního orientovaného grafu $G$ 
vytvoříme konstrukční prvek skládajícím se ze tří vrcholů:

$
  v^((i)), v^((b)), v^((o)),
$

spojených do cesty:

#figure(
raw-render(```dot
graph {
  rankdir=LR
  node [shape=circle]

  "v^((i))" -- "v^((b))" -- "v^((o))"
}
```),
caption: [Konstrukční prvek jednoho vrcholu]
)

Význam jednotlivých vrcholů konstrukčního prvku je následující:

- $v^((i))$ -- 
  vstupní vrchol, slouží jako konec pro přicházející hrany. 
  Návštěva tohoto vrcholu odpovídá vstupu do vrcholu $v$ ve vstupním grafu $G$.

- $v^((b))$ -- 
  střední ("bridge") vrchol, který zajišťuje, 
  že pokud projdeme vstupním vrcholem konstrukčního prvku, 
  musíme zároveň navštívit všechny jeho vrcholy. 
  Jinými slovy, jakmile vstoupíme do $v_i$,   
  cyklus musí pokračovat přes $v_b$ a následně $v_o$.
  Tudíž návštěva $v_i$ ekvivalentně znamená 
  navštívení vrcholu $v$ ve vstupním grafu $G$.

- $v^((o))$ -- 
  výstupní vrchol, slouží jako počátek odchozí hrany. 
  Z tohoto vrcholu odcházejí hrany do vstupních vrcholů 
  dalších konstrukčních prvků, 
  a to na základě původních hran grafu $G$.

Tento princip zajišťuje, 
že v převedeném grafu HCIRCUIT je každý vrchol původního grafu reprezentován trojicí, 
jejíž návštěva je povinná a odpovídá skutečné návštěvě vrcholu ve vstupním grafu.

Pro každou hranu $(x,y) in E(G)$ 
spojíme výstupní vrchol $x^((o))$ se vstupním vrcholem $y^((i))$ v novém grafu. 
Takto se zachovává orientace původního grafu 
v novém neorientovaném grafu problému HCIRCUIT.

Jako konkrétní příklad uvažujme graf $G$ na @g[obrázku]:

#figure(
  raw-render(```
    digraph {
      layout=circo
      node [shape=circle]

      A -> B
      B -> C
      C -> D
      D -> E
      A -> D
      A -> E
      B -> D
      E -> A
    }
  ```),
  caption: [Vstupní graf problému HCYCLE],
) <g>

Transformace tohoto grafu do instance problému HCIRCUIT probíhá tak, 
že každý vrchol je nahrazen trojicí $v^((i)), v^((b)), v^((o))$ 
a hrany jsou propojeny podle výše uvedeného pravidla. 
Výsledný graf je zobrazen na @h[obrázku].

#figure(
  raw-render(```
    graph {
      layout=circo
      node [shape=circle]

      "A^((i))" -- "A^((b))" -- "A^((o))"
      "B^((i))" -- "B^((b))" -- "B^((o))" 
      "C^((i))" -- "C^((b))" -- "C^((o))"
      "D^((i))" -- "D^((b))" -- "D^((o))"
      "E^((i))" -- "E^((b))" -- "E^((o))"

      "A^((o))" -- "B^((i))"
      "B^((o))" -- "C^((i))"
      "C^((o))" -- "D^((i))"
      "D^((o))" -- "E^((i))"
      "A^((o))" -- "D^((i))"
      "A^((o))" -- "E^((i))"
      "B^((o))" -- "D^((i))"
      "E^((o))" -- "A^((i))"
    }
  ```, width: 80%),
  caption: [Výstupní graf problému HCIRCUIT],
) <h>

Tento postup zaručuje, 
že existuje hamiltonovský cyklus ve vstupním grafu HCYCLE právě tehdy, 
když existuje hamiltonovská kružnice v převedeném grafu HCIRCUIT. 

