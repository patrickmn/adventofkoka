module day04

import std/os/file
import std/os/path
import std/text/parse

import util

fun parse(s : string) : list<list<(string, string)>> {
  with entry = s.split("\n\n").filter-map
  entry.slice.parse-eof({
    many {
      val k = none-of-many1(":")
      char(':')
      val v = none-of-many1(" \n")
      optional(' ', { one-of(" \n") })
      (k, v)
    }
  }).maybe
}

fun day04a(passports : list<list<(string, string)>>) : int {
  passports.how-many(is-valid)
}

fun is-valid(list : list<(string, string)>) : bool {
  (list.has-key("byr") && list.has-key("iyr") && list.has-key("eyr") &&
   list.has-key("hgt") && list.has-key("hcl") && list.has-key("ecl") &&
   list.has-key("pid")) // "cid" optional
}

fun day04b(passports : list<list<(string, string)>>) : int {
  passports.how-many(is-valid2)
}

fun is-valid2(list : list<(string, string)>) : bool {
  [ list.validate("byr", { val n = pint(); n >= 1920 && n <= 2002 })
  , list.validate("iyr", { val n = pint(); n >= 2010 && n <= 2020 })
  , list.validate("eyr", { val n = pint(); n >= 2020 && n <= 2030 })
  , list.validate("hgt", {
      val n = pint()
      ({ pstring("cm"); n >= 150 && n <= 193 }) || ({ pstring("in"); n >= 59 && n <= 76 })
    })
  , list.validate("hcl", {
      char('#')
      count(6, { char-is("hex", is-hex-digit) })
      True
    })
  , list.validate("ecl", {
      val s = count(3, alpha).string
      (s == "amb" || s == "blu" || s == "brn" || s == "gry" || s == "grn" ||
       s == "hzl" || s == "oth")
    })
  , list.validate("pid", { count(9, digit); True })
  ].and
}

fun validate(list : list<(string, string)>, key : string, validator : () -> <parse|e> bool) : e bool {
  list.lookup(fn(k) { k == key }).maybe(False, fn(v) {
    v.slice.parse-eof(validator).maybe.default(False)
  })
}

fun main() {
  val parsed = "input/day04".path.read-text-file.parse
  parsed.day04a.println
  parsed.day04b.println
}
