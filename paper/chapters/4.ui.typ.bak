// TODO: přidat wireframe diagramy

== Návrh uživatelského rozhraní <ui-chapter>

// TODO: intro nejaky by se hodilo

=== Struktura rozhraní

Stránka má navigační lištu, 
kde jsou odkazy na domovkou stránku 
a stránky jednotlivých redukcí.

Domovská stránka obsahuje obecné informace o aplikaci
a krátké definice problémů vyskytujicíh se v převodech.

// TODO:
// par vet o strankach redukci, 
// nez se vrhnem primo na dalsi podkapitolu

=== Struktura stránek redukcí

Uživatelské rozhraní je rozděleno do tří hlavních karet:

- editor,
- vstupní instance,
- výstupní instance.

Toto rozdělení umožňuje jasné oddělení zadání problému,
jeho reprezentace a výsledku zpracování.


=== Editor vstupu

Karta editor obsahuje textový vstup a kontrolní panel.

Editor slouží k zadávání vstupní instance.
V jeho horní části se nachází výběr ukázkových instancí.
Při syntaktické chybě vstupu je uživatel informován chybovou hláškou.

Kontrolní panel obsahuje tlačítka "Reduce" a "Solve"
a přepínač "Show steps".


=== Vizualizace instancí

Karty vstupní a výstupní instance mají shodné rozložení:

- hlavička obsahuje název problému,
- hlavní část obsahuje grafickou reprezentaci instance,
- zápatí obsahuje nalezené řešení nebo informaci o jeho neexistenci.

Zadaná instance je průběžně vizualizována,
což umožňuje okamžitou kontrolu správnosti vstupu.


=== Krokové zobrazení redukce

Přepínač "Show steps" umožňuje zobrazit jednotlivé kroky redukce.

Proces redukce je prezentován sekvenčně,
přičemž každý krok transformace je graficky zvýrazněn
a doplněn textovým vysvětlením.

Tento přístup umožňuje uživateli pochopit nejen výslednou instanci,
ale i samotný konstrukční postup.


=== Zobrazení řešení

Po aktivaci funkce "Solve" se aplikace pokusí nalézt řešení cílového problému.

V případě úspěchu je nalezené řešení zobrazeno
a následně dekódováno na řešení vstupního problému,
které je rovněž prezentováno uživateli.

Obě řešení jsou zobrazena v zápatí příslušných karet
a v případě vhodnosti jsou také graficky zvýrazněna.

Například:
- u problému obchodního cestujícího jsou zvýrazněny hrany Hamiltonovského cyklu,
- u problému barvení grafu jsou vrcholy obarveny,
- u problému 3SAT je řešení zpravidla prezentováno textově.

// Způsob vizualizace je volen s ohledem na přehlednost
// a srozumitelnost i pro složitější instance

