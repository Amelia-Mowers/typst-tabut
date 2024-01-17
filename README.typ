#let ex(input) = {
  set align(center);
  block(
  fill: luma(97%),
  inset: 8pt,
  radius: 4pt,
  breakable: false,
  [
    #set align(left);
    #input
  ])
}

// #let echo(content, preamble) = {
//   let evalString = (preamble, content.text).join("\n\n")
//   [
//     #ex(content)
//     #ex(eval(evalString, mode: "code"))
//   ]
// }

#let snippet(filename) = {[
  #let snippet-code-path = "doc/example-snippets/" + filename + ".typ"
  #let snippet-image-path = "doc/compiled-snippets/" + filename + ".svg"

  #let data = xml(snippet-image-path).first();
  #let size = (
    height: float(data.attrs.height) * 1pt ,
    width: float(data.attrs.width) * 1pt,
  );

  #let content = read(snippet-code-path).replace("\r", "")
  #ex(raw(content, block: true, lang: "typ"))
  // #ex(include filename)

  #ex(image(snippet-image-path, ..size))
]}

#let snippet-quiet(filename) = {[
  #let snippet-code-path = "doc/example-snippets/" + filename + ".typ"
  #let content = read(snippet-code-path).replace("\r", "")
  #ex(raw(content, block: true, lang: "typ"))
]}

#let section(content) = {
  block(breakable: false, width:100%, content)
}

#section([

= Tabut

_Powerful, Simple, Concise_

A Typst plugin for turning data into tables.

])#section([

= Examples

]) #section([

== Input Format and Creation

The `tabut` function takes input in "record" format, an array of dictionaries, with each dictionary representing a single "object" or "record".

In the example below, each record is a listing for an office supply product.

#snippet-quiet("example-data/supplies")

]) #section([

== Basic Table

Now create a basic table from the data. 

#snippet("basic")

`funct` takes a function which generates content for a given cell corrosponding to the defined column for each record. 
`r` is the record, so `r => r.name` returns the `name` property of each record in the input data if it has one.

]) #section([

The philosphy of `tabut` is that the display of data should be simple and clearly defined, 
therefore each column and it's content and formatting should be defined within a single clear column defintion.
One consequence is you can comment out, remove or move, any column easily, for example:

#snippet("rearrange")

]) #section([

== Table Styling

Any default Table style options can be tacked on and are passed to the final table function.

#snippet("styling")

]) #section([

== Label Formatting

You can pass any content or expression into the label property.

#snippet("title")

]) #section([

== Cell Expressions and Formatting

Just like the labels cell contents can be modified and formatted like any content in Typst.

#snippet("format")

]) #section([

You can have the cell content function do calculations on a record property.

#snippet("calculation")

]) #section([

Or even combine multiple record properties, go wild.

#snippet("combine")

]) #section([

== Index

`tabut` automatically adds an `_index` property to each record.

#snippet("index")

]) #section([

== Transpose

This was annoying to implement, and I don't know when you'd actually use this, but here.

#snippet("transpose")

]) #section([

== Alignment

#snippet("align")

]) #section([

== Column Width

#snippet("width")

]) 

#pagebreak(weak: true)

#section([

= Data Operation Examples

While technically seperate from table display, the following are examples of how to perform operations on data before it is displayed with `tabut`.

Since `tabut` assumes an "array of dictionaries" format, then most data operations can be performed easily with Typst's native array functions. `tabut` also provides several functions to provide additional functionality.

]) #section([

== CSV data

By default, imported CSV gives a "rows" or "array of arrays" data format, which can not be directly used by `tabut`.
To convert, `tabut` includes a function `rows-to-records` demonstrated below.

#snippet-quiet("import-csv-raw")

Imported CSV data are all strings, so it's usefull to convert them to `int` or `float` when possible.

#snippet-quiet("import-csv")

`tabut` includes a function, `records-from-csv`, to automatically perform this process.

#snippet-quiet("import-csv-easy")

]) #section([

== `slice`

#snippet("slice")

]) #section([

== Sorting and Reversing

#snippet("sort")

]) #section([

== `filter`

#snippet("filter")

]) #section([

== Aggregation using `map` and `sum`

#snippet("aggregation")

]) #section([

== Grouping

#snippet("group")

#snippet("group-aggregation")

])



