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

#figure(
  image("../assets/screenshots/3sat-3cg-yes-page.png", height: 97%), 
  caption: [Vstupní instance 3-SAT a výsledná grafová instance 3-CG (kladná odpověď)]
)

#figure(
  grid(
    columns: 2, 
    image("../assets/screenshots/3sat-3cg-yes-step-1.png"), 
    image("../assets/screenshots/3sat-3cg-yes-step-2.png"), 
    image("../assets/screenshots/3sat-3cg-yes-step-3.png"), 
  ),
  caption: [Krokové zobrazení redukce 3-SAT na 3CG (kladná odpověď)]
)

=== Instance se zápornou odpovědí

Formule:
$
  (x or x or x) and
  (not x or not x or not x)
$

Demonstruje případ, kdy graf není 3-obarvitelný,
protože konflikt v klauzulích vynutí protichůdné podmínky pro obarvení.

#figure(
  image("../assets/screenshots/3sat-3cg-no-page.png", height: 97%), 
  caption: [Vstupní instance 3-SAT a výsledná grafová instance 3-CG (záporná odpověď)]
)
