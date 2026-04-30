== Architektura systému

=== Architektonický model

Aplikace je navržena jako čistě klientská webová aplikace bez serverové části.
Veškerá aplikační logika je vykonávána na straně klienta
v prostředí webového prohlížeče.
Aplikace je distribuována ve formě statických souborů.

Aplikace je rozdělena na uživatelské rozhraní (dále jen UI) a business logiku.

Kód UI zahrnuje komponenty pro domovskou stránku,
jednotlivé stránky redukcí, navigační lištu, editory vstupních instancí,
kontrolní panel, grafickou reprezentaci vstupních a výstupních instancí,
grafickou reprezentaci řešení a karty pro jednotlivé kroky redukce.
UI aplikace je dále rozebráno v @ui-chapter[kapitole].

Kód business logiky se skládá z datových struktur reprezentujících
instance jednotlivých problémů a z modulů.
V této aplikaci se vyskytují tři typy modulů: redukční (reducer),
řešící (solver) a dekódovací (decoder).
Redukční modul převádí instance jednoho problému na instance jiného problému.
Řešící modul se pokouší nalézt řešení zadané instance.
Dekódovací modul převádí nalezené řešení výstupního problému na řešení vstupního problému,
pokud je řešení v očekávaném formátu.

#figure(
  image("../assets/plantuml/component-diagram.svg"),
  caption: [
    Diagram komponent aplikace
  ]
)

=== Zpracování dat

Zpracování dat v systému probíhá v následujících krocích:

1. Uživatel zadá instanci vstupního problému.
2. Instance je převedena do interní reprezentace systému.
3. Redukční modul transformuje vstupní instanci na instanci cílového problému
   a vytváří krokový průběh redukce.
4. Řešící modul se pokusí nalézt řešení cílové instance.
5. V případě úspěchu dekódovací modul převede nalezené řešení zpět
   na řešení původní instance.

#figure(
  image("../assets/plantuml/data-flow-flow-chart.svg"),
  caption: [Vývojový diagram toku dat]
)

