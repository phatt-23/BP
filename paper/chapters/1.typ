#import "/lib/global.typ": *

= Základní teorie

Než se vrhnem přímo do věci, je dobré si probrat základní teorii, 
bez které se ve čtení této práce neobejdeme. 

Příponemene si co je to 
  algoritmus, 
  rozhodovací problém, 
  složitost algoritmu, 
  třídy složitosti jako jsou P, NP, NP-těžké a NP-úplné problémy.

== Problém a algoritmus

Algoritmy můžeme chápat jako instrukce pro vyřešení nějakého problému. 
To, co algoritmus je, lze definovat mnoha způsoby a neexistuje přesná definice.
Problém je to, co lze řešit, což ale nutně neznamená, že lze vyřešit.

// Definice algoritmu je totiž úzce svázaná s nevyřešenými problémy v oblasti matematiky a teoretické informatiky.
// Jeden z těchto problém, který je nám v informatice nejbližší, je problém P = NP.

Algoritmus $A$ řešící problém $P$ znamená to, 
že pro každou instanci problému $P$ 
dostaneme aplikovaním algoritmu $A$ vždy správnou odpověď.

Např. pro třídicí problémy by tato odpověď byla setřízená sekvence. 
Pro algoritmus `f(a) = a * a` bychom získali druhou mocninu čísla `a`.
Pro algoritmus `isCapital(a: char) -> Bool` vratí True pro chary A-Z a False pro a-z.

== Rozhodovací problém

Pro jednoduchost se obvykle omezujeme na tvz. rozhodovací problémy.
Rozhodovací problémy je trojice $(I,O,Q)$, 
kde $I$ je množina správných vstupu, $O$ je množina možných výstupu a $Q$ je otázka.
Množina $O$ obsahuje dvě položky, _Ano_ a _Ne_, které představují odpověď na otázku $Q$.

Každý problém lze zformulovat do rozhodovacího problému, 
nehledě na to zda se jedná o optimalizační, třídicí či jakýkoliv jiný problém.

Mějme např. problém vyhledavání nejkratší cesty v ohodnoceném neorientovaném grafu, 
který představuje optimalizační problém (konkrétně minimalizační problém).
Problémem je najít nejkratší cestu. Tento problém lze transformovat do rozhodovacího problému tím,
že zavedeme konstantu $k in RR$ jako další položku vstupu a zeptáme se otázku: Existuje v grafu cesta z vrcholu
$a$ do $b$, taková, že její cena je menší nebo rovna $k$?

== Výpočetní model

Instrukcemi algoritmů můžeme chápat jako kroky v Turingových strojích, 
které představují teoretickou abstrakci výpočetního stroje. 
Říkáme, že Turingův stroj je výpočetní model a není zdaleka jediným.

Výpočetních modelů existuje spousta a jsou jimi např. 
páskové stroje, 
zásobníkové automaty (s jedním, dvěma či více zásobníky), 
formální jazyky, 
konečné stavové automaty, 
stoje s jedním číslem (nevím jak se jmenuje, sawa ma v prez) a mnoho dalších.

Avšak hlavním rozhodujicím rozdílem v jejích výpočetní schnoponosti (síle) je, zda jsou tvz. Turing-úplné.
Turing-úplné modely jsou takové výpočetní modely, 
kterými lze modelovat všechny algoritmy. 
Modely, které tuto vlastnost nemají, jsou např. konečné automaty, formální jazyky a zasobníkové automaty s jedním zásboníkem.
Pokud by zasobníkový automat měl dva zásobníky, byl by Turing-úplný.

== Algorimická řešitelnost problému

Ne každý problém je řešitelný algoritmem. 
Těm problémům, které nelze vyřešit algoritmem, říkáme algoritmicky neřešitelné.
Nejznámnější z nich je problém zastavení, ang. Halting Problem, a tázá se:
je-li dán algoritmus $A$, vykoná se algoritmus $A$ v konečném počtu kroků? 
Protože otázka tohoto problému zní velmi jednodušše, 
člověka by mohlo napadnout, 
že nalézt odpověď na ní, bude velmi jednoduché.
Avšak po lehké úvaze dojdeme k tomu, že se zde nachází paradox.

Předpokládejme, že pro tento problém existuje algoritmus `fn halts(f) -> bool`, který ho řeší.

```
fn halts(f) -> bool {
  if f halts after finite amount of steps {
    return True
  }
  else {
    return False
  }
}

fn h() {
  if halts(h) {
    while True {
      continue
    }
  }
}
```

Pokud algoritmus $H$ (funkce) je algoritmus, který se zastaví, výraz vrátí `halts(H)` vrátí True a funkce $H$ se začne vykonávat nekonečnou smyčku, tedy funkce $H$ se nezastaví, pokud se zastaví. Je zde kontradikce, proto funkce `halts` nemůže existovat.

== Asymptotická notace

Teorie složistosti studuje časovou a prostorovou (paměťovou) složitost algoritmů.
Časovou složitostí algoritmu $A$ se rozumí to, 
jak rychle poroste počet kroků (instrukcí), které se vykonají, s velikostí vstupu algoritmu $A$.

Měřítek složitosti máme několik, nejčastějí používáme $O(f)$, $Omega(f)$ a $Theta(f)$, 
kde $f$ je nějaká funkce $f : NN -> RR$, 
a používáme je ve smysle v nejhorším případě, v nejlepším případě a v průměrném případě v tomto pořadí.
Obecně jsou známy pod názvem asymptotická notace. 
Měřítko $O(f)$ značí horní hranici, 
$Theta(f)$ dolní hranici 
a $Omega(f)$ je mezi dolní a horní hranicí počtů kroků s rostoucí velikostí vstupní instance.


