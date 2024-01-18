<div>

# Tabut <span id="Tabut"></span>

*Powerful, Simple, Concise*

A Typst plugin for turning data into tables.

## Outline

- [Examples](#Examples)

  - [Input Format and Creation](#Input-Format-and-Creation)

  - [Basic Table](#Basic-Table)

  - [Table Styling](#Table-Styling)

  - [Label Formatting](#Label-Formatting)

  - [Cell Expressions and Formatting](#Cell-Expressions-and-Formatting)

  - [Index](#Index)

  - [Transpose](#Transpose)

  - [Alignment](#Alignment)

  - [Column Width](#Column-Width)

- [Data Operation Examples](#Data-Operation-Examples)

  - [CSV Data](#CSV-Data)

  - [Slice](#Slice)

  - [Sorting and Reversing](#Sorting-and-Reversing)

  - [Filter](#Filter)

  - [Aggregation using Map and Sum](#Aggregation-using-Map-and-Sum)

  - [Grouping](#Grouping)

</div>

<div>

# Examples <span id="Examples"></span>

</div>

<div>

## Input Format and Creation <span id="Input-Format-and-Creation"></span>

The `tabut` function takes input in “record” format, an array of
dictionaries, with each dictionary representing a single “object” or
“record”.

In the example below, each record is a listing for an office supply
product.

<div>

``` typ
#let supplies = (
  (name: "Notebook", price: 3.49, quantity: 5),
  (name: "Ballpoint Pens", price: 5.99, quantity: 2),
  (name: "Printer Paper", price: 6.99, quantity: 3),
)
```

</div>

</div>

<div>

## Basic Table <span id="Basic-Table"></span>

Now create a basic table from the data.

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/basic.svg"
style="width:2.24804in;height:1.01335in" />

</div>

`funct` takes a function which generates content for a given cell
corrosponding to the defined column for each record. `r` is the record,
so `r => r.name` returns the `name` property of each record in the input
data if it has one.

</div>

<div>

The philosphy of `tabut` is that the display of data should be simple
and clearly defined, therefore each column and it’s content and
formatting should be defined within a single clear column defintion. One
consequence is you can comment out, remove or move, any column easily,
for example:

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/rearrange.svg"
style="width:2.58903in;height:1.01335in" />

</div>

</div>

<div>

## Table Styling <span id="Table-Styling"></span>

Any default Table style options can be tacked on and are passed to the
final table function.

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/styling.svg"
style="width:2.24804in;height:1.01335in" />

</div>

</div>

<div>

## Label Formatting <span id="Label-Formatting"></span>

You can pass any content or expression into the label property.

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/title.svg"
style="width:3.14555in;height:1.05075in" />

</div>

</div>

<div>

## Cell Expressions and Formatting <span id="Cell-Expressions-and-Formatting"></span>

Just like the labels cell contents can be modified and formatted like
any content in Typst.

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  ( 
    (label: [*Name*], func: r => r.name ), 
    (label: [*Price*], func: r => usd(r.price)), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/format.svg"
style="width:1.58711in;height:1.01133in" />

</div>

</div>

<div>

You can have the cell content function do calculations on a record
property.

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/calculation.svg"
style="width:2.53821in;height:1.01133in" />

</div>

</div>

<div>

Or even combine multiple record properties, go wild.

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut

#let employees = (
    (id: 3251, first: "Alice", last: "Smith", middle: "Jane"),
    (id: 4872, first: "Carlos", last: "Garcia", middle: "Luis"),
    (id: 5639, first: "Evelyn", last: "Chen", middle: "Ming")
);

#tabut(
  employees,
  ( 
    (label: [*ID*], func: r => r.id ),
    (label: [*Full Name*], func: r => [#r.first #r.middle.first(), #r.last] ),
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/combine.svg"
style="width:1.6171in;height:1.01133in" />

</div>

</div>

<div>

## Index <span id="Index"></span>

`tabut` automatically adds an `_index` property to each record.

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  ( 
    (label: [*\#*], func: r => r._index),
    (label: [*Name*], func: r => r.name ), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/index.svg"
style="width:1.31304in;height:1.01133in" />

</div>

</div>

<div>

## Transpose <span id="Transpose"></span>

This was annoying to implement, and I don’t know when you’d actually use
this, but here.

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  (
    (label: [*\#*], func: r => r._index),
    (label: [*Name*], func: r => r.name), 
    (label: [*Price*], func: r => usd(r.price)), 
    (label: [*Quantity*], func: r => r.quantity),
  ),
  transpose: true,  // set optional name arg `transpose` to `true`
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/transpose.svg"
style="width:3.57327in;height:1.01335in" />

</div>

</div>

<div>

## Alignment <span id="Alignment"></span>

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#tabut(
  supplies,
  ( // Include `align` as an optional arg to a column def
    (label: [*\#*], func: r => r._index),
    (label: [*Name*], align: right, func: r => r.name), 
    (label: [*Price*], align: right, func: r => usd(r.price)), 
    (label: [*Quantity*], align: right, func: r => r.quantity),
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/align.svg"
style="width:2.56141in;height:1.01133in" />

</div>

</div>

<div>

## Column Width <span id="Column-Width"></span>

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/supplies.typ": supplies

#box(
  width: 300pt,
  tabut(
    supplies,
    ( // Include `width` as an optional arg to a column def
      (label: [*\#*], func: r => r._index),
      (label: [*Name*], width: 1fr, func: r => r.name), 
      (label: [*Price*], width: 20%, func: r => usd(r.price)), 
      (label: [*Quantity*], width: 1.5in, func: r => r.quantity),
    ),
    fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
    stroke: none,
  )
)

```

</div>

<div>

<img src="doc/compiled-snippets/width.svg"
style="width:4.22222in;height:1.01133in" />

</div>

</div>

<div>

# Data Operation Examples <span id="Data-Operation-Examples"></span>

While technically seperate from table display, the following are
examples of how to perform operations on data before it is displayed
with `tabut`.

Since `tabut` assumes an “array of dictionaries” format, then most data
operations can be performed easily with Typst’s native array functions.
`tabut` also provides several functions to provide additional
functionality.

</div>

<div>

## CSV Data <span id="CSV-Data"></span>

By default, imported CSV gives a “rows” or “array of arrays” data
format, which can not be directly used by `tabut`. To convert, `tabut`
includes a function `rows-to-records` demonstrated below.

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut, rows-to-records
#import "example-data/supplies.typ": supplies

#let titanic = {
  let titanic-raw = csv("example-data/titanic.csv");
  rows-to-records(
    titanic-raw.first(), // The header row
    titanic-raw.slice(1, -1), // The rest of the rows
  )
}
```

</div>

Imported CSV data are all strings, so it’s usefull to convert them to
`int` or `float` when possible.

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut, rows-to-records
#import "example-data/supplies.typ": supplies

#let auto-type(input) = {
  let is-int = (input.match(regex("^-?\d+$")) != none);
  if is-int { return int(input); }
  let is-float = (input.match(regex("^-?(inf|nan|\d+|\d*(\.\d+))$")) != none);
  if is-float { return float(input) }
  input
}

#let titanic = {
  let titanic-raw = csv("example-data/titanic.csv");
  rows-to-records( titanic-raw.first(), titanic-raw.slice(1, -1) )
  .map( r => {
    let new-record = (:);
    for (k, v) in r.pairs() { new-record.insert(k, auto-type(v)); }
    new-record
  })
}
```

</div>

`tabut` includes a function, `records-from-csv`, to automatically
perform this process.

<div>

``` typ
#import "@preview/tabut:0.0.1": records-from-csv

#let titanic = records-from-csv("doc/example-snippets/example-data/titanic.csv");
```

</div>

</div>

<div>

## Slice <span id="Slice"></span>

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/slice.svg"
style="width:5.33036in;height:1.49023in" />

</div>

</div>

<div>

## Sorting and Reversing <span id="Sorting-and-Reversing"></span>

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/sort.svg"
style="width:4.40184in;height:1.49023in" />

</div>

</div>

<div>

## Filter <span id="Filter"></span>

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut
#import "usd.typ": usd
#import "example-data/titanic.typ": titanic, classes

#tabut(
  titanic
  .filter(r => r.Pclass == 1)
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
```

</div>

<div>

<img src="doc/compiled-snippets/filter.svg"
style="width:5.33036in;height:1.49023in" />

</div>

</div>

<div>

## Aggregation using Map and Sum <span id="Aggregation-using-Map-and-Sum"></span>

<div>

``` typ
#import "usd.typ": usd
#import "example-data/titanic.typ": titanic, classes

#table(
  columns: (auto, auto),
  [*Fare, Total:*], [#usd(titanic.map(r => r.Fare).sum())],
  [*Fare, Avg:*], [#usd(titanic.map(r => r.Fare).sum() / titanic.len())], 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/aggregation.svg"
style="width:1.73668in;height:0.53445in" />

</div>

</div>

<div>

## Grouping <span id="Grouping"></span>

<div>

``` typ
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
```

</div>

<div>

<img src="doc/compiled-snippets/group.svg"
style="width:1.53415in;height:1.01133in" />

</div>

<div>

``` typ
#import "@preview/tabut:0.0.1": tabut, group
#import "usd.typ": usd
#import "example-data/titanic.typ": titanic, classes

#tabut(
  group(titanic, r => r.Pclass),
  (
    (label: [*Class*], func: r => classes.at(r.value)), 
    (label: [*Total Fare*], func: r => usd(r.group.map(r => r.Fare).sum())), 
    (
      label: [*Avg Fare*], 
      func: r => usd(r.group.map(r => r.Fare).sum() / r.group.len())
    ), 
  ),
  fill: (_, row) => if calc.odd(row) { luma(240) } else { luma(220) }, 
  stroke: none
)
```

</div>

<div>

<img src="doc/compiled-snippets/group-aggregation.svg"
style="width:2.21231in;height:1.01133in" />

</div>

</div>
