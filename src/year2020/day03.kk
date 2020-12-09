module day03

import std/os/file
import std/os/path
import std/text/parse

import util

fun parse(s : string) : parse-error<list<list<char>>> {
  with s.slice.parse-eof
  many {
    val row = many { one-of("#.") }
    char('\n')
    row
  }
}

fun day03a(rows : list<list<char>>) : div int {
  rows.count-trees(3, 1)
}

fun count-trees(rows : list<list<char>>, right : int, down : int) : div int {
  var x := 0
  var y := 0
  var trees := 0
  while { y < rows.length } {
    x := x + right
    y := y + down
    val row = rows[y].default([])
    if (x >= row.length) {
      x := x - row.length
    }
    if (row[x].default('.') == '#') {
      trees := trees + 1
    }
  }
  trees
}

fun day03b(rows : list<list<char>>) : div int {
  [ rows.count-trees(1, 1),
    rows.count-trees(3, 1),
    rows.count-trees(5, 1),
    rows.count-trees(7, 1),
    rows.count-trees(1, 2),
  ].product
}

fun main() {
  match ("input/day03".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day03a.println
      parsed.day03b.println
    }
  }
}
