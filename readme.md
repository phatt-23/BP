
# Pavel Konecny

SAT -> 3-SAT

3-SAT -> 3-CG
3-SAT -> IS

IS -> VC
IS -> Clique

VC <-> Clique


# P


3SAT    -> SSP
3SAT    -> ILP
3SAT    -> 3DM      (G&J 50-52)
    3DM     -> SSP  (G&J 61-62)
3SAT    -> HC
    HC      -> HK
SSP     -> PART
3DM     <-> X3C // too trivial
VC      -> SC   // too trivial

as data:
```
3SAT SSP
3SAT ILP
3SAT 3DM
3SAT HC
SSP PART
3DM SSP
HC HK
```


## Read these
- [https://perso.limos.fr/~palafour/PAPERS/PDF/Garey-Johnson79.pdf]
- [https://npcomplete.owu.edu/category/core-problems/]
- [https://npcomplete.owu.edu/2014/06/03/3-satisfiability/]
- [https://npcomplete.owu.edu/2014/06/03/3-dimensional-matching/]
- [https://npcomplete.owu.edu/2014/06/10/exact-cover-by-3-sets/]

## Logic to Graph
3-SAT        -> CLIQUE          (3SAT -> IS -> CLIQUE)
3-SAT        -> Vertex Cover    (3-SAT -> CLIQUE -> VC)
3-SAT        -> HAMILTONIAN CYCLE (HC) // different

## Logic to Set/Packing
3-SAT        -> EXACT COVER BY 3-SETS (X3C) // different
3-SAT        -> 3-DIMENSIONAL MATCHING (3DM) // different (G&J 50-52)
3DM         <-> X3C 
    - draw three columns (X, Y, Z), then highlight how choosing disjoint triples = choosing disjoint 3-sets that cover everything

## Bridging
Vertex Cover    -> Set Cover // different, too easy
    - G = (V,E); S = { {e | e is_incident_to v } | v in V }
    - does S' sub S : UNION S' = E and every e in E is found only in one of the subsets in S' ???
    - [https://gnarlyware.com/blog/proving-the-set-covering-problem-is-np-complete-using-reduction-from-the-vertex-cover-problem/]


# Numeric
3DM             -> Partition (G&J 61-62) // different
    - converts triples into numbers in bitwise fashion, bitmasking, could have nice visuals
Subset-Sum      -> Partition // trivial
    - given set of ints S and target int T, is there a S' subset S such that SUM S' = T ???
    - if T is 1/2 SUM S, then this problem is the partition problem



## From SAT / 3-SAT

[K] - SAT → 3-SAT — standard clause splitting (introduce new vars to break long clauses into 3-literal clauses).
[P] - 3-SAT → CLIQUE — make a vertex for each literal occurrence; connect vertices from different clauses unless they are complementary literals; a size-m clique (m = #clauses) picks one literal per clause consistent globally.
[K] - 3-SAT → INDEPENDENT SET (IS) — complement of the CLIQUE construction or a direct gadget: choose one literal per clause, forbid conflicting literal choices.
[P] - 3-SAT → HAMILTONIAN CYCLE (HC) — build clause gadgets and choice gadgets so a Hamiltonian cycle corresponds to a satisfying assignment.
[K] - 3-SAT → GRAPH k-COLORING (k≥3) — construct gadgets forcing one color per clause/literal and forbid conflicting assignments.
[P] - 3-SAT → 3-DIMENSIONAL MATCHING (3DM) — encode variables/clauses into triples so a perfect matching corresponds to a satisfying assignment.
[P] - 3-SAT → EXACT COVER BY 3-SETS (X3C) — similar encoding to 3DM / set gadgets representing variable assignments and clause satisfaction.

## Between graph problems (very standard)

[K] - IS → VERTEX COVER (VC) — complement: S is independent ⇔ V \ S is vertex cover. (polytime, simple).
[K] - IS ↔ CLIQUE — Clique in G = IS in complement(G). (both directions via complement).
[K] - VC ↔ CLIQUE — via complement: VC in G ↔ Clique in complement(G).
[ ] - CLIQUE → DOMINATING SET (DS) — use gadgets that force dominating set to pick a clique (used in some proofs).
[ ] - HAMILTONIAN PATH/CYCLE → LONGEST PATH — decision instance: is there a path of length ≥ n? (trivial reduction).
[ ] - 3-COLORING → k-COLORING (for k>3) — pad graph with gadgets to force use of extra colors (or collapse colors for k<3).
[ ] - Set / covering / packing
[ ] - SET COVER → DOMINATING SET — set-element incidence can be turned into a domination instance.
[ ] - SET COVER ↔ HITTING SET — they are essentially the same (transpose incidence).
[ ] - X3C → SET COVER — X3C is a special case of set cover; reduction is immediate (or used conversely to show X3C hard).
[ ] - 3DM → X3C / PARTITIONING PROBLEMS — standard transforms between packing/covering problems.

## Numeric / subset problems

[P] - SUBSET-SUM → PARTITION — partition asks if you can split multiset into two equal halves; reduce by adding total/2 trick or vice versa.
[ ] - PARTITION → NUMERICAL 3-DIM MATCH / BIN PACKING — encode partition as packing into bins of capacity = half sum.
[ ] - 3-SAT → SUBSET-SUM — there are encodings using number bases where digits encode clause satisfaction (more technical but classical).
[P] - KNAPSACK → SUBSET-SUM — subset-sum is knapsack with weights=values and target = capacity.
[ ] - Other classical NP-complete problems (and typical reductions to/from them)
[ ] - 3-SAT → FEEDBACK VERTEX SET / FEEDBACK EDGE SET — construct directed or undirected gadgets where breaking cycles corresponds to fixing truth values.
[ ] - 3-SAT → Satisfiability variants: PLANAR-3-SAT, MONOTONE-3-SAT, NAE-3-SAT — reductions add gadgets to enforce planarity/monotonicity/NAE constraints.
[ ] - 3-SAT → CIRCUIT-SAT — clauses become small circuits; conversely CIRCUIT-SAT → SAT by converting gate network to CNF (with Tseitin transformation).
[ ] - CIRCUIT-SAT ↔ SAT — Tseitin CNF or gate-to-clause encodings; used in many reductions as an intermediate.

## Misc useful/commonly seen reductions (short list)

[ ] - HAM-CYCLE → TSP (decision) — set distances so TSP tour of cost ≤ C exists iff Hamiltonian cycle exists.
[P] - VC → SET COVER — vertex cover is set cover where elements = edges and sets = incident edges of each vertex.
[ ] - CLIQUE → SUBGRAPH ISOMORPHISM — a clique of size k corresponds to K_k subgraph.
[ ] - 3-SAT → PLANAR 3-SAT → PLANAR VERTEX COVER / PLANAR HAMILTONIAN — used to show hardness on planar graphs with gadgets preserving planarity.



# Questions

Does the UI have to be unified or adhere to some preexisting UI specifications?
    - Should I worry about the differing looks at all?
Does the written program have to be in some specific language or framework?
    - Can I whatever I want (REACT, Svelte, Vanilla JS, WebAssembly)?
Should this program be completely independent or should it itegrate into some existing website?
    - Can it just be independent site that a user gets to by clicking on a link on the main TI server website?
    - Does it have to be offline website. Should it contain everything withing itself including the computation.
    - Should the computation be done on a server instead. Or should it all run in user's browser?
When should the program be finished?
When should the paper be finished? 
    - What should be the contents of it? 
        - Implementation process, why I chose what I chose? 
        - Descriptions of the problems and algorithms used to solve them?
        - Description of the reductions functions, what they do, how they work?

---


V rámci diplomových a bakalářských prací vzniká výukový server pro předměty
teoretické informatiky. Jedná se o sadu dynamických webových stránek
umožňujících studentům pochopení různých typů úloh a problémů tím, že si mohou
zadat na stránce libovolné zadání a zobrazí se jim řešení včetně postupu. Cílem
této práce je vytvořit komponentu (tedy sadu webových stránek) pro výuku
vybraných NP-úplných problémů a převodů mezi nimi.

1. Nastudujte si problematiku tříd složitosti problémů a s tím souvisejícím
   převodem mezi problémy.
2. Vytvořte dynamické webové stránky umožňující uživateli následující: 
    a) Nechat si zobrazit postupně po krocích postup algoritmu s polynomiální
       časovou složitostí převádějícího zadanou instanci jednoho problému na instanci
       jiného problému (budou implementovány alespoň 3 různé převody mezi problémy).
    b) Zadat libovolnou instanci každého z problémů vyskytujících se v těchto
       převodech. 
    c) Zobrazit odpověď na otázku daného problému pro zadanou instanci,
       v případě kladné odpovědi i se zdůvodněním.
3. Není cílem mít co nejefektivněji implementován samotný převod, ale mít jej
   implementován tak, aby uživateli byla myšlenka tohoto převodu co
   nejsrozumitelněji ukázána.
4. Vytvořte i ukázkové vstupní instance pro implementované problémy tak, aby
   uživatel mohl vše vyzkoušet i bez zadávání vlastních vstupů (alespoň 5
   instancí pro každý problém).

Studenti řešící toto zadání s rozdílným číslem v názvu mohou (ale nemusí)
spolupracovat tak, že výsledek může mít společné uživatelské rozhraní apod. Ale
každý bude implementovat jiné 3 převody mezi problémy.

