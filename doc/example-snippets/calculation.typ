#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  ( 
    (label: [*Name*], func: r => r.name ), 
    (label: [*Price*], func: r => usd(r.price)), 
    (label: [*Tax*], func: r => usd(r.price * .2)), 
    (label: [*Total*], func: r => usd(r.price * 1.2)), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)