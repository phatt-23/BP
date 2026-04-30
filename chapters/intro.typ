Tato práce se zabývá problematikou výpočetní složitosti algoritmů
se zaměřením na třídu NP-úplných problémů.
Výpočetní složitost představuje jednu ze základních disciplín informatiky,
která studuje nároky na zdroje potřebné k vyřešení algoritmického problému.
Mezi tyto zdroje patří především čas výpočtu
a operační paměť pro uložení mezivýsledků.

Zvláštní postavení v teorii složitosti zaujímají NP-úplné problémy.
Tato třída sdružuje problémy, pro které neexistuje známý algoritmus s polynomiální časovou složitostí.
Zároveň však platí, že efektivní řešení libovolného z nich
by umožnilo efektivně řešit všechny ostatní problémy ve třídě NP.
Otázka, zda takový algoritmus existuje, zůstává
jedním z nejvýznamnějších nevyřešených problémů současné informatiky.

Základním nástrojem pro zkoumání vztahů mezi problémy jsou polynomiální redukce.
Ty umožňují transformovat instanci jednoho problému na instanci problému jiného 
tak, že odpověď pro druhý problém implikuje odpověď pro problém původní.
Tento koncept tvoří základ definice NP-úplnosti
a umožňuje srovnání relativní obtížnosti jednotlivých problémů.

Studium redukcí je však náročné,
protože formální konstrukce bývají abstraktní a obtížně představitelné.
Studenti se setkávají s bariérou mezi matematickým popisem
a jeho konkrétní vizuální reprezentací.
Navíc stávající výukové materiály a animace jsou zpravidla statické
a pracují pouze s předem danými instancemi.
Z tohoto důvodu je žádoucí poskytnout studentům nástroj,
který by jim pomohl tyto principy lépe pochopit.

Cílem této práce je navrhnout a implementovat webovou aplikaci,
která by tento nedostatek alespoň částečně odstranila.
Aplikace slouží jako interaktivní výuková pomůcka,
umožňující zadávat instance zdrojových problémů,
realizovat pět polynomiálních redukcí
a vizualizovat celý transformační proces včetně jeho jednotlivých kroků.
Součástí řešení jsou rovněž algoritmy pro řešení vzniklých instancí
a mechanismy pro dekódování výsledků zpět do kontextu vstupního problému.

Práce je rozdělena na 
teoretickou část (kap. 1 až 3) a 
praktickou část (kap. 4 až 6).

První kapitola definuje základní pojmy z teorie výpočetní složitosti
potřebné pro pochopení následujícího textu.
Druhá kapitola představuje šest NP-úplných problémů,
se kterými aplikace pracuje, včetně jejich formálních definic a příkladů instancí.
Třetí kapitola tvoří teoretické jádro práce
a obsahuje detailní popis pěti polynomiálních redukcí mezi těmito problémy.

Ve čtvrté kapitole je popsán návrh systému
z hlediska architektury, požadavků a uživatelského rozhraní.
Pátá kapitola se věnuje technické implementaci,
včetně reprezentace instancí, redukčních, řešících a dekódovacích modulů
a použitých technologií.
Šestá kapitola demonstruje funkčnost aplikace na ukázkových instancích
s kladnou i zápornou odpovědí pro každou redukci.

Závěr shrnuje dosažené výsledky, diskutuje omezení navrženého řešení
a nastiňuje možnosti budoucího rozšíření.
