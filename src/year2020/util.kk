module util

public fun and(bools : list<bool>) : bool {
  bools.all(id)
}

public fun product(nums : list<int>) : int {
  nums.foldl(1, (*))
}

public fun how-many(list : list<a>, pred : a -> bool) : int {
  list.foldl(0, fn(acc, x) { if (pred(x)) acc + 1 else acc })
}

public fun has-key(list : list<(string, b)>, key : string) : bool {
  match (list.lookup fn(k) { k == key }) {
    Nothing -> False
    Just(_value) -> True
  }
}
