#import "@preview/diagraph:0.3.6": *

== Redukce HCYCLE na HCIRCUIT

Pro každý vrchol $v in V(G)$ vstupního orientovaného grafu $G$ 
vytvoříme konstrukční prvek skládajícím se ze tří vrcholů:

$
  v_i, v_b, v_o,
$

spojených do cesty:

#figure(
raw-render(```dot
graph {
  rankdir=LR
  node [shape=circle]

  v_i -- v_b -- v_o
}
```),
caption: [Konstrukční prvek vrcholu původního grafu]
)

Význam jednotlivých vrcholů konstrukčního prvku je následující:

- $v_i$ -- 
  vstupní vrchol, slouží jako konec pro přicházející hrany. 
  Návštěva tohoto vrcholu odpovídá vstupu do vrcholu $v$ ve vstupním grafu $G$.

- $v_b$ -- 
  střední ("bridge") vrchol, který zajišťuje, 
  že pokud projdeme konstrukčním prvkem, 
  musíme zároveň navštívit všechny jeho vrcholy. 
  Jinými slovy, jakmile vstoupíme do $v_i$,   
  cyklus musí pokračovat přes $v_b$ a následně $v_o$.
  Tudíž návštěva $v_i$ ekvivalentně znamená 
  navštívení vrcholu $v$ ve vstupním grafu $G$.

- $v_o$ -- 
  výstupní vrchol, slouží jako počátek odchozí hrany. 
  Z tohoto vrcholu odcházejí hrany do vstupních vrcholů 
  dalších konstrukčních prvků, 
  a to na základě původních hran grafu $G$.

Tento princip zajišťuje, 
že v převedeném grafu HCIRCUIT je každý vrchol původního grafu reprezentován trojicí, 
jejíž návštěva je povinná a odpovídá skutečné návštěvě vrcholu ve vstupním grafu.

// Tímto způsobem se zajistí, 
// že pokud cyklus projde vrcholem $v$, 
// musí projít i všemi vrcholy jeho konstrukčního prvku.

Pro každou hranu $(x,y) in E(G)$ 
spojíme výstupní vrchol $x_o$ se vstupním vrcholem $y_i$ v novém grafu. 
Takto se zachovává orientace původního grafu 
v novém neorientovaném grafu problému HCIRCUIT.

Jako konkrétní příklad uvažujme graf $G$ na @g[obrázku]:

#figure(
raw-render(```
digraph {
  layout=circo
  node [shape=circle]

  a -> b
  b -> c
  c -> d
  d -> e
  a -> d
  a -> e
  b -> d
  e -> a
}
```),
caption: [Vstupní graf problému HCYCLE],
) <g>

Transformace tohoto grafu do instance problému HCIRCUIT probíhá tak, 
že každý vrchol je nahrazen trojicí $v_i, v_b, v_o$ 
a hrany jsou propojeny podle výše uvedeného pravidla. 
Výsledný graf je zobrazen na @h[obrázku]:

#figure(
raw-render(```
graph {
  layout=circo
  node [shape=circle]

  a_i -- a_b -- a_o
  b_i -- b_b -- b_o
  c_i -- c_b -- c_o
  d_i -- d_b -- d_o
  e_i -- e_b -- e_o

  a_o -- b_i
  b_o -- c_i
  c_o -- d_i
  d_o -- e_i
  a_o -- d_i
  a_o -- e_i
  b_o -- d_i
  e_o -- a_i
}
```, width: 80%),
caption: [Výstupní graf problému HCIRCUIT],
) <h>

Tento postup zaručuje, 
že existuje hamiltonovský cyklus ve vstupním grafu HCYCLE právě tehdy, 
když existuje hamiltonovský cyklus v převedeném grafu HCIRCUIT. 

