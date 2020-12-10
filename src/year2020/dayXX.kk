module dayXX

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

fun dayXXa(nums : list<int>) : int {
  1
}

fun dayXXb(nums : list<int>) : int {
  2
}

fun main() {
  match ("input/dayXX".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.dayXXa.println
      parsed.dayXXb.println
    }
  }
}
