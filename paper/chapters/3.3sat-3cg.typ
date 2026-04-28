#import "@preview/diagraph:0.3.6": *

#import "/lib/global.typ": * 
#load-bib(main: false)

== Redukce 3-SAT na 3-CG <sec-redukce-3sat-3cg>

Tato redukce vychází z myšlenek prezentovaných v @three-sat-to-3cg-yt.

Redukce vstupní instance problému 3-SAT na instanci problému 3-CG, tedy na neorientovaný graf,
je založena na konstrukci několika typů speciálních konstrukčních prvků:

- jádrového konstrukčního prvku,
- konstrukčních prvků proměnných a
- konstrukčních prvků klauzulí.

=== Jádrový konstrukční prvek

Jádrový konstrukční prvek tvoří tři vrcholy -- $T$, $F$ a $N$.
Tyto vrcholy jsou navzájem propojeny tak, že vytvářejí cyklus, 
konkrétně hranami ${T,N}$, ${F,N}$ a ${T,F}$.
Obarvení vrcholů tohoto podgrafu je jednoznačně dané,
vrchol $T$ je nabarven zeleně (G), vrchol $F$ červeně (R) a vrchol $N$ modře (B).

#figure(
  raw-render(```dot
    graph {
      layout=circo
      node [shape=circle penwidth=2]
      T [color=green]
      F [color=red]
      B [color=blue]

      T -- F -- B -- T
    }
    ```,
  labels: (
    "B": "N",
  )),
  caption: [Jadrový konstrukční prvek instance problému 3-CG],
)

Vrcholy tohoto podgrafu mají intuitivní význam odpovídající pravdivostním hodnotám.
Vrchol $T$ reprezentuje hodnotu _True_, vrchol $F$ hodnotu _False_ a vrchol $N$ neutrální hodnotu.
Tomuto významu odpovídá i jejich obarvení v rámci 3-obarvení grafu.

=== Konstrukční prvek proměnné

Pro každou proměnnou $v in cal(V)(Phi)$ se vytvoří odpovídající konstrukční prvek proměnné.
Ten je tvořen trojicí vrcholů: $v$, $not v$ a vrcholem $N$ z jádrového konstrukčního prvku.
Mezi těmito vrcholy jsou zavedeny hrany
${v, not v}$, ${v, N}$ a ${not v, N}$,
čímž opět vzniká cyklus.

#figure(
  raw-render(```dot
    graph {
      layout=neato
      node [shape=circle ]

      T [color=green pos="-0.5,3!" penwidth=2]
      F [color=red pos="0.5,3!" penwidth=2]
      B [color=blue pos="0,2!" penwidth=2]

      T -- F -- B -- T
      
      a  [pos="-2.5,0!"]
      na [pos="-1.5,0!"]

      b  [pos="-0.5,0!"]
      nb [pos="0.5,0!"]

      c  [pos="1.5,0!"]
      nc [pos="2.5,0!"]

      B -- a -- na -- B
      B -- b -- nb -- B
      B -- c -- nc -- B
    }
  ```, labels: (
    "a": $alpha$,
    "na": $not alpha$,
    "b": $beta$,
    "nb": $not beta$,
    "c": $gamma$,
    "nc": $not gamma$,
    "B": "N",
  )),
  caption: [Konstrukční prvky proměnných $alpha, beta$ a $gamma$]
)

Tento prvek reprezentuje přiřazení pravdivostní hodnoty dané proměnné.
Vrchol $N$ je již pevně obarven modře, 
a protože jsou vrcholy $v$ a $not v$ s vrcholem $N$ sousední, 
nemohou být obarveny modře. 
Jejich obarvení je tedy omezeno na dvě zbývající barvy a to zelenou a červenou.

Zároveň jsou vrcholy $v$ a $not v$ spojeny hranou, 
a proto nemohou mít stejnou barvu. 
Právě jeden z nich tedy musí být zelený a druhý červený.

Zvolíme-li interpretaci, 
že zelená barva reprezentuje hodnotu _True_ a červená hodnotu _False_, 
potom obarvení jednoznačně určuje pravdivostní hodnotu proměnné:
- je-li vrchol $v$ zelený, potom $v = italic("True")$,
- je-li zelený vrchol $not v$, potom $v = italic("False")$.

=== Konstrukční prvek klauzule

Pro každou klauzuli $kappa in Phi$ se sestrojí samostatný konstrukční prvek klauzule.
Nechť
$
  kappa = {Alpha, Beta, Gamma},
$
kde $Alpha$, $Beta$ a $Gamma$ představují literály proměnných $alpha$, $beta$ a $gamma$ v daném pořadí.

Literály, značené velkými řeckými písmeny, mohou vystupovat buď v neznegované, nebo v negované podobě.
Například literál $Alpha$ může odpovídat buď vrcholu $alpha$, nebo vrcholu $not alpha$ 
v konstrukčním prvku příslušné proměnné. 
Stejná konvence platí i pro $Beta$ a $Gamma$.

Konstrukční prvek klauzule obsahuje 6 vlastních vrcholů,
$
  kappa_0,
  kappa_1,
  kappa_2,
  kappa_3,
  kappa_4,
  kappa_5,
