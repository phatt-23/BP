#import "/lib/global.typ": *
#import "@preview/diagraph:0.3.6": *
#import "./2.common.typ": *

== HCYCLE

Uvažujme orientovaný graf:
$
  G = (V,E),
$
kde $V$ je množina vrcholů a $E subset.eq V times V$ je množina orientovaných hran.

Problém hamiltonovského cyklu (Hamiltonian Cycle Problem, HCYCLE) spočívá v určení, 
zda graf $G$ obsahuje hamiltonovský cyklus, 
tj. posloupnost vrcholů

$
  P = (v_1, v_2, ..., v_(lr(|V|) - 1), v_lr(|V|), v_1)
$

která splňuje následující podmínky:

- každý vrchol z množiny $V$ se v posloupnosti $P$ vyskytuje právě jednou 
  s výjimkou počátečního a koncového vrcholu $v_1$,

- platí $(v_i,v_(i+1)) in E$ pro $1 <= i < |V|$ a $(v_lr(|V|), v_1) in E$.

Jinými slovy, hamiltonovský cyklus je orientovaná uzavřená cesta, 
která prochází všemi vrcholy grafu právě jednou.
Graf, který hamiltonovský cyklus obsahuje, nazýváme hamiltonovský.

#rozhod-forma
/ Vstup: 
  Orientovaný graf $G = (V,E)$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovký cyklus?

#kladna-odpo

Mějme graf $G = (V,E)$, kde:

$
  V = {A,B,C,D,E,F} \
  E = {
    {A , C},
    {B , D},
    {C , E},
    {A , B}, 
    {B , C}, \
    {C , D}, 
    {D , E}, 
    {E , F}, 
    {F , A}
  }.
$

#figure(
  raw-render(```dot
    digraph CycleWithExtraEdges {
      layout=neato
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -> C
      B -> D
      C -> E

      edge [color=red penwidth=2]
      A -> B 
      B -> C 
      C -> D 
      D -> E 
      E -> F 
      F -> A 
    }
  ```, height: 25%),
  caption: [Instance problému HCYCLE s kladnou odpovědí],
)

Graf $G$ je hamiltonovský, protože obsahuje hamiltonovský cyklus popsán uzavřenou cestou:
$
  P = (A,B,C,D,E,F,A).
$

#zaporna-odpo

Mějme graf:

#figure(
  raw-render(```dot
    digraph {
      layout=circo
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      C_1 -> C_3
      C_2 -> C_3
      C_2 -> C_1
      C_3 -> C_4
      C_4 -> C_1

    }
  ```, width: 35%),
  caption: [Instance problému HCYCLE se zápornou odpovědí],
)

Tento graf neobsahuje hamiltonovský cyklus.

