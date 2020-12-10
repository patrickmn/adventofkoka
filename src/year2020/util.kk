module util

import std/text/parse

public fun and(bools : list<bool>) : bool {
  bools.all(id)
}

public fun product(ints : list<int>) : int {
  ints.foldl(1, (*))
}

public fun how-many(xs : list<a>, pred : a -> bool) : int {
  xs.foldl(0, fn(acc, x) { if (pred(x)) acc + 1 else acc })
}

public fun elem(x : int, xs : list<int>) : bool {
  match (xs.find fn(n) { n == x }) {
    Nothing -> False
    Just(_value) -> True
  }
}

public fun elem(x : char, xs : list<char>) : bool {
  match (xs.find fn(n) { n == x }) {
    Nothing -> False
    Just(_value) -> True
  }
}

public fun has-key(list : list<(string, b)>, key : string) : bool {
  match (list.lookup fn(k) { k == key }) {
    Nothing -> False
    Just(_value) -> True
  }
}

public fun parse-numbers(s : string) : parse-error<list<int>> {
  with s.slice.parse-eof
  many {
    val n = pint()
    char('\n')
    n
  }
}
