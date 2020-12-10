module day07

import std/os/file
import std/os/path
import std/text/parse

import util

struct bag {
  adj1 : string
  adj2 : string
  contains : list<(int, bag)> = []
}

fun parse(s : string) : div parse-error<list<bag>> {
  with s.slice.parse-eof
  var done := 0 // TEMP
  many {
    var bag := pbag()
    pstring(" contain ")
    val contents = pcontents([])
    optional("", { pstring("no other bags.") })
    char('\n')
    done := done + 1 // TEMP
    trace(done.show) // TEMP
    bag(contains = contents)
  }
}

fun pbag() : <parse, div> bag {
  val adj1 = many(alpha).string
  // trace(adj1)
  char(' ')
  val adj2 = many(alpha).string
  // trace(adj2)
  char(' ')
  pstring("bag")
  optional(' ', { char('s') })
  Bag(adj1, adj2)
}

fun pcontents(bags : list<(int, bag)>) : <parse, div> list<(int, bag)> {
  optional(bags, {
    val n = pint()
    trace(n.show)
    char(' ')
    val bag = pbag()
    optional([], { chars-are("", fn(c) { c == ',' || c == ' ' || c == '.' }) })
    pcontents(Cons((n, bag), bags))
  })
}

fun day07a(passes : list<bag>) : int {
  1
}

fun day07b(passes : list<bag>) : int {
  2
}

fun main() {
  trace("TODO")
  match ("input/day07".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day07a.println
      parsed.day07b.println
    }
  }
}
