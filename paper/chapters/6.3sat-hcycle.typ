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
  image("../assets/screenshots/3sat-hcycle-yes-input.png"),
  caption: [Zadání instance 3-SAT (kladná odpověď)]
)

#figure(
  image("../assets/screenshots/3sat-hcycle-yes-output.png"),
  caption: [Výsledný graf po redukci (kladná odpověď)]
)

#figure(
  grid(
    columns: 3,
    image("../assets/screenshots/3sat-hcycle-yes-step-1-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-2-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-3-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-4-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-5-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-yes-step-6-fullpage.png"),
  ),
  caption: [Krokové zobrazení redukce 3-SAT na HCYCLE (kladná odpověď)]
)

=== Instance se zápornou odpovědí

Ukázková instance:
$
  (a or a or a) and
  (not a or not a or b) and
  (not b or not b or not b)
$

Tato instance je nesplnitelná, což demonstruje,
že výsledný graf neobsahuje hamiltonovský cyklus.
Instance je užitečná pro ilustraci toho, jak aplikace zpracovává instance se zápornou odpovědi.

#figure(
  image("../assets/screenshots/3sat-hcycle-no-input.png"),
  caption: [Zadání instance 3-SAT (záporná odpověď)]
)

#figure(
  image("../assets/screenshots/3sat-hcycle-no-output.png"),
  caption: [Výsledný graf po redukci (záporná odpověď)]
)

#figure(
  grid(
    columns: 3,
    image("../assets/screenshots/3sat-hcycle-no-step-1-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-no-step-2-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-no-step-3-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-no-step-4-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-no-step-5-fullpage.png"),
    image("../assets/screenshots/3sat-hcycle-no-step-6-fullpage.png"),
  ),
  caption: [Krokové zobrazení redukce 3-SAT na HCYCLE (záporná odpověď)]
)

