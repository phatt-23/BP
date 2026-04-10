= Návrh webové aplikace

== Úvod a účel aplikace

Cílem navrhované webové aplikace je převést teoretické poznatky z oblasti
výpočetní složitosti, konkrétně problematiku polynomiálních redukcí mezi
rozhodovacími problémy, do podoby interaktivního výukového nástroje.

Navržený systém umožňuje nejen pasivní studium formálních důkazů,
ale především aktivní práci s konkrétními instancemi problémů.
Uživatel může zadávat vlastní vstupy,
sledovat konstrukci redukce krok za krokem
a vizuálně porovnávat vstupní a výslednou instanci včetně jejich odpovědí.

Tím dochází k propojení formální matematické teorie s názornou vizualizací,
což přispívá k hlubšímu porozumění probírané problematice.

// Aplikace je určena především pro výuku na vysokých školách
// v předmětech zaměřených na teorii složitosti a návrh algoritmů.

== Požadavky na systém

Požadavky na systém lze rozdělit na funkční a nefunkční.
Funkční požadavky definují, jaké operace musí aplikace umožňovat,
zatímco nefunkční požadavky specifikují její kvalitativní vlastnosti.

=== Funkční požadavky

Aplikace musí uživateli umožnit výběr konkrétní redukce mezi rozhodovacími problémy
a zadání libovolné instance vstupního problému, a to jak formou vlastního vstupu,
tak prostřednictvím předdefinovaných ukázkových instancí.

Na základě zadané instance systém provede její transformaci
na instanci cílového problému pomocí zvolené redukce.
Vstupní i výsledná instance jsou následně vizualizovány,
aby bylo možné jejich přímé porovnání.

Součástí funkcionality je rovněž možnost zobrazit proces redukce krokově,
včetně textového vysvětlení jednotlivých transformačních kroků.

V případě, že je odpověď na rozhodovací otázku kladná,
aplikace umožní zobrazit nalezené řešení jak pro vstupní,
tak pro cílový problém.

// Systém dále validuje vstupní data a upozorňuje uživatele
// na případné syntaktické chyby.
// Uživatel může upravovat již zadanou instanci bez nutnosti
// opětovného načtení aplikace.


=== Nefunkční požadavky

Nefunkční požadavky se zaměřují na kvalitu uživatelského rozhraní,
výkon aplikace a její rozšiřitelnost.

Aplikace musí zajistit plynulou odezvu bez znatelného zpoždění,
a to i při práci s rozsáhlejšími instancemi.
Důraz je kladen také na přehlednost vizualizace,
zejména na zvýraznění konstrukčních prvků v cílových instancích.

Uživatel musí mít možnost interaktivně manipulovat se vstupním grafem,
což podporuje lepší porozumění zpracovávaným strukturám.

// Aplikace by měla být plně funkční i v offline režimu.
// Návrh systému by měl být modulární s ohledem na budoucí rozšiřitelnost.


== Architektura systému

=== Architektonický model

Aplikace je navržena jako čistě klientská webová aplikace bez serverové části.
Veškerá aplikační logika je vykonávána na straně klienta
v prostředí webového prohlížeče.
Aplikace je distribuována ve formě statických souborů.

// Tento přístup umožňuje jednoduché nasazení a minimalizuje
// požadavky na infrastrukturu.


=== Použité technologie

Aplikace je implementována pomocí frameworku Svelte,
který poskytuje komponentově orientovaný přístup
k tvorbě uživatelského rozhraní.

Vývoj probíhal v jazyce TypeScript,
který rozšiřuje jazyk JavaScript o statické typování.
To umožňuje lepší kontrolu nad strukturou dat,
zvyšuje čitelnost kódu a snižuje pravděpodobnost vzniku chyb.

Pro vizualizaci grafových struktur je využita knihovna Cytoscape,
která představuje standardní nástroj pro práci s grafy
ve webovém prostředí.

Pro vykreslování matematických výrazů v LaTeX syntaxi
je použita knihovna KaTeX,
která převádí LaTeX zápis do HTML reprezentace vhodné pro zobrazení
v prohlížeči.

// Knihovna cytoscape-canvas je využita pro efektivnější vykreslování
// rozsáhlejších grafů pomocí canvas vrstvy.


=== Zpracování dat

Zpracování dat v systému probíhá v následujících krocích:

1. Uživatel zadá instanci vstupního problému.
2. Instance je převedena do interní reprezentace systému.
3. Redukční modul transformuje vstupní instanci na instanci cílového problému.
4. Řešicí modul (solver) se pokusí nalézt řešení cílové instance.
5. V případě úspěchu dekodér převede nalezené řešení zpět
   na řešení původní instance.

// 6. Výsledky jsou následně vizualizovány a případně doplněny
//    o krokový průběh redukce


== Návrh uživatelského rozhraní

=== Struktura rozhraní

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
