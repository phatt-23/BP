== Redukce HCYCLE na HCIRCUIT

=== Instance s kladnou odpovědí

Orientovaný graf $G$ s hamiltonovským cyklem:
$
  V = {C_1, C_2, C_3, C_4} \\

  E = {
    (C_1, C_3),
    (C_3, C_2),
    (C_2, C_1),
    (C_1, C_2),
    (C_2, C_3),
    (C_3, C_4),
    (C_4, C_1)
  }
$

// #figure(image("../assets/screenshots/hcycle-hcircuit-yes-input.png"), caption: [Zadání instance HCYCLE (kladná odpověď)])
// #figure(image("../assets/screenshots/hcycle-hcircuit-yes-output.png"), caption: [Výsledný graf po redukci (kladná odpověď)])
#figure(image("../assets/screenshots/hcycle-hcircuit-yes-input-output-fullpage.png"), 
  caption: [Zadání instance HCYCLE a výsledný graf po redukcia (kladná odpověď)])

#figure(
  grid(
    columns: 2, 
    image("../assets/screenshots/hcycle-hcircuit-yes-step-1-fullpage.png"), 
    image("../assets/screenshots/hcycle-hcircuit-yes-step-2-fullpage.png"), 
  ),
  caption: [Krokové zobrazení redukce HCYCLE na HCIRCUIT (kladná odpověď)]
)

=== Instance se zápornou odpovědí

Orientovaný strom (acyklický graf):
$
  V = {C_1, C_2, C_3, C_4} \\
  E = {
    (C_1,C_3)
    (C_2,C_3)
    (C_2,C_1)
    (C_2,C_3)
    (C_3,C_4)
    (C_4,C_1)
  }
$

Demonstruje neexistenci hamiltonovského cyklu v acyklickém grafu
a jak aplikace zpracovává negativní odpověď.

#figure(image("../assets/screenshots/hcycle-hcircuit-no-input-output-fullpage.png"), 
  caption: [Zadání instance HCYCLE a výsledný graf po redukcia (záporná odpověď)])

