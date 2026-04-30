== Architektura systému

=== Architektonický model

Aplikace je navržena jako čistě klientská webová aplikace bez serverové části.
Veškerá aplikační logika je vykonávána na straně klienta
v prostředí webového prohlížeče.
Aplikace je distribuována ve formě statických souborů.

// Tento přístup umožňuje jednoduché nasazení a minimalizuje
// požadavky na infrastrukturu.



// TODO[x]: toto dát do vět
// Aplikace je rozdělena na:
// - uživatelské rozhraní (dále jako UI)
// - bussiness logiku.
//
// Kód UI zahrnuje komponenty pro:
// - domovská strána,
// - jednotlivé stránky redukcí,
// - navigační lištu,
// - editory vstupních instancí,
// - kontrolní panely,
// - grafická reprezentace vstupních a výstupních instancí,
// - grafická reprezentace řešení vstupních a výstupních instancí,
// - karty pro jetdnotlivé kroky redukce apod.
// UI aplikace je dále rozebráno v @ui-chapter[kapitole].
//
// Kód bussiness logiky se skládá z:
// - datových struktur reprezentující instance jednotlivých problému,
// - modulů, které společně převádí a transformují data (vstupní a výstupní instance)  
//   nezávisle od sebe, každý modul má svůj "cíl"
//
// Konkrétně jsou v této aplikaci datovými strukturami reprezentovány:
// - grafy, 
// - booleovské výrazy v 3-KNF,
// - instance problému SSP - tedy seznam přirozených čísel a cílová hodnota.
//
// Moduly jsou:
// - redukční modul (reducer) 
//   - převádí instance jednoho problému na instance jiného problému,
// - řešící modul (solver) 
//   - "řeší" instance problému, nalézají řešení,
// - dékodovací modul (decoder) 
//   - pokud je řešení nalezeno, tak tento modul převede řešení jednoho problému na řešení jiného problému, 
//   - přičemž tento decoder funguje jen pokud je původní řešení ve správném formátu. 
//     Jinými slovy není možné pro libovolné řešení jednoho problému převést na řešení jiného problému, ale tohle je jasné.


Aplikace je rozdělena na uživatelské rozhraní (dále jen UI) a business logiku.

Kód UI zahrnuje komponenty pro 
  domovskou stránku, 
  jednotlivé stránky redukcí, 
  navigační lištu, 
  editory vstupních instancí, 
  kontrolní panel, 
  grafickou reprezentaci vstupních a výstupních instancí, 
  grafickou reprezentaci řešení a karty pro jednotlivé kroky redukce. 
UI aplikace je dále rozebráno v @ui-chapter[kapitole].

Kód business logiky se skládá z 
datových struktur reprezentujících instance jednotlivých problémů a z modulů.
V této aplikaci se vyskytují tři typy modulů: redukční (reducer), řešící (solver) a dekódovací (decoder) modul. 
Redukční modul převádí instance jednoho problému na instance jiného problému. 
Řešící modul se pokouší nalézt řešení zadané instance. 
Dekódovací modul převádí nalezené řešení výstupního problému na řešení vstupního problému. 

// TODO[x]
// i want a plantuml diagram here
// showing that the app consists of UI and bussiness logic compartments / components
// UI comp in turn consists of (svelte) UI components
// bussiness comp consists of the reducer, solver and decoder modules and data strucutres of problem instances

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
3. Redukční modul transformuje vstupní instanci na instanci cílového problému.
   Zároveň také vytváří krokový průběh redukce.
4. Řešicí modul se pokusí nalézt řešení cílové instance.
5. V případě úspěchu dekodér převede nalezené řešení zpět
   na řešení původní instance.

// TODO[x]: přidat diagram (nějaký vhodný), který zobrazuje tyto kroky
#figure(
  image("../assets/plantuml/data-flow-flow-chart.svg"), 
  caption: [Vývojový diagram toku dat]
)

