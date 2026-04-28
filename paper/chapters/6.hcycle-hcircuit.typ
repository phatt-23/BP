== Redukce HCYCLE na HCIRCUIT

=== Instance s kladnou odpovědí

Orientovaný graf $G$ s hamiltonovským cyklem:
$
  V = \{A, B, C, D\}, 
  E = \{(A,B), (B,C), (C,D), (D,A), (A,C)\}
$

Instance ilustruje transformaci orientovaného grafu na neorientovaný
pomocí trojic vrcholů $v_i, v_b, v_o$.

// #figure(image("../assets/screenshots/hcycle-hcircuit-yes-input.png"), caption: [Zadání instance HCYCLE (kladná odpověď)])
#figure(image("../assets/screenshots/hcycle-hcircuit-yes-input-output-fullpage.png"), 
  caption: [Zadání instance HCYCLE a výsledný graf po redukcia (kladná odpověď)])
// #figure(image("../assets/screenshots/hcycle-hcircuit-yes-output.png"), caption: [Výsledný graf po redukci (kladná odpověď)])
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
  V = \{A, B, C, D, E\}, 
  E = \{(A,B), (A,C), (B,D), (B,E)\}
$

Demonstruje neexistenci hamiltonovského cyklu v acyklickém grafu
a jak aplikace zpracovává negativní odpověď.

#figure(image("../assets/screenshots/hcycle-hcircuit-no-input-output-fullpage.png"), 
  caption: [Zadání instance HCYCLE a výsledný graf po redukcia (záporná odpověď)])

