module day05

import std/os/file
import std/os/path
import std/text/parse

import util

struct boarding {
  rows : list<instruction>
  cols : list<instruction>
}

type instruction {
  TakeLower
  TakeUpper
}

fun parse(contents : string) : parse-error<list<boarding>> {
  with contents.slice.parse-eof
  many {
    val rows = count(7, { ({ char('F'); TakeLower }) || ({ char('B'); TakeUpper }) })
    val cols = count(3, { ({ char('L'); TakeLower }) || ({ char('R'); TakeUpper }) })
    char('\n')
    Boarding(rows, cols)
  }
}

fun day05a(passes : list<boarding>) : int {
  passes.foldl(0, fn(acc, boarding) { max(boarding.seat-id, acc) })
}

fun seat-id(boarding : boarding) : int {
  val row = place((0, 127), boarding.rows)
  val col = place((0, 7), boarding.cols)
  (row * 8) + col
}

fun place(range : (int, int), instructions : list<instruction>) : int {
  val res = instructions.init.foldl(range, fn(acc, instr) {
    val (low, high) = acc
    match (instr) {
      TakeLower -> (low : int, ((high - low + 1) / 2) - 1 + low)
      TakeUpper -> ((high - low + 1) / 2 + low, high)
    }
  })
  match (instructions.last.default(TakeLower)) {
    TakeLower -> res.fst
    TakeUpper -> res.snd
  }
}

fun day05b(passes : list<boarding>) : int {
  2
}

fun main() {
  match ("input/day05".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day05a.println
      parsed.day05b.println
    }
  }
}
