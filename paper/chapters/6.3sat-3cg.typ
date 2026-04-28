== Redukce 3-SAT na 3-CG

=== Instance s kladnou odpovědí

Formule:
$
  (alpha or beta or gamma) and (not alpha or beta or not gamma)
$

Instance ukazuje:
- jádrový konstrukční prvek a jeho obarvení,
- konstrukční prvky proměnných,
- propojení s konstrukčními prvky klauzulí.

#figure(image("../assets/screenshots/3sat-3cg-yes-input.png"), caption: [Zadání instance 3-SAT (kladná odpověď)])
#figure(image("../assets/screenshots/3sat-3cg-yes-output.png"), caption: [Výsledný graf po redukci (kladná odpověď)])
#figure(
  grid(
    columns: 3, 
    image("../assets/screenshots/3sat-3cg-yes-step-1-fullpage.png"), 
    image("../assets/screenshots/3sat-3cg-yes-step-2-fullpage.png"), 
    image("../assets/screenshots/3sat-3cg-yes-step-3-fullpage.png"), 
  ),
  caption: [Krokové zobrazení redukce 3-SAT na 3CG (kladná odpověď)]
)

=== Instance se zápornou odpovědí

Formule:
$
  (a or a or a) and (not a or not a or not a)
$

Demonstruje případ, kdy graf není 3-obarvitelný,
protože konflikt v klauzulích vynutí protichůdné podmínky pro obarvení.

#figure(image("../assets/screenshots/3sat-3cg-no-input.png"), caption: [Zadání instance 3-SAT (záporná odpověď)])
#figure(image("../assets/screenshots/3sat-3cg-no-output.png"), caption: [Výsledný graf po redukci (záporná odpověď)])
#figure(
  grid(
    columns: 3, 
    image("../assets/screenshots/3sat-3cg-no-step-1-fullpage.png"), 
    image("../assets/screenshots/3sat-3cg-no-step-2-fullpage.png"), 
    image("../assets/screenshots/3sat-3cg-no-step-3-fullpage.png"), 
  ),
  caption: [Krokové zobrazení redukce 3-SAT na 3CG (záporná odpověď)]
)

