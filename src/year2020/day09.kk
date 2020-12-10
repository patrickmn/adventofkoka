module day09

import std/os/file
import std/os/path
import std/text/parse

import util

fun day09a(nums : list<int>) : div maybe<int> {
  val pre = nums.take(25)
  match (nums[25]) { // 26th number
    Nothing -> Nothing // there's less than 26 numbers left
    Just(candidate) ->
      if (!candidate.summable(pre).bool) {
        Just(candidate)
      } else {
        day09a(nums.drop(1))
      }
  }
}

fun summable(candidate : int, pre : list<int>) : maybe<(int, int)> {
  with n1 = pre.foreach-while
  with n2 = pre.foreach-while
  if (n1 != n2 && n1 + n2 == candidate) {
    return Just((n1, n2))
  }
  Nothing
}

fun day09b(nums : list<int>, invalid : int) : div maybe<int> {
  var sum := 0
  val range = nums.take-while fn(n) {
    sum := sum + n
    sum < invalid
  }
  if (sum == invalid) {
    Just(minimum(range) + maximum(range))
  } else {
    match (nums.drop(1)) {
      Nil -> Nothing
      nums2 -> day09b(nums2, invalid)
    }
  }
}

fun main() {
  match ("input/day09".path.read-text-file.parse-numbers) {
    ParseError(msg, _rest) -> println("parsing failed: " + msg)
    ParseOk(parsed, _rest) -> {
      match (parsed.day09a) {
        Nothing -> println("couldn't find unsummable number")
        Just(invalid) -> {
          println(invalid)
          match (parsed.day09b(invalid)) {
            Nothing -> println("couldn't find weakness")
            Just(weakness) -> println(weakness) 
          }
        }
      }
    }
  }
}
