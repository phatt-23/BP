#import "/lib/global.typ": *

= Implementace

Tato kapitola se věnuje implementaci navrženého systému.
Nejprve je popsána vnitřní reprezentace instancí problémů 
a validace vstupních dat.
Následně je detailně rozebrána implementace jednotlivých redukcí,
včetně mapování teoretických kroků na programový kód.
Kapitola dále popisuje, 
jakým způsobem systém řeší problémy a dekóduje řešení.

Cílem bylo vytvořit přehledný a srozumitelný kód,
který co nejpřesněji reflektuje teoretický popis redukcí.
Optimalizace výkonu byly prováděny pouze v nezbytných případech.

#include "./5.1.typ"
#include "./5.2.typ"
#include "./5.3.typ"
#include "./5.4.typ"
#include "./5.5.typ"

