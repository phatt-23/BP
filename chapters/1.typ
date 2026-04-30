#import "/lib/global.typ": *


= Základní pojmy a terminologie

Tato kapitola stručně zavádí základní pojmy z teorie výpočetní složitosti,
které jsou nezbytné pro další části práce. 
Nejde o úplný teoretický přehled, 
ale o vymezení terminologie a konceptů, 
se kterými bude práce dále operovat.

== Problém a algoritmus 

Pod problémem rozumíme obecnou úlohu, kterou je třeba řešit,
a to zpravidla pro různé vstupní instance.
Instance problému je konkrétní zadání,
tedy konkrétní vstupní data,
pro která je požadováno rozhodnutí nebo řešení.
Například u problému splnitelnosti booleovských formulí je instancí konkrétní logický výraz,
zatímco u grafových problémů je instancí konkrétní graf se zadanými vlastnostmi.

Pod algoritmem rozumíme konečný a jednoznačně definovaný postup,
který pro danou vstupní instanci produkuje výstup.
Řekneme, že algoritmus řeší problém,
pokud pro každou jeho vstupní instanci poskytne správnou odpověď.


== Rozhodovací problém

V teorii výpočetní složitosti se obvykle pracuje s tzv. rozhodovacími problémy.
Rozhodovací problém je formulován tak, že pro danou vstupní instanci je odpověď buď ano, nebo ne.

Optimalizační i vyhledávací problémy lze převést na rozhodovací problémy,
například zavedením prahové hodnoty a otázky, 
zda existuje řešení splňující dané omezení.
Dejme tomu optimalizační úlohu najít nejkratší cestu v grafu lze reformulovat
zavedením prahové hodnoty $k$ a otázky, zda existuje cesta s délkou nejvýše $k$.

== Redukce

Redukci lze chápat jako algoritmickou transformaci jedné vstupní instance na jinou výstupní instanci.
Formálněji, redukce problému $A$ na problém $B$ je převod instance problému
$A$ na instanci problému $B$ tak,
že odpověď pro instanci problému $B$ lze využít k získání odpovědi pro instanci problému $A$.
U rozhodovacích problémů se odpověď zachovává:
instance problému $A$ má kladnou odpověď právě tehdy,
když má kladnou odpověď i odpovídající instance problému $B$.

V kontextu této práce uvažujeme pouze polynomiální redukce,
tedy takové, které lze provést v polynomiálním čase.
Redukce slouží k porovnávání obtížnosti problémů a tvoří základ definice NP-úplnosti.

== NP-úplné problémy

Problém označíme jako NP-těžký, pokud na něj lze polynomiálně redukovat
každý problém ze třídy NP.
Pokud je problém NP-těžký a zároveň náleží do třídy NP, nazývá se NP-úplný.
NP-úplné problémy jsou tedy nejobtížnějšími problémy třídy NP.
To znamená, že existence polynomiálního algoritmu pro jediný NP-úplný problém
by implikovala existenci polynomiálního algoritmu pro všechny problémy třídy NP,
a tím pádem rovnost $P = "NP"$.

