#import "@preview/tabut:0.0.1": tabut
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  (
    (label: [Price], func: r => r.price), // This column is moved to the front
    (label: [Name], func: r => r.name), 
    (label: [Name 2], func: r => r.name), // copied
    // (label: [Quantity], func: r => r.quantity), // removed via comment
  )
)