== Požadavky na systém

Požadavky na systém lze rozdělit na funkční a nefunkční.
Funkční požadavky definují, jaké operace musí aplikace umožňovat,
zatímco nefunkční požadavky specifikují její kvalitativní vlastnosti.

=== Funkční požadavky

Aplikace musí uživateli umožnit výběr konkrétní redukce mezi problémy
a zadání libovolné instance vstupního problému, a to jak formou vlastního vstupu,
tak prostřednictvím předdefinovaných ukázkových instancí.

Na základě zadané instance systém provede její transformaci na instanci cílového problému.
Vstupní i výsledná instance jsou následně vizualizovány, aby bylo možné jejich přímé porovnání.

Součástí funkcionality je rovněž možnost zobrazit proces redukce krokově,
včetně textového vysvětlení jednotlivých transformačních kroků.

V případě, že je odpověď na rozhodovací otázku kladná,
aplikace zobrazí nalezené řešení jak pro vstupní, tak pro cílový problém.

Systém dále validuje vstupní data a upozorňuje uživatele
na případné syntaktické chyby.
Uživatel může upravovat již zadanou instanci bez nutnosti
opětovného načtení aplikace.

#figure(
  image("../assets/plantuml/use-case-diagram.svg"),
  caption: [
    Diagram případů užití zobrazující funkční požadavky systému z pohledu uživatele
  ]
)



=== Nefunkční požadavky

Nefunkční požadavky se zaměřují na kvalitu uživatelského rozhraní,
výkon aplikace a její rozšiřitelnost.

Aplikace musí zajistit plynulou odezvu bez znatelného zpoždění,
a to i při práci s rozsáhlejšími instancemi.
Důraz je kladen také na přehlednost vizualizace,
zejména na zvýraznění konstrukčních prvků v cílových instancích.

Uživatel musí mít možnost interaktivně manipulovat se vstupním grafem
u problémů, kde je vstupní instancí graf.