Formálněji, mějme funkce $f$, $g$ a $h$, kde jsou všechny předpisu $dot.op : NN -> RR$.
Pokud funcke přiřadíme do notací tímto způsobem:

$
  O(f)      \ 
  Theta(g)  \
  Omega(h)  \
$

potom musí platit pro $x in RR$, že:

$   
  f(x) >= g(x) \
  h(x) >= g(x) \
  h(x) <= f(x) \
$

To, že o algoritmu řekneme že má složitost $O(f)$, znamená, 
že v nejhorším případě 
počet kroků nepřesáhne $k dot.op f(x)$ v závislosti na velikosti vstupu $x$, kde $k in RR$ (nebude horší než).
Je to tedy omezení zhora.

$
  text("počet kroků") <= k dot.op f(x)
$


Složitost $Omega(g)$ znamená, že v nejlepším případě nebude počet kroků menší než $k dot.op g(x)$ (nebude lepší než)
Jedná se o omezení zdola.

$
  k dot.op f(x) <= text("počet kroků") 
$

Složitost $Theta(h)$ znamená pro $k_1, k_2 in RR$:

$
  k_1 dot.op h(x) <= text("počet kroků") <= k_2 dot.op h(x) 
$

Jedná se o omezení jak zdola, tak zhora a lze většinou ho chápat jako měřítko pro průměrný případ.

S pojmem časová složitost se pojí pojem prostorová složitost.
Ta studuje složitost v rámci počtu paměťových buněk potřebné k vykonání algoritmu. 
Také se zde použivá asymptotická notace, tady avšak nehledíme na počet kroků ale počet paměťových buněk.

Jeden ze známých třídicíh algoritmů je `bubblesort`. 

#sourcecode(```py
def bubblesort(arr: list[int]) {
  for i in range(0, len(arr)):
    for j in range(i + 1, len(arr)):
      if arr[i] > arr[j]:
        arr[i], arr[j] = arr[j], arr[i]
```)

Tento algoritmus má složitost $O(n^2)$, $Theta(n^2)$ a $Omega(n^2)$.
V nejhorším, nejlepším a v průměrném případě má složitost $n^2$.

Dalším daleko efektivnějším třídicím algoritmem je `quicksort` se složitostí $O(n^2)$, $Omega(n log(n))$ a $Theta(n log(n))$.

#sourcecode(```hs
  quicksort [] = []
  quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
    where
      lesser = filter (< p) xs
      greater = filter (>= p) xs
```)


== Třídy složitosti

Problémy lze na základě jejich časové a prostorové složitosti klasifikovat do tzv. tříd složitostí.
Zde budeme uvažovat pouze o časové složitosti.
Některé z těchto tříd jsou L, P, EXP, NP, NL.

- L - množina problémů s deterministickým algoritmem se složitostí $log(n)$
- P - množina problémů s deterministickým algoritmem se složitostí $n^k$, kde $k in RR$
- EXP - množina problémů s deterministickým algoritmem se složitostí $k^n$, kde $k in RR$
- NP - množina problémů s nedeterministickým algoritmem se složitostí $n^k$, kde $k in RR$
- NL - množina problémů s nedeterministickým algoritmem se složitostí $log(n)$

U definic nedeterministických tříd N- existuje alternativní definice.

Třídu NP tak lze definovat taktéž jako množinu rozhodovacích problému, 
u kterých existuje-li kladná odpověď, tak jejich certifikát (taktéž svědek nebo důkaz)
lze ověřit v polynomiálním čase.

Z těchto definic jsou zřejmé, že:

$
  L subset P subset text("EXP") \
  L subset text("NL") \
  P subset.eq text("NP") text("nebo") P subset text("NP") \
$

Všimněte si, že pro třídu P a NP není znám přesný vztah. 
Zda třída P se rovná či nerovná třídě NP je otevřená otázka. 
Důkaz, který by vyvrátil nebo zdůvodnil ono nebo druhé, ještě nebyl nikdy zformulován.

== Redukce

Redukce problému $A$ na problém $B$ znamená 
převedení instance problému $A$ na instanci problému $B$ tak, že
z odpověď na problém $B$ můžeme vykonstruovat odpověď pro instance problému $A$. 

Jsou-li problémy $A$ a $B$ rozhodovací problémy, 
odpověď instance problému $B$ se musí rovnat odpověďi problému $A$.
Musí se zachovat kladná i záporná odpověď.

Můžeme jej chápat jako problém, který je řešen nějakým algoritmem. 
Skoro vždy nám ale jde o to, aby vzniklá instance problému $B$ 
nevzrostla exponencionálně od velikosti instace problému $A$.
Budeme tedy brát v potaz pouze algoritmy se složitostí $O(n^k)$.

== Třída NP

Ve třídě NP jsou takové problémy, pro které umíme řešit s časovou složitostí $O(k^n)$ deterministickým algoritmem.
Pokud by se vynalezl stroj, který by uměl pracovat nederministickými instrukcemi, 
dokázali bychom tyto problémy vyřešit v polynomiálním čase. 
Zatím ale nikdo takový stroj nevynalezl.

S třídou NP jsou spojené třídy NP-těžkých a NP-úplných problémů.
Problém $T$ nazveme NP-těžkým, jestliže lze na něj redukovat každý problém $N$ ve třídě NP.
Problém $U$ nazveme NP-úplným, pokud je NP-těžký a zároveň patří do třídy NP.

NP-úplné problémy jsou z definice takové, které lze redukovat mezi sebou.
Z důsledku, nalezneme-li efektivní algoritmus pro jeden NP-úplný problém, 
nalezli jsme efektivní algoritmus pro každý NP-úplný problém.








