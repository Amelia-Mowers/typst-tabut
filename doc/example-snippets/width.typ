#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#box(
  width: 300pt,
  tabut(
    supplies,
    ( // Include `width` as an optional arg to a column def
      (label: [*\#*], func: r => r._index),
      (label: [*Name*], width: 1fr, func: r => r.name), 
      (label: [*Price*], width: 20%, func: r => usd(r.price)), 
      (label: [*Quantity*], width: 1.5in, func: r => r.quantity),
    ),
    fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
    stroke: none,
  )
)

