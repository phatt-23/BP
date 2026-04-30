#import "/lib/global.typ": *
#import "@preview/diagraph:0.3.6": *
#import "./2.common.typ": *

== SSP

Problém SSP (Subset Sum Problem, SSP) spočívá v určení, 
zda pro danou konečnou množinu přirozených čísel:
$
  S subset.eq NN
$ 
a cílovou hodnotu $tau in NN$ 
existuje podmnožina $S' subset.eq S$, 
jejíž součet prvků je roven dané cílové hodnotě $tau$:

$
  sum_(s in S') s = tau.
$

#rozhod-forma

/ Vstup:
  Konečná množina přirozených čísel $S subset.eq NN$ a cílová hodnota $tau in NN$.

/ Otázka:
  Existuje podmnožina $S' subset.eq S$ taková, 
  že součet jejích prvků je roven $tau$?

#kladna-odpo

Mějme množinu čísel:
$
  S = {3,7,10,5}
$
a cílovou hodnotu $tau = 15$.

Validním řešením je $S' = {10,5}$, protože:
$
  sum_(s in S') s = 10 + 5 = 15 = tau.
$

Dalším možným je $S'' = {3,7,5}$, protože: 
$
  sum_(s in S'') s = 3 + 7 + 5 = 15 = tau
$


#zaporna-odpo

Mějme množinu čísel:
$
  S = {3,5,11}
$
a cílovou hodnotu $tau = 10$.

Tato instance nemá řešení. 
Ať už vybereme jakoukoli kombinaci prvků z množiny $S$, 
nikdy nebude součet těchto prvků roven $10$.

$
  S' subset.eq S \
  S' in {emptyset, {3}, {5}, {11}, {3,5}, {3,11}, {5,11}, {3,5,11}} \
  sum_(s in S') s != 10
$

