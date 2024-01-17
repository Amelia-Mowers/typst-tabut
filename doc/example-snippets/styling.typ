#import "@preview/tabut:0.0.1": tabut
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  ( 
    (label: [Name], func: r => r.name), 
    (label: [Price], func: r => r.price), 
    (label: [Quantity], func: r => r.quantity),
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)