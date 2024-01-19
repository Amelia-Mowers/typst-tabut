#import "@preview/tabut:0.0.1": tabut
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  (
    (header: [Name], func: r => r.name), 
    (header: [Price], func: r => r.price), 
    (header: [Quantity], func: r => r.quantity), 
  )
)