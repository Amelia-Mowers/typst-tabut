#import "@preview/tabut:0.0.1": tabut
#import "example-data/supplies.typ": supplies

#tabut(
  supplies, // the source of the data used to generate the table
  ( // column definitions
    (
      label: [Name], // label, takes content.
      func: r => r.name // generates the cell content.
    ), 
    (label: [Price], func: r => r.price), 
    (label: [Quantity], func: r => r.quantity), 
  )
)