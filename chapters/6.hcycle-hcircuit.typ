== Redukce HCYCLE na HCIRCUIT

=== Instance s kladnou odpovědí

Ukázkovou instancí je orientovaný graf s hamiltonovským cyklem:
$
  V = {C_1, C_2, C_3, C_4} \

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

#figure(image("../assets/screenshots/hcycle-hcircuit-yes-page.png", height: 97%), 
  caption: [Vstupní instance HCYCLE a výsledný graf HCIRCUIT (kladná odpověď)])

#figure(
  grid(
    columns: 2, 
    image("../assets/screenshots/hcycle-hcircuit-yes-step-1.png"), 
    image("../assets/screenshots/hcycle-hcircuit-yes-step-2.png"), 
  ),
  caption: [Krokové zobrazení redukce HCYCLE na HCIRCUIT (kladná odpověď)]
)


=== Instance se zápornou odpovědí

Ukázkovou instancí je orientovaný acyklický graf:
$
  V = {C_1, C_2, C_3, C_4} \
  E = {
    (C_1,C_3),
    (C_2,C_3),
    (C_2,C_1),
    (C_2,C_3),
    (C_3,C_4),
    (C_4,C_1)
  }
$

Demonstruje neexistenci hamiltonovského cyklu v acyklickém grafu
a jak aplikace zpracovává zápornou odpověď.

#figure(image("../assets/screenshots/hcycle-hcircuit-no-page.png", height: 97%), 
  caption: [Vstupní instance HCYCLE a výsledný graf HCIRCUIT (záporná odpověď)])

