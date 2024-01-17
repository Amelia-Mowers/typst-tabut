<p>#let ex(input) = { set align(center); block( fill: luma(97%), inset: 8pt, radius: 4pt, breakable: false, [ #set align(left); #input ]) }</p>
<p>// #let echo(content, preamble) = { // let evalString = (preamble, content.text).join(“”) // [ // #ex(content) // #ex(eval(evalString, mode: “code”)) // ] // }</p>
<p>#let snippet(filename) = {[ #let snippet-code-path = “doc/example-snippets/” + filename + “.typ” #let snippet-image-path = “doc/compiled-snippets/” + filename + “.svg”</p>
<p>#let data = xml(snippet-image-path).first(); #let size = ( height: float(data.attrs.height) * 1pt , width: float(data.attrs.width) * 1pt, );</p>
<p>#let content = read(snippet-code-path).replace(“,”“) #ex(raw(content, block: true, lang:”typ")) // #ex(include filename)</p>
<p>#ex(image(snippet-image-path, ..size)) ]}</p>
<p>#let snippet-quiet(filename) = {[ #let snippet-code-path = “doc/example-snippets/” + filename + “.typ” #let content = read(snippet-code-path).replace(“,”“) #ex(raw(content, block: true, lang:”typ"))]}</p>
<p>#let section(content) = { block(breakable: false, width:100%, content) }</p>
<p>#section([</p>
<p>= Tabut</p>
<p><em>Powerfull, Simple, Concise</em></p>
<p>A Typst plugin for turning data into tables.</p>
<p>])#section([</p>
<p>= Examples</p>
<p>]) #section([</p>
<p>== Input Format and Creation</p>
<p>The <code>tabut</code> function takes input in “record” format, an array of dictionaries, with each dictionary representing a single “object” or “record”.</p>
<p>In the example below, each record is a listing for an office supply product.</p>
<p>#snippet-quiet(“example-data/supplies”)</p>
<p>]) #section([</p>
<p>== Basic Table</p>
<p>Now create a basic table from the data.</p>
<p>#snippet(“basic”)</p>
<p><code>funct</code> takes a function which generates content for a given cell corrosponding to the defined column for each record. <code>r</code> is the record, so <code>r =&gt; r.name</code> returns the <code>name</code> property of each record in the input data if it has one.</p>
<p>]) #section([</p>
<p>The philosphy of <code>tabut</code> is that the display of data should be simple and clearly defined, therefore each column and it’s content and formatting should be defined within a single clear column defintion. One consequence is you can comment out, remove or move, any column easily, for example:</p>
<p>#snippet(“rearrange”)</p>
<p>]) #section([</p>
<p>== Table Styling</p>
<p>Any default Table style options can be tacked on and are passed to the final table function.</p>
<p>#snippet(“styling”)</p>
<p>]) #section([</p>
<p>== Label Formatting</p>
<p>You can pass any content or expression into the label property.</p>
<p>#snippet(“title”)</p>
<p>]) #section([</p>
<p>== Cell Expressions and Formatting</p>
<p>Just like the labels cell contents can be modified and formatted like any content in Typst.</p>
<p>#snippet(“format”)</p>
<p>]) #section([</p>
<p>You can have the cell content function do calculations on a record property.</p>
<p>#snippet(“calculation”)</p>
<p>]) #section([</p>
<p>Or even combine multiple record properties, go wild.</p>
<p>#snippet(“combine”)</p>
<p>]) #section([</p>
<p>== Index</p>
<p><code>tabut</code> automatically adds an <code>_index</code> property to each record.</p>
<p>#snippet(“index”)</p>
<p>]) #section([</p>
<p>== Transpose</p>
<p>This was annoying to implement, and I don’t know when you’d actually use this, but here.</p>
<p>#snippet(“transpose”)</p>
<p>]) #section([</p>
<p>== Alignment</p>
<p>#snippet(“align”)</p>
<p>]) #section([</p>
<p>== Column Width</p>
<p>#snippet(“width”)</p>
<p>])</p>
<p>#pagebreak(weak: true)</p>
<p>#section([</p>
<p>= Data Operation Examples</p>
<p>While technically seperate from table display, the following are examples of how to perform operations on data before it is displayed with <code>tabut</code>.</p>
<p>Since <code>tabut</code> assumes an “array of dictionaries” format, then most data operations can be performed easily with Typst’s native array functions. <code>tabut</code> also provides several functions to provide additional functionality.</p>
<p>]) #section([</p>
<p>== CSV data</p>
<p>By default, imported CSV gives a “rows” or “array of arrays” data format, which can not be directly used by <code>tabut</code>. To convert, <code>tabut</code> includes a function <code>rows-to-records</code> demonstrated below.</p>
<p>#snippet-quiet(“import-csv-raw”)</p>
<p>Imported CSV data are all strings, so it’s usefull to convert them to <code>int</code> or <code>float</code> when possible.</p>
<p>#snippet-quiet(“import-csv”)</p>
<p><code>tabut</code> includes a function, <code>records-from-csv</code>, to automatically perform this process.</p>
<p>#snippet-quiet(“import-csv-easy”)</p>
<p>]) #section([</p>
<p>== <code>slice</code></p>
<p>#snippet(“slice”)</p>
<p>]) #section([</p>
<p>== Sorting and Reversing</p>
<p>#snippet(“sort”)</p>
<p>]) #section([</p>
<p>== <code>filter</code></p>
<p>#snippet(“filter”)</p>
<p>]) #section([</p>
<p>== Aggregation using <code>map</code> and <code>sum</code></p>
<p>#snippet(“aggregation”)</p>
<p>]) #section([</p>
<p>== Grouping</p>
<p>#snippet(“group”)</p>
<p>#snippet(“group-aggregation”)</p>
<p>])</p>
