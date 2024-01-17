#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  (
    (label: [*\#*], func: r => r._index),
    (label: [*Name*], func: r => r.name), 
    (label: [*Price*], func: r => usd(r.price)), 
    (label: [*Quantity*], func: r => r.quantity),
  ),
  transpose: true,  // set optional name arg `transpose` to `true`
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)