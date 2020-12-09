module day06

import std/os/file
import std/os/path
import std/text/parse

import util

fun parse(s : string) : list<list<list<char>>> {
  with group = s.split("\n\n").map
  with person = group.trim-right.split("\n").map
  person.list
}

fun day06a(groups : list<list<list<char>>>) : int {
  groups.map fn(entry) {
    var seen := []
    var answered := 0
    entry.foreach fn(person) {
      person.foreach fn(answer) {
        if (!answer.elem(seen)) {
          seen := Cons(answer, seen)
          answered := answered + 1
        }
      }
    }
    answered
  }.sum
}

fun day06b(groups : list<list<list<char>>>) : int {
  groups.map fn(entry) {
    var seen := []
    var answered := 0
    entry.foreach fn(person) {
      person.foreach fn(answer) {
        if (!answer.elem(seen) && entry.all fn(person') { answer.elem(person') }) {
          seen := Cons(answer, seen)
          answered := answered + 1
        }
      }
    }
    answered
  }.sum
}

fun main() {
  val parsed = "input/day06".path.read-text-file.parse
  parsed.day06a.println
  parsed.day06b.println
}
