#let var-gadget-chain = ```dot

digraph VarGadgetChain {
  layout=neato
  overlap=false
  splines=true

  node [shape=circle fixedsize=true width=0.4]

  // gadgets span from -3 to +3, center at 0

  alpha [pos="-4,6!"]

  xT      [pos="-3,5!" label="x^((1))"]
  x2      [pos="-2,5!" label="x^((2))"]
  x3      [pos="-1,5!" label="x^((3))"]
  xelips  [pos="0,5!" label="..." penwidth=0]
  xa      [pos="1,5!" label="x^((n-2))"]
  xb      [pos="2,5!" label="x^((n-1))"]
  xF      [pos="3,5!" label="x^((n))"]

  xy [pos="0,4!" label="x y"]

  yT      [pos="-3,3!" label="y^((1))"]
  y2      [pos="-2,3!" label="y^((2))"]
  y3      [pos="-1,3!" label="y^((3))"]
  yelips  [pos="0,3!" label="..." penwidth=0]
  ya      [pos="1,3!" label="y^((n-2))"]
  yb      [pos="2,3!" label="y^((n-1))"]
  yF      [pos="3,3!" label="y^((n))"]

  yz [pos="0,2!" label="y z"]

  zT      [pos="-3,1!" label="z^((1))"]
  z2      [pos="-2,1!" label="z^((2))"]
  z3      [pos="-1,1!" label="z^((3))"]
  zelips  [pos="0,1!" label="..." penwidth=0]
  za      [pos="1,1!" label="z^((n-2))"]
  zb      [pos="2,1!" label="z^((n-1))"]
  zF      [pos="3,1!" label="z^((n))"]

  beta [pos="-4,0!"]

  alpha -> xT
  alpha -> xF

  xT -> x2 -> x3 -> xelips -> xa -> xb -> xF
  xF -> xb -> xa -> xelips -> x3 -> x2 -> xT

  xT -> xy
  xF -> xy

  xy -> yT
  xy -> yF

  yT -> y2 -> y3 -> yelips -> ya -> yb -> yF
  yF -> yb -> ya -> yelips -> y3 -> y2 -> yT

  yT -> yz
  yF -> yz

  yz -> zT
  yz -> zF

  zT -> z2 -> z3 -> zelips -> za -> zb -> zF
  zF -> zb -> za -> zelips -> z3 -> z2 -> zT

  zT -> beta
  zF -> beta

  beta -> alpha
}



```

#let clause-gadget = ```dot

digraph {
  layout=neato
  overlap=false
  splines=true

  node [shape=circle fixedsize=true width=0.4]

  x_1   [pos="0,5!" label="x^((1))"]
  x_2   [pos="1,5!" label="x^((2))"]
  x_3   [pos="2,5!" label="x^((3))"]
  x_4   [pos="3,5!" label="x^((4))"]
  x_5   [pos="4,5!" label="x^((5))"]
  x_6   [pos="5,5!" label="x^((6))"]
  x_7   [pos="6,5!" label="x^((7))"]
  x_8   [pos="7,5!" label="x^((8))"]
  x_9   [pos="8,5!" label="x^((9))"]
  x_10  [pos="9,5!" label="x^((10))"]

  y_1   [pos="3,3!" label="y^((1))"]
  y_2   [pos="4,3!" label="y^((2))"]
  y_3   [pos="5,3!" label="y^((3))"]
  y_4   [pos="6,3!" label="y^((4))"]

  z_1   [pos="1.5,1!" label="z^((1))"]
  z_2   [pos="2.5,1!" label="z^((2))"]
  z_3   [pos="3.5,1!" label="z^((3))"]
  z_4   [pos="4.5,1!" label="z^((4))"]
  z_5   [pos="5.5,1!" label="z^((5))"]
  z_6   [pos="6.5,1!" label="z^((6))"]
  z_7   [pos="7.5,1!" label="z^((7))"]

  kappa_1 [pos="1.5,4!"]
  kappa_2 [pos="7.5,3!"]

  subgraph {
    "x_1" -> x_2 -> x_3 -> x_4 -> x_5 -> x_6 -> x_7 -> x_8 -> x_9 -> "x_10" [dir=both]
    "y_1" -> y_2 -> y_3 -> y_4 [dir=both]
    "z_1" -> z_2 -> z_3 -> z_4 -> z_5 -> z_6 -> "z_7" [dir=both]
  }
  
  subgraph {
    kappa_1  // (x or not y or z)

    x_2 -> kappa_1
    kappa_1 -> x_3

    y_3 -> kappa_1 
    kappa_1 -> y_2
    
    z_2 -> kappa_1
    kappa_1 -> z_3
  }

  subgraph {
    kappa_2  // (not x or x or y)

    x_6 -> kappa_2
    kappa_2 -> x_5  
    
    x_8 -> kappa_2
    kappa_2 -> x_9
    
    z_5 -> kappa_2
    kappa_2 -> z_6
  }
}

