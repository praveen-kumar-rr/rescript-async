type promiseFn<'a, +'b> = 'a => Js.Promise.t<'b>

let resolve = Js.Promise.resolve
let catch = (a, f) => Js.Promise.catch(f, a)
let map = (a, fn) => Js.Promise.then_(v => v->fn->resolve, a)
let flatMap = (a, fn) => Js.Promise.then_(fn, a)
let catchResolve = (a, fn) => a->catch(e => e->fn->resolve)
let thenResolve = map
let then = flatMap

let asyncSequence = (~a: promiseFn<unit, 'a>, ~b: promiseFn<{"a": 'a}, 'b>) =>
  a()
  ->map(ar => {"a": ar})
  ->flatMap(ar =>
    ar
    ->b
    ->map(br =>
      {
        "a": ar["a"],
        "b": br,
      }
    )
  )

let asyncSequence3 = (
  ~a: promiseFn<unit, 'a>,
  ~b: promiseFn<{"a": 'a}, 'b>,
  ~c: promiseFn<{"a": 'a, "b": 'b}, 'c>,
) =>
  asyncSequence(~a, ~b)->flatMap(abr =>
    abr
    ->c
    ->map(cr =>
      {
        "a": abr["a"],
        "b": abr["b"],
        "c": cr,
      }
    )
  )

let asyncSequence4 = (
  ~a: promiseFn<unit, 'a>,
  ~b: promiseFn<{"a": 'a}, 'b>,
  ~c: promiseFn<{"a": 'a, "b": 'b}, 'c>,
  ~d: promiseFn<{"a": 'a, "b": 'b, "c": 'c}, 'd>,
) =>
  asyncSequence3(~a, ~b, ~c)->flatMap(abcr =>
    abcr
    ->d
    ->map(dr =>
      {
        "a": abcr["a"],
        "b": abcr["b"],
        "c": abcr["c"],
        "d": dr,
      }
    )
  )

let asyncSequence5 = (
  ~a: promiseFn<unit, 'a>,
  ~b: promiseFn<{"a": 'a}, 'b>,
  ~c: promiseFn<{"a": 'a, "b": 'b}, 'c>,
  ~d: promiseFn<{"a": 'a, "b": 'b, "c": 'c}, 'd>,
  ~e: promiseFn<{"a": 'a, "b": 'b, "c": 'c, "d": 'd}, 'e>,
) =>
  asyncSequence4(~a, ~b, ~c, ~d)->flatMap(abcdr =>
    abcdr
    ->e
    ->map(er =>
      {
        "a": abcdr["a"],
        "b": abcdr["b"],
        "c": abcdr["c"],
        "d": abcdr["d"],
        "e": er,
      }
    )
  )

let asyncSequence6 = (
  ~a: promiseFn<unit, 'a>,
  ~b: promiseFn<{"a": 'a}, 'b>,
  ~c: promiseFn<{"a": 'a, "b": 'b}, 'c>,
  ~d: promiseFn<{"a": 'a, "b": 'b, "c": 'c}, 'd>,
  ~e: promiseFn<{"a": 'a, "b": 'b, "c": 'c, "d": 'd}, 'e>,
  ~f: promiseFn<{"a": 'a, "b": 'b, "c": 'c, "d": 'd, "e": 'e}, 'f>,
) =>
  asyncSequence5(~a, ~b, ~c, ~d, ~e)->flatMap(abcder =>
    abcder
    ->f
    ->map(fr =>
      {
        "a": abcder["a"],
        "b": abcder["b"],
        "c": abcder["c"],
        "d": abcder["d"],
        "e": abcder["e"],
        "f": fr,
      }
    )
  )

let asyncSequence7 = (
  ~a: promiseFn<unit, 'a>,
  ~b: promiseFn<{"a": 'a}, 'b>,
  ~c: promiseFn<{"a": 'a, "b": 'b}, 'c>,
  ~d: promiseFn<{"a": 'a, "b": 'b, "c": 'c}, 'd>,
  ~e: promiseFn<{"a": 'a, "b": 'b, "c": 'c, "d": 'd}, 'e>,
  ~f: promiseFn<{"a": 'a, "b": 'b, "c": 'c, "d": 'd, "e": 'e}, 'f>,
  ~g: promiseFn<{"a": 'a, "b": 'b, "c": 'c, "d": 'd, "e": 'e, "f": 'f}, 'g>,
) =>
  asyncSequence6(~a, ~b, ~c, ~d, ~e, ~f)->flatMap(abcdefr =>
    abcdefr
    ->g
    ->map(gr =>
      {
        "a": abcdefr["a"],
        "b": abcdefr["b"],
        "c": abcdefr["c"],
        "d": abcdefr["d"],
        "e": abcdefr["e"],
        "f": abcdefr["f"],
        "g": gr,
      }
    )
  )
