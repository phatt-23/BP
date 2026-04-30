#import "/lib/global.typ": *
#import "@preview/diagraph:0.3.6": *

= Vybrané NP-úplné problémy

Tato kapitola představuje vybrané NP-úplné problémy, 
se kterými pracuje navržený systém. 
Pro každý problém je uvedena 
jeho formální definice, 
popis vstupu 
a formulace rozhodovací otázky. 
Ukážeme si také konkrétní  
  instance těchto problémů s kladnou odpovědí 
  i instance se zápornou odpovědí. 

#let ham_cyklus_kruznice = [
  Obecně se pojem hamiltonovský cyklus vztahuje jak na orientované, tak na neorientované grafy.
  Pro zachování přehlednosti a terminologické jednoznačnosti 
  však budeme v této práci používat následující konvenci:
  - pojem hamiltonovský cyklus bude používán výhradně pro orientované grafy,
  - pojem hamiltonovská kružnice bude používán výhradně pro neorientované grafy.

  V obou případech budeme o grafu říkat, že je hamiltonovský, 
  pokud obsahuje hamiltonovský cyklus (v případě orientovaného grafu), 
  resp. hamiltonovskou kružnici (v případě grafu neorientovaného).
]

V této práci se zaměřujeme na následující NP-úplné problémy:
- 3-SAT -- splnitelnost booleovské formule v 3-konjunktivní normální formě,
- HCYCLE -- existence hamiltonovského cyklu v orientovaném grafu,
- HCIRCUIT -- existence hamiltonovské kružnice #footnote[#ham_cyklus_kruznice] v neorientovaném grafu,
- TSP -- problém obchodního cestujícího,
- SSP -- problém podmnožinového součtu,
- 3-CG -- 3-obarvitelnost vrcholů grafu.

Tyto problémy slouží jako základní stavební kameny 
pro demonstraci redukcí a jejich vizualizaci.

#include "./2.3sat.typ"
#pagebreak()
#include "./2.hcycle.typ"
#pagebreak()
#include "./2.hcircuit.typ"
#pagebreak()
#include "./2.tsp.typ"
#pagebreak()
#include "./2.ssp.typ"
#pagebreak()
#include "./2.3cg.typ"
#pagebreak()
