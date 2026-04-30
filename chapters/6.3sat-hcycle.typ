#import "/lib/global.typ": *

== Redukce 3-SAT na HCYCLE

=== Instance s kladnou odpovědí

Jako ukázková instance byla zvolena formule:
$
  (x or y or z) and (not x or y or not z) and (x or not y or z)
$

Tato instance byla vybrána z následujících důvodů:
- obsahuje dostatečný počet proměnných pro demonstraci řetězce konstrukčních prvků,
- kombinuje neznegované i negované literály,
- je snadno ověřitelná ručním výpočtem.

#figure(
  image("../assets/screenshots/3sat-hcycle-yes-page.png", height: 97%),
  caption: [Vstupní instance 3-SAT a výsledná instance HCYCLE (kladná odpověď)]
)

#figure(
  grid(
    columns: 2,
    image("../assets/screenshots/3sat-hcycle-yes-step-1.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-2.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-3.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-4.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-5.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-6.png"),
  ),
  caption: [Krokové zobrazení redukce 3-SAT na HCYCLE (kladná odpověď)]
)

#pagebreak()

=== Instance se zápornou odpovědí

Ukázková instance:
$
  (a or a or a) and
  (not a or not a or b) and
  (not b or not b or not b)
$

Tato instance je nesplnitelná, což demonstruje,
že výsledný graf neobsahuje hamiltonovský cyklus.
Instance je užitečná pro ilustraci toho, jak aplikace zpracovává instance se zápornou odpovědí.

#figure(
  image("../assets/screenshots/3sat-hcycle-no-page.png", height: 97%),
  caption: [Vstupní instance 3-SAT a výsledná instance HCYCLE (záporná odpověď)]
)

