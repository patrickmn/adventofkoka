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
  val row = boarding.rows.place((0, 127))
  val col = boarding.cols.place((0, 7))
  (row * 8) + col
}

fun place(instructions : list<instruction>, range : (int, int)) : int {
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

fun day05b(passes : list<boarding>) : maybe<int> {
  val sids = passes.map(seat-id)
  // TODO: sort when available
  with sid = sids.foreach-while
  val (before, after) = (sid - 1, sid + 1)
  if ((before - 1).elem(sids) && !(before.elem(sids))) {
    return Just(before)
  }
  if ((after + 1).elem(sids) && !(after.elem(sids))) {
    return Just(after)
  }
  Nothing
}

fun main() {
  match ("input/day05".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day05a.println
      match(parsed.day05b) {
        Nothing -> println("seat not found")
        Just(sid) -> sid.println
      }
    }
  }
}
