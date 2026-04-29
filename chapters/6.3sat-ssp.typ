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

#figure(
  image("../assets/screenshots/3sat-ssp-yes-page.png", height: 97%),
  caption: [Zadání instance 3-SAT a výsledná množina čísel SSP (kladná odpověď)]
)

#figure(
  image("../assets/screenshots/3sat-ssp-yes-output-3sat-format.png"),
  caption: [Výsledná množina čísel SSP zobrazená s 3-SAT formátováním])

#figure(
  grid(
    columns: 2, 
    image("../assets/screenshots/3sat-ssp-yes-step-1.png"), 
    image("../assets/screenshots/3sat-ssp-yes-step-2.png"), 
    image("../assets/screenshots/3sat-ssp-yes-step-3.png"), 
    image("../assets/screenshots/3sat-ssp-yes-step-4.png"), 
  ),
  caption: [Krokové zobrazení redukce 3-SAT na SSP (kladná odpověď)]
)

#pagebreak()

=== Instance se zápornou odpovědí

Formule:
$
  (x or x or x) and (not x or not x or not x)
$

Demonstruje případ, kdy nelze dosáhnout cílové hodnoty $tau$,
protože žádná podmnožina neumožňuje splnění všech klauzulí.

#figure(
  image("../assets/screenshots/3sat-ssp-no-page.png", height: 97%), 
  caption: [Zadání instance 3-SAT a výsledná množina čísel SSP (záporná odpověď)]
)

