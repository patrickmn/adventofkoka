module day08

import std/os/file
import std/os/path
import std/text/parse

import util

type instruction {
  Acc(n : int)
  Jmp(n : int)
  Nop(n : int)
}

type result {
  Loop(acc : int)
  Finished(acc : int)
}

fun show(res : result) : string {
  match (res) {
    Loop(acc) -> "Loop: " + acc.show
    Finished(acc) -> "Finished: " + acc.show
  }
}

fun parse(s : string) : parse-error<list<instruction>> {
  with s.slice.parse-eof
  many {
    val instr = choose(
      [{ pstring("acc")
         char(' ')
         val n = pint()
         Acc(n)
       },
       { pstring("jmp")
         char(' ')
         val n = pint()
         Jmp(n)
       },
       { pstring("nop")
         char(' ')
         val n = pint()
         Nop(n)
       }]
    )
    char('\n')
    instr
  }
}

fun day08a(instrs-list : list<instruction>) : <div, exn> result {
  val instrs = instrs-list.vector
  val seen = vector(instrs.length, False)
  go(instrs, seen)
}

fun go(instrs : vector<instruction>, seen : vector<bool>, acc : int = 0, pos : int = 0) : <div, exn> result {
  if (pos == instrs.length)
    Finished(acc)
  elif (pos > instrs.length)
    throw("out of bounds", ExnRange)
  elif (seen.at(pos).default(False))
    Loop(acc)
  else {
    var seen2 := seen
    seen2[pos] := True // Is there notation for this?
    match (instrs.at(pos).default(Nop(0))) {
      Acc(n) -> go(instrs, seen2, acc + n, pos + 1)
      Jmp(n) -> go(instrs, seen2, acc, pos + n)
      Nop(_) -> go(instrs, seen2, acc, pos + 1)
    }
  }
}

fun day08b(init-instrs : list<instruction>) : <div, exn> maybe<int> {
  var i := 0
  init-instrs.foreach-while fn(instr) {
    var flipped := Nothing
    match (instr) {
      Jmp(n) -> flipped := Just(Nop(n))
      Nop(n) -> flipped := Just(Jmp(n))
      _ -> ()
    }
    val res = match (flipped) {
      Nothing -> Nothing
      Just(instr2) -> {
        var instrs := init-instrs.vector
        instrs[i] := instr2
        val seen = vector(instrs.length, False)
        match (go(instrs, seen)) {
          Finished(acc) -> Just(acc)
          _ -> Nothing
        }
      }
    }
    i := i + 1
    res
  }
}

fun main() {
  match ("input/day08".path.read-text-file.parse) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day08a.show.println
      match (parsed.day08b) {
        Nothing -> println("flippable instruction not found")
        Just(acc) -> acc.println
      }
    }
  }
}
