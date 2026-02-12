// Uvést čtenáře do kontextu.
//
// - Vysvětlit stručně teorii složitosti algoritmů a v průběhu se zaměřit na termín NP-Complete.
//   
// Jaká je motivace téhle práce? Co je problémem, který se snaží vyřešit?
//
// - Studenti a vyučující TI, chtějí vizualizovat převody mezi problémy. 
// - Z vizualizací lze mnohem pochopit redukce, než ze čtení formálních textů.
// - Umožnit interaktivní zobrazení redukcí a jejich postup.
// - Zobecnění pro, každou instanci problému. Konec statických animací redukcí pro specifické vstupní instance.
//
// Jaké cíle má tahle práce? Co chce přínést, unsnadnit, v čem má pomoct?
//
// - Příjít s řešením pro satisfakci vylistovaných motivací.
// - Má za cíl, poskytnout interaktivní GUI pro zadavaní instancí. 
// - #[ 
//   Vizualizace vstupních a výstupních instancí, ať už to jsou logické výrazy,
//   orientované/neorientované grafy s nebo bez ohodnocení hran, tabulky pro čísla
//   jako vstupní instance pro problém SSP. 
// ]
//
// - Zobrazit certifikáty k daným problémum, pokud existují. 
// - Zobrazit i certifikát pro vstupní instanci, pokud má certifikát výstupní instance.
// - Zobrazit postup pro jednotlivé redukce.
//
// Co bylo vytvořeno.
//
// - Webová aplikace, která funguje podobně jako online kalkulačky (např. integrální kalkulačky, zobrazujicí postup, atd...).

#lorem(300)

/*
Tato práce uvádí čtenáře do problematiky výpočetní složitosti algoritmů se
zaměřením na třídu problémů NP-Complete. Teorie výpočetní složitosti se zabývá
klasifikací algoritmických problémů podle náročnosti jejich řešení a hraje
klíčovou roli v informatice, zejména při zkoumání hranic efektivní
vypočitatelnosti. Zvláštní pozornost je věnována právě NP-úplným problémům,
které tvoří středobod mnoha teoretických i praktických úvah, a jejichž vzájemné
vztahy jsou definovány pomocí polynomiálních redukcí.

Motivací této práce je potřeba lépe porozumět převodům mezi jednotlivými
NP-úplnými problémy. Studenti i vyučující technické informatiky se při studiu
této oblasti často setkávají s formálními a abstraktními popisy redukcí, které
mohou být obtížně pochopitelné bez názorné podpory. Zkušenosti ukazují, že
vizuální reprezentace redukcí umožňuje hlubší a intuitivnější pochopení jejich
principu než samotné čtení matematických či formálních textů. Dalším problémem
stávajících přístupů je jejich statičnost – existující animace a ilustrace
redukcí jsou zpravidla omezeny na konkrétní vstupní instance a nelze je snadno
zobecnit. Cílem je proto umožnit interaktivní zobrazení redukcí včetně jejich
jednotlivých kroků, a to obecně pro libovolnou instanci daného problému.

Hlavním cílem této práce je navrhnout a realizovat řešení, které uvedené
motivace naplňuje. Práce si klade za cíl poskytnout interaktivní grafické
uživatelské rozhraní pro zadávání vstupních instancí různých problémů. Součástí
řešení je vizualizace jak vstupních, tak výstupních instancí, a to v podobě
logických výrazů, orientovaných i neorientovaných grafů s ohodnocenými i
neohodnocenými hranami, případně tabulkových reprezentací číselných dat,
například pro problém Subset Sum Problem. Dále je cílem zobrazovat certifikáty
řešení pro jednotlivé problémy, pokud existují, a rovněž certifikát pro vstupní
instanci v případech, kdy jej má výstupní instance. Nedílnou součástí je také
vizuální znázornění samotného postupu redukce krok za krokem.

Výsledkem této práce je webová aplikace, která svým principem připomíná online
matematické kalkulačky, například integrální kalkulačky, jež kromě výsledku
zobrazují i postup řešení. Aplikace umožňuje interaktivní práci s instancemi
problémů a jejich redukcemi a slouží jako výuková pomůcka pro lepší pochopení
problematiky NP-úplnosti.
*/
