#let tabut(data-raw, colDefs, ..tableArgs) = {
  // TODO: handle cols/alignment being defined in the table args and colDefs
  // TODO: tablex integration?
  // TODO: Short hand for if you want a col just to be the function as a property?
  // TODO: Default formatting?
  // TODO: auto table generation?
  // TODO: turn off adding index
  // TODO: short hand col definitions

  let posArgs = tableArgs.pos();
  let namedArgs = tableArgs.named();

  let transpose = false;

  if namedArgs.at("transpose", default: none) != none {
    transpose = namedArgs.remove("transpose");
  }

  let data = ();
  let i = 0;
  for record in data-raw {
    let new-record = record;
    new-record.insert("_index", i)
    data.push(new-record);
    i = i + 1;
  }
    
  let entries = ();
  let colWidths = ();
  let colAlignments = ();

  if transpose {
    colWidths.push(auto);
    colAlignments.push(auto);

    for record in data {
      colWidths.push(auto);
      colAlignments.push(auto); 
    }

    for colDef in colDefs {
      entries.push(colDef.label);
      for record in data {
        entries.push([#(colDef.func)(record)])
      }
    }
  } else {
    for colDef in colDefs {
      if colDef.keys().contains("width") {
        colWidths.push(colDef.width);
      } else {
        colWidths.push(auto);
      }
      if colDef.keys().contains("align") {
        colAlignments.push(colDef.align);
      } else {
        colAlignments.push(auto);
      }
    }

    for colDef in colDefs {
      entries.push(colDef.label);
    }

    for record in data {
      for colDef in colDefs {
        entries.push([#(colDef.func)(record)])
      }
    }
  }

  table(
    columns: colWidths,
    align: colAlignments,
    ..posArgs,
    ..namedArgs,
    ..entries
  )
}

#let rows-to-records(headers, rows) = {
  // TODO: Add optional default for cells without values?
  rows.map(r => {
    let record = (:);
    let i = 0;
    for header in headers {
      record.insert(header, r.at(i));
      i = i + 1;
    }
    record
  })
}

#let group(data, function) = {
  let groups = ();
  for record in data {
    let value = function(record);
    let group-pos = groups.position(g => g.value == value);
    if group-pos == none {
      let new-group = (value: value, group: ());
      new-group.group.push(record);
      groups.push(new-group);
    } else {
      groups.at(group-pos).group.push(record)
    }
  }
  groups.sorted(key: r => r.value)
}

#let auto-type(input) = {

  let is-int = (input.match(regex("^-?\d+$")) != none);
  if is-int { return int(input); }

  let is-float = (input.match(regex("^-?(inf|nan|\d+|\d*(\.\d+))$")) != none);
  if is-float { return float(input) }

  input
}

#let records-from-csv(filename) = {
  let data = {
    let data-raw = csv(filename);
    rows-to-records(data-raw.first(), data-raw.slice(1, -1))
  }
  data.map( r => {
    let new-record = (:);
    for (k, v) in r.pairs() {
      new-record.insert(k, auto-type(v));
    }
    new-record
  })
}