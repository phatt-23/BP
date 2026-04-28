== Redukce 3-SAT na SSP

=== Instance s kladnou odpovědí

Formule:
$
  (alpha or beta or gamma) and
  (not alpha or beta or gamma) and
  (alpha or not or beta or gamma)
$

Instance demonstruje:
- reprezentaci proměnných pomocí dvojic čísel,
- vliv klauzulí na jednotlivé číslice,
- funkci vyrovnávacích čísel.

#figure(image("../assets/screenshots/3sat-ssp-yes-input.png"), caption: [Zadání instance 3-SAT (kladná odpověď)])
#figure(image("../assets/screenshots/3sat-ssp-yes-output.png"), caption: [Výsledná množina čísel SSP (kladná odpověď)])
#figure(
  grid(
    columns: 2, 
    image("../assets/screenshots/3sat-ssp-yes-step-1.png"), 
    image("../assets/screenshots/3sat-ssp-yes-step-2-fullpage.png"), 
    image("../assets/screenshots/3sat-ssp-yes-step-3-fullpage.png"), 
    image("../assets/screenshots/3sat-ssp-yes-step-4-fullpage.png"), 
  ),
  caption: [Krokové zobrazení redukce 3-SAT na SSP (kladná odpověď)]
)


=== Instance se zápornou odpovědí

Formule:
$
  (x or x or x) and (not x or not x or not x)
$

Demonstruje případ, kdy nelze dosáhnout cílové hodnoty $tau$,
protože žádná podmnožina neumožňuje splnění všech klauzulí.

#figure(image("../assets/screenshots/3sat-ssp-no-input.png"), caption: [Zadání instance 3-SAT (záporná odpověď)])
#figure(image("../assets/screenshots/3sat-ssp-no-output.png"), caption: [Výsledná množina čísel SSP (záporná odpověď)])
#figure(
  grid(
    columns: 2, 
    image("../assets/screenshots/3sat-ssp-no-step-1.png"), 
    image("../assets/screenshots/3sat-ssp-no-step-2-fullpage.png"), 
    image("../assets/screenshots/3sat-ssp-no-step-3-fullpage.png"), 
    image("../assets/screenshots/3sat-ssp-no-step-4-fullpage.png"), 
  ),
  caption: [Krokové zobrazení redukce 3-SAT na SSP (záporná odpověď)]
)

