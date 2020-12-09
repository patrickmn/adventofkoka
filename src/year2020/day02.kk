module day02

import std/os/file
import std/os/path
import std/text/parse

import util

struct entry {
  min : int
  max : int
  character : char
  password : list<char>
}

fun parse(s : string) : parse-error<list<entry>> {
  with s.slice.parse-eof
  many {
    val from = pint()
    char('-')
    val to = pint()
    char(' ')
    val chr = alpha()
    char(':')
    char(' ')
    val chars = many(alpha)
    char('\n')
    Entry(from, to, chr, chars)
  }
}

fun day02a(entries : list<entry>) : int {
  entries.how-many(is-valid)
}

fun is-valid(entry : entry) : bool {
  val n = entry.password.how-many fn(c) { c == entry.character }
  n >= entry.min && n <= entry.max
}

fun day02b(entries : list<entry>) : int {
  entries.how-many(is-valid2)
}

fun is-valid2(entry : entry) : bool {
  val (pos1, pos2) = (entry.min - 1, entry.max - 1)
  val pos1Match = entry.password[pos1].maybe(False, fn(x) { x == entry.character })
  val pos2Match = entry.password[pos2].maybe(False, fn(x) { x == entry.character })
  (pos1Match || pos2Match) && !(pos1Match && pos2Match) 
}

fun main() {
  match ("input/day02".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day02a.println
      parsed.day02b.println
    }
  }
}
