#import "@preview/tabut:0.0.1": tabut, group
#import "example-data/titanic.typ": titanic, classes

#tabut(
  group(titanic, r => r.Pclass),
  (
    (label: [*Class*], func: r => classes.at(r.value)), 
    (label: [*Passengers*], func: r => r.group.len()), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)