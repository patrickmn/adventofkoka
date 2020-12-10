module day01

import std/os/file
import std/os/path
import std/text/parse

import util

fun day01a(numbers : list<int>) : maybe<int> {
  with n1 = numbers.foreach-while
  with n2 = numbers.foreach-while
  if (n1 + n2 == 2020) {
    return Just (n1 * n2)
  }
  Nothing
}

fun day01b(numbers : list<int>) : maybe<int> {
  with n1 = numbers.foreach-while
  with n2 = numbers.foreach-while
  with n3 = numbers.foreach-while
  if (n1 + n2 + n3 == 2020) {
    return Just (n1 * n2 * n3)
  }
  Nothing
}

fun main() {
  match ("input/day01".path.read-text-file.parse-numbers) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      parsed.day01a.maybe("day01a: no result", show).println
      parsed.day01b.maybe("day01b: no result", show).println
    }
  }
}
