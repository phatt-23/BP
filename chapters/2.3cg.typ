#import "/lib/global.typ": *
#import "@preview/diagraph:0.3.6": *
#import "./2.common.typ": * 

== 3-CG

Uvažujme neorientovaný graf
$G = (V,E)$,
kde $V$ je množina vrcholů
a $E subset.eq {{u,v} | u,v in V and u eq.not v}$.
Nechť $K$ je množina tří barev, například červené, zelené a modré:
$
  K = {R,G,B}
$

Problém barvení grafu třemi barvami (3-Coloring Graph Problem, 3-CG) spočívá v určení, 
zda existuje zobrazení:
$
  kappa : V -> K,
$
které každému vrcholu přiřadí právě jednu barvu tak, 
aby žádné dva sousední vrcholy neměly stejnou barvu.

Formálně požadujeme, aby pro každou hranu ${u,v} in E$ platilo 
$kappa(u) eq.not kappa(v)$.

#rozhod-forma

/ Vstup: Neorientovaný graf $G = (V,E)$.

/ Otázka: Lze vrcholy grafu obarvit 3 barvami tak, aby žádné dvě sousední nesdíleli stejnou barvu?

#kladna-odpo

Mějme neorientovaný graf $G = (V,E)$, kde:
$
  V = {A,B,C,D,E} \
  E = {{A,B}, {A,C}, {B,C}, {B,D}, {C,E}, {D,E}}.
$

#figure(
  raw-render(```dot
    graph {
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
    
      A -- B
      A -- C
      B -- C
      B -- D
      C -- E
      D -- E
    }
  ```),
  caption: [Instance problému 3-CG s kladnou odpovědí],
)

#pagebreak()

Pro tento graf existuje řešení, existuje totiž validní předpis funkce $kappa : V -> K$:

$
  A -> R \
  B -> G \
  C -> B \
  D -> R \
  E -> G. \
$


#figure(
  raw-render(```dot
    graph {
      layout=neato
      
      node [
        shape=circle 
        width=0.1
        penwidth=2
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A [color=red]
      B [color=green]
      C [color=blue]
      D [color=red]
      E [color=green]
    
      A -- B
      A -- C
      B -- C
      B -- D
      C -- E
      D -- E
    }
  ```),
  caption: [Validní obarvení grafu třemi barvami],
)


#zaporna-odpo

Mějme neorientovaný graf $G = (V,E)$, kde:
$
  V = {A,B,C,D} \
  E = {{A,B}, {A,C}, {A,D}, {D,C}, {B,D}, {B,C}}.
$


#figure(
  raw-render(```dot
    graph {
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
    
      node [penwidth=2]
      A [color=red]
      B [color=blue]
      C [color=green]

      node [penwidth=1]
      D [xlabel="nezbývá žádná barva\n pro obarvení vrcholu"]

      A -- B
      A -- C
      A -- D
      B -- C
      B -- D
      C -- D
    }
  ```),
  caption: [Instance problému 3-CG se zápornou odpovědí],
)

Pokud obarvíme vrcholy $A$, $B$ a $C$ každý jinou barvou, 
nezbude žádná barva pro vrchol $D$.
Ten totiž nemůžeme obarvit žádnou ze tří použitých barev, 
protože je incidentní ke všem ostatním vrcholům, které už tyto barvy mají.