$

3 vrcholy převzaté z konstrukčních prvků proměnných,
$
  Alpha,
  Beta,
  Gamma,
$

a 2 vrcholy z jádrového konstrukčního prvku:
$
  T,
  F.
$

Celkově tedy obsahuje 11 vrcholů.

Hrany mezi těmito vrcholy jsou definovány následovně:

$
  {Alpha, kappa_0},
  {Beta, kappa_1},
  {Gamma, kappa_2},  \
  {kappa_0, kappa_3},
  {kappa_1, kappa_4},
  {kappa_2, kappa_5},
  {kappa_3, kappa_4},
  {kappa_4, kappa_5},   \
  {T, kappa_0},
  {T, kappa_1},
  {T, kappa_2},
  {T, kappa_3}, 
  {kappa_5, F}.
$

#figure(
  raw-render(```dot
    graph {
      layout=neato
      node [shape=circle]

      T [color=green pos="-4,-2!" penwidth=2]
      F [color=red pos="3,-2!" penwidth=2]
      B [color=blue pos="0,4!" penwidth=2]

      a  [pos="-2.5,2!"]
      na [pos="-1.5,2!"]

      b  [pos="-0.5,2!"]
      nb [pos="0.5,2!"]

      c  [pos="1.5,2!"]
      nc [pos="2.5,2!"]

      B -- a -- na -- B
      B -- b -- nb -- B
      B -- c -- nc -- B

      kappa_0 [pos="-2,0!"]
      kappa_1 [pos="0,0!"]
      kappa_2 [pos="2,0!"]
      kappa_3 [pos="-2,-2!"]
      kappa_4 [pos="0,-2!"]
      kappa_5 [pos="2,-2!"]

      a -- kappa_0
      nb -- kappa_1
      c -- kappa_2
      kappa_0 -- kappa_3
      kappa_1 -- kappa_4
      kappa_2 -- kappa_5
      kappa_3 -- kappa_4
      kappa_4 -- kappa_5
      T -- kappa_0
      T -- kappa_1
      T -- kappa_2
      T -- kappa_3 
      kappa_5 -- F
    }
  ```, 
    labels: (
      "a": $alpha$,
      "na": $not alpha$,
      "b": $beta$,
      "nb": $not beta$,
      "c": $gamma$,
      "nc": $not gamma$,
      "B": "N",
    ), 
    width: 80%),
  caption: [Konstrukční prvky proměnných $alpha, beta$ a $gamma$ a klauzule $kappa = {alpha, not beta, gamma}$]
)

Toto uspořádání hran zajišťuje, 
že konstrukční prvek klauzule je 3-obarvitelný právě tehdy, 
když je daná klauzule splněna alespoň jedním svým literálem.

Celá struktura je navržena tak, 
že pokud je alespoň jeden z literálů $Alpha, Beta, Gamma$ pravdivý (zelený), 
existuje způsob, jak vhodně dobarvit vrcholy $kappa_0, dots, kappa_5$ tak, 
aby byly splněny všechny podmínky správného 3-obarvení.

Avšak jsou-li všechny tři literály nepravdivé (červené),
dojde k propagaci omezení obarvení přes hrany mezi vrcholy $kappa_i$, 
která vynutí konflikt -- některé dva sousední vrcholy by musely mít stejnou barvu 
nebo by některý vrchol neměl k dispozici žádnou přípustnou barvu. 
V takovém případě tedy validní 3-obarvení neexistuje.

#figure(
  raw-render(```dot
    graph {
      layout=neato
      node [shape=circle]

      T [color=green pos="-4,-2!" penwidth=3]
      F [color=red pos="3,-2!" penwidth=3]

      a  [pos="-2,2!" color=red penwidth=3]
      b  [pos="-0,2!" color=red penwidth=3]
      c  [pos="2,2!" color=red penwidth=3]

      kappa_0 [pos="-2,0!" color=blue penwidth=3]
      kappa_1 [pos="0,0!" color=blue penwidth=3]
      kappa_2 [pos="2,0!" color=blue penwidth=3]
      kappa_3 [pos="-2,-2!" color=red penwidth=3]
      kappa_4 [pos="0,-2!" color=green penwidth=3]
      kappa_5 [pos="2,-2!" xlabel="nemožné obarvit"]

      a -- kappa_0
      b -- kappa_1
      c -- kappa_2
      kappa_0 -- kappa_3
      kappa_1 -- kappa_4
      kappa_2 -- kappa_5
      kappa_3 -- kappa_4
      kappa_4 -- kappa_5
      T -- kappa_0
      T -- kappa_1
      T -- kappa_2
      T -- kappa_3 
      kappa_5 -- F
    }
  ```, 
    labels: (
      "a": $Alpha$,
      "b": $Beta$,
      "c": $Gamma$,
      "B": "N",
    ), 
    width: 100%),
  caption: [Neexistence validního 3-obarvení v případě nesplnění klauzule]
)

Celý graf je tedy 3-obarvitelný právě tehdy, 
když existuje ohodnocení proměnných, 
které splňuje všechny klauzule formule $Phi$.

