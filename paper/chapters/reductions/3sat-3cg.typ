#import "@preview/diagraph:0.3.6": *

== Redukce 3-SAT na 3-CG

// https://www.youtube.com/watch?v=fMh42fsIf0Q

Redukce vstupní instance problému 3-SAT na instanci problému 3-CG, tedy na neorientovaný graf,
je založena na konstrukci několika typů speciálních konstrukčních prvků:

- jádrového konstrukčního prvku,
- konstrukčních prvků proměnných a
- konstrukčních prvků klauzulí.

=== Jádrový konstrukční prvek

Jádrový konstrukční prvek tvoří tři vrcholy -- $T$, $F$ a $B$.
Tyto vrcholy jsou navzájem propojeny tak, že vytvářejí cyklus, 
konkrétně hranami ${T,B}$, ${F,B}$ a ${T,F}$.
Obarvení vrcholů tohoto podgrafu je jednoznačně dané,
vrchol $T$ je nabarven zeleně (G), vrchol $F$ červeně (R) a vrchol $B$ modře (B).

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

    ```),
  caption: [Jadrový konstrukční prvek instance problému 3-CG],
)

=== Konstrukční prvek proměnné

Pro každou proměnnou $v in cal(V)(Phi)$ se vytvoří odpovídající konstrukční prvek proměnné.
Ten je tvořen trojicí vrcholů: $v$, $not v$ a vrcholem $B$ z jádrového konstrukčního prvku.
Mezi těmito vrcholy jsou zavedeny hrany
${v, not v}$, ${v, B}$ a ${not v, B}$,
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
  )),
  caption: [Konstrukční prvky proměnných $alpha, beta$ a $gamma$]
)

=== Konstrukční prvek klauzule

Pro každou klauzuli $kappa in Phi$ se sestrojí samostatný konstrukční prvek klauzule.
Nechť
$kappa = {Alpha, Beta, Gamma}$,
kde $Alpha$, $Beta$ a $Gamma$ představují literály proměnných $alpha$, $beta$ a $gamma$ v daném pořadí.

Literály, značené velkými řeckými písmeny, mohou vystupovat buď v neznegované, nebo v negované podobě.
Například literál $Alpha$ může odpovídat buď $alpha$, nebo $not alpha$.

Konstrukční prvek klauzule obsahuje

6 vlastních vrcholů,
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
  {Gamma, kappa_2}, 
  {kappa_0, kappa_3},
  {kappa_1, kappa_4},
  {kappa_2, kappa_5},
  {kappa_3, kappa_4},
  {kappa_4, kappa_5},  
  {T, kappa_0},
  {T, kappa_1},
  {T, kappa_2},
  {T, kappa_3}, 
  {kappa_5, F}.
$

