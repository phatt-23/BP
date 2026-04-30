#import "@preview/diagraph:0.3.6": *

#import "/lib/global.typ": *
#load-bib(main: false)

== Redukce HCIRCUIT na TSP <sec-redukce-hcircuit-tsp>

V této redukci převádíme vstupní neorientovaný graf $G$ problému HCIRCUIT
na ohodnocený neorientovaný graf $H$ problému TSP.

Všechny vrcholy z grafu $G$ 
zkopírujeme do nového grafu $H$.
Mezi každou dvojici vrcholů v $H$ přidáme hranu, 
čímž vznikne kompletní graf.

Každé hraně $e = {x, y} in E(H)$ přiřadíme váhu podle pravidla:

- Pokud hrana $e$ existuje ve vstupním grafu, ${x, y} in E(G)$,
  nastavíme její váhu na 1.

- Pokud hrana $e$ ve vstupním grafu neexistuje, 
  nastavíme její váhu na hodnotu větší než 1, v našem případě 2.

Cílovou hodnotu $k$ pro problém TSP stanovíme rovnou počtu vrcholů grafu:

$
  k = |V(G)| = |V(H)|.
$

Tento postup zajišťuje, 
že ve vstupním grafu $G$ existuje hamiltonovský cyklus právě tehdy,
pokud v kompletním grafu $H$ existuje hamiltonovský cyklus s celkovou cenou $k$.

Redukce je korektní, 
protože jakákoli hamiltonovská cesta s celkovou cenou $k$ ve výsledném grafu $H$ 
musí využívat pouze hrany s vahou 1, 
tedy přesně ty, které existují ve vstupním grafu $G$.

Jako příklad uvažujme graf $G$ na @hcircuit-g[obrázku].

#figure(
raw-render(```
  graph {
    layout=neato
    node [
      shape=circle
    ]

    A [pos="0,2!"]
    B [pos="2,3!"]
    C [pos="4,2!"]
    D [pos="4,0!"]
    E [pos="2,0!"]
    F [pos="0,0!"]

    A -- B 
    B -- C
    C -- D
    D -- E
    E -- F
    F -- A
    A -- C
    B -- E
    B -- F
  }
```),
caption: [Vstupní graf problému HCIRCUIT]
) <hcircuit-g>

Graf $G$ převedeme podle popsané redukce na graf $H$, 
který je znázorněn na @tsp-h[obrázku].  
Graf $H$ je kompletní graf nad stejnou množinou vrcholů.  
Hrany, které existovaly již v grafu $G$, mají váhu 1 (značeny modře),  
zatímco nově přidané hrany mají váhu 2 (značeny červeně).

#figure(
raw-render(```
  graph {
    layout=neato
      splines=true
  overlap=false
    node [
      shape=circle
    ]

    A [pos="0,2!"]
    B [pos="2,3!"]
    C [pos="4,2!"]
    D [pos="4,0!"]
    E [pos="2,0!"]
    F [pos="0,0!"]

    edge [color=blue label=""]

    A -- B
    B -- C
    C -- D
    D -- E
    E -- F
    F -- A
    A -- C
    B -- E
    B -- F

    edge [color=red label="" splines=curved]

    A -- E
    A -- D
    B -- D
    C -- E
    C -- F
    D -- F

  }
```),
caption: [Výsledný graf $H$ -- modře vyznačené hrany váhy 1, červeně váhy 2]
) <tsp-h>

Na @sol-h[obrázku] je vyznačen hamiltonovský cyklus nalezený v grafu $H$.  
Zvýrazněné hrany tvoří cyklus délky $k = 6$, tedy rovné počtu vrcholů grafu.

Protože cyklus používá pouze hrany s váhou 1,  
odpovídá tento cyklus přímo hamiltonovskému cyklu ve vstupním grafu $G$.  
// Tím je ukázána korektnost redukce na konkrétní instanci.

#figure(
raw-render(```
  graph {
    layout=neato
      splines=true
  overlap=false
    node [
      shape=circle
    ]

    A [pos="0,2!"]
    B [pos="2,3!"]
    C [pos="4,2!"]
    D [pos="4,0!"]
    E [pos="2,0!"]
    F [pos="0,0!"]

    edge [color=blue label=""]

    A -- B [penwidth=3]
    B -- C
    C -- D [penwidth=3]
    D -- E [penwidth=3]
    E -- F [penwidth=3]
    F -- A
    A -- C [penwidth=3]
    B -- E 
    B -- F [penwidth=3]

    edge [color=red label="" splines=curved]

    A -- E
    A -- D
    B -- D
    C -- E
    C -- F
    D -- F

  }
```),
caption: [Hamiltonovský cyklus v grafu $H$ s váhou $k = 6$]
) <sol-h>

