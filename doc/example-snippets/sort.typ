#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/titanic.typ": titanic, classes

#tabut(
  titanic
  .sorted(key: r => r.Fare)
  .rev()
  .slice(0, 5),
  ( 
    (label: [*Name*], func: r => r.Name), 
    (label: [*Class*], func: r => classes.at(r.Pclass)),
    (label: [*Fare*], func: r => usd(r.Fare)), 
    (label: [*Survived?*], func: r => ("No", "Yes").at(r.Survived)), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)