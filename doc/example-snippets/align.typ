#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  ( // Include `align` as an optional arg to a column def
    (label: [*\#*], func: r => r._index),
    (label: [*Name*], align: right, func: r => r.name), 
    (label: [*Price*], align: right, func: r => usd(r.price)), 
    (label: [*Quantity*], align: right, func: r => r.quantity),
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)