```

#let non-valid-traversal = ```dot
digraph {
  layout=neato
  overlap=false
  splines=true

  node [shape=circle fixedsize=true width=0.4]
  
  x_1   [pos="1,2!" label="x^((1))"]
  x_2   [pos="2,2!" label="x^((2))"]
  x_3   [pos="3,2!" label="x^((3))"]
  x_4   [pos="4,2!" label="x^((4))"]
  x_5   [pos="5,2!" label="x^((5))"]
  x_6   [pos="6,2!" label="x^((6))"]
  x_7   [pos="7,2!" label="x^((7))"]
  x_8   [pos="8,2!" label="x^((8))"]
  x_9   [pos="9,2!" label="x^((9))"]
  x_10  [pos="10,2!" label="x^((10))"]
  x_11  [pos="11,2!" label="x^((11))"]
  x_12  [pos="12,2!" label="x^((12))"]

  y_0   [pos="2.5,0!"   label="..." style=invis]
  y_1   [pos="3.5,0!"   label="y^((i+1))"]
  y_2   [pos="4.5,0!"   label="y^((i+2))"]
  y_3   [pos="5.5,0!"   label="y^((i+3))"]
  y_4   [pos="6.5,0!"   label="y^((i+4))"]
  y_5   [pos="7.5,0!"   label="y^((i+5))"]
  y_6   [pos="8.5,0!"   label="y^((i+6))"]
  y_7   [pos="9.5,0!"   label="y^((i+7))"]
  y_8   [pos="10.5,0!"  label="..." style=invis]

  alpha [pos="2,3!" style=invis label="předchozí mezi-vrchol"]
  xy [pos="11,-1!" style=invis label="následujicí mezi-vrchol"]
  
  kappa_1 [pos="2.5,1!"]
  kappa_2 [pos="4.5,1!"]
  kappa_3 [pos="6.5,1!"]
  kappa_4 [pos="8.5,1!"]
  kappa_5 [pos="10.5,1!"]
  
  edge [color=red]
  alpha -> x_1 
  x_1 -> x_2 -> x_3 -> kappa_1 -> y_1 -> y_2 -> y_3 -> kappa_4
  kappa_4 -> x_9 -> x_8 -> x_7 -> kappa_3 -> x_6 -> x_5 -> x_4 -> kappa_2
  kappa_2 -> y_4 -> y_5 -> y_6 -> y_7 -> kappa_5 -> x_10 -> x_11 -> x_12
  x_12 -> xy 
}
```

#let jumping-non-working = ```dot
digraph {
  layout=neato
  overlap=false
  splines=true

  node [shape=circle fixedsize=true width=0.4]
  
  x_1   [pos="1,2!" label="x^((1))"]
  x_2   [pos="2,2!" label="x^((2))"]
  x_3   [pos="3,2!" label="x^((3))"]
  x_4   [pos="4,2!" label="x^((4))"]
  x_5   [pos="5,2!" label="x^((5))"]
  x_6   [pos="6,2!" label="x^((6))"]
  x_7   [pos="7,2!" label="x^((7))"]

  x_1 -> x_2 -> x_3 -> x_4 -> x_5 -> x_6 -> x_7 [
    dir=both 
    color=gray
  ]

  kappa_1 [pos="2.5,1!"]
  elips   [pos="4,1!" label="..." style=invis]
  kappa_2 [pos="5.5,1!"]

  // edge [color="gray"]

  x_3 -> kappa_1 [color=blue penwidth=2]
  kappa_1 -> x_2

  x_5 -> kappa_2
  kappa_2 -> x_6 [color=blue penwidth=2]


  edge [color=blue penwidth=2]
  x_1 -> x_2 -> x_3
  kappa_1 -> elips -> kappa_2
  x_6 -> x_5 
  x_5 -> x_4 
  edge [color=red penwidth=2]
  x_4 -> x_3
}
```
