module day10

import std/os/file
import std/os/path
import std/text/parse

import util

fun parse(s : string) : div parse-error<list<int>> {
  with s.slice.parse-eof
  many {

    char('\n')
  }
}

fun day10a(nums : list<int>) : int {
  1
}

fun day10b(nums : list<int>) : int {
  2
}

fun main() {
  trace("TODO")
  match ("input/day10".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day10a.println
      parsed.day10b.println
    }
  }
}
