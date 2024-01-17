#import "@preview/tabut:0.0.1": tabut, records-from-csv
#import "usd.typ": usd
#import "example-data/titanic.typ": titanic

#let classes = (
  "N/A",
  "First", 
  "Second", 
  "Third"
);

#let titanic-head = titanic.slice(0, 5);

#tabut(
  titanic-head,
  ( 
    (label: [*Name*], func: r => r.Name), 
    (label: [*Class*], func: r => classes.at(r.Pclass)),
    (label: [*Fare*], func: r => usd(r.Fare)), 
    (label: [*Survived?*], func: r => ("No", "Yes").at(r.Survived)), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)