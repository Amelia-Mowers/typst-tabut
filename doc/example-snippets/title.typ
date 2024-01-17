#import "@preview/tabut:0.0.1": tabut
#import "example-data/supplies.typ": supplies

#let fmt(it) = {
  heading(
    outlined: false,
    upper(it)
  )
}

#tabut(
  supplies,
  ( 
    (label: fmt([Name]), func: r => r.name ), 
    (label: fmt([Price]), func: r => r.price), 
    (label: fmt([Quantity]), func: r => r.quantity), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)