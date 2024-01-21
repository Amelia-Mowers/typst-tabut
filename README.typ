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

#let no-break(content) = {
  block(breakable: false, width:100%, content)
}

#let subsection(name) = {
  [== #name ]
}

#let stringify-by-func(it) = {
  let func = it.func()
  return if func in (parbreak, pagebreak, linebreak) {
    "\n"
  } else if func == smartquote {
    if it.double { "\"" } else { "'" } // "
  } else if it.fields() == (:) {
    // a fieldless element is either specially represented (and caught earlier) or doesn't have text
    ""
  } else {
    panic("Not sure how to handle type `" + repr(func) + "`")
  }
}

#let plain-text(it) = {
  return if type(it) == str {
    it
  } else if it == [ ] {
    " "
  } else if it.has("children") {
    it.children.map(plain-text).join()
  } else if it.has("body") {
    plain-text(it.body)
  } else if it.has("text") {
    it.text
  } else {
    stringify-by-func(it)
  }
}

#let section(name) = {
  [= #name #label(name.text.replace(" ", "-"))]
}

#let subsection(name) = {
  [== #name #label(name.text.replace(" ", "-"))]
}

#no-break([

#section([Tabut])

_Powerful, Simple, Concise_

A Typst plugin for turning data into tables.

== Outline

#set list(marker: ([•], [◦]))

#let sections = (
  (name: [Examples], subs: (
    [Input Format and Creation],
    [Basic Table],
    [Table Styling],
    [Header Formatting],
    [Remove Headers],
    [Cell Expressions and Formatting],
    [Index],
    [Transpose],
    [Alignment],
    [Column Width],
    [Get Cells Only],
    [Use with Tablex],
  )),
  (name: [Data Operation Examples], subs: (
    [CSV Data],
    [Slice],
    [Sorting and Reversing],
    [Filter],
    [Aggregation using Map and Sum],
    [Grouping]
  )),
)

#{
  let items = ();
  for s in sections {
    let s-items = ();
    for ss in s.subs {
      s-items.push(link(label(ss.text.replace(" ", "-")), ss));
    }
    items.push([
      #link(label(s.name.text.replace(" ", "-")), s.name)
      #list(..s-items)
    ])
  }
  list(..items)
}

]) 

#pagebreak(weak: true)

#no-break([

#section([Examples])

]) #no-break([

#subsection([Input Format and Creation])

The `tabut` function takes input in "record" format, an array of dictionaries, with each dictionary representing a single "object" or "record".

In the example below, each record is a listing for an office supply product.

#snippet-quiet("example-data/supplies")

]) #no-break([

#subsection([Basic Table])

Now create a basic table from the data. 

#snippet("basic")

`funct` takes a function which generates content for a given cell corrosponding to the defined column for each record. 
`r` is the record, so `r => r.name` returns the `name` property of each record in the input data if it has one.

]) #no-break([

The philosphy of `tabut` is that the display of data should be simple and clearly defined, 
therefore each column and it's content and formatting should be defined within a single clear column defintion.
One consequence is you can comment out, remove or move, any column easily, for example:

#snippet("rearrange")

]) #no-break([

#subsection([Table Styling])

Any default Table style options can be tacked on and are passed to the final table function.

#snippet("styling")

]) #no-break([

#subsection([Header Formatting])

You can pass any content or expression into the header property.

#snippet("title")

]) #no-break([

#subsection([Remove Headers])

You can prevent from being generated with the `headers` paramater. This is useful with the `tabut-cells` function as demonstrated in it's section.

#snippet("no-headers")

]) #no-break([

#subsection([Cell Expressions and Formatting])

Just like the headers, cell contents can be modified and formatted like any content in Typst.

#snippet("format")

]) #no-break([

You can have the cell content function do calculations on a record property.

#snippet("calculation")

]) #no-break([

Or even combine multiple record properties, go wild.

#snippet("combine")

]) #no-break([

#subsection([Index])

`tabut` automatically adds an `_index` property to each record.

#snippet("index")

]) #no-break([

#subsection([Transpose])

This was annoying to implement, and I don't know when you'd actually use this, but here.

#snippet("transpose")

]) #no-break([

#subsection([Alignment])

#snippet("align")

]) #no-break([

#subsection([Column Width])

#snippet("width")

]) #no-break([

#subsection([Get Cells Only])

#snippet("only-cells")

]) #no-break([

#subsection([Use with Tablex])

#snippet("tablex")

]) 

#pagebreak(weak: true)

#no-break([

#section([Data Operation Examples])

While technically seperate from table display, the following are examples of how to perform operations on data before it is displayed with `tabut`.

Since `tabut` assumes an "array of dictionaries" format, then most data operations can be performed easily with Typst's native array functions. `tabut` also provides several functions to provide additional functionality.

]) #no-break([

#subsection([CSV Data])

By default, imported CSV gives a "rows" or "array of arrays" data format, which can not be directly used by `tabut`.
To convert, `tabut` includes a function `rows-to-records` demonstrated below.

#snippet-quiet("import-csv-raw")

Imported CSV data are all strings, so it's usefull to convert them to `int` or `float` when possible.

#snippet-quiet("import-csv")

`tabut` includes a function, `records-from-csv`, to automatically perform this process.

#snippet-quiet("import-csv-easy")

]) #no-break([

#subsection([Slice])

#snippet("slice")

]) #no-break([

#subsection([Sorting and Reversing])

#snippet("sort")

]) #no-break([

#subsection([Filter])

#snippet("filter")

]) #no-break([

#subsection([Aggregation using Map and Sum])

#snippet("aggregation")

]) #no-break([

#subsection([Grouping])

#snippet("group")

#snippet("group-aggregation")

])



