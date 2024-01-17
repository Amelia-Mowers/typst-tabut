#import "@preview/tabut:0.0.1": tabut, rows-to-records
#import "example-data/supplies.typ": supplies

#let titanic = {
  let titanic-raw = csv("example-data/titanic.csv");
  rows-to-records(
    titanic-raw.first(), // The header row
    titanic-raw.slice(1, -1), // The rest of the rows
  )
}