Promise.asyncSequence5(
  ~a=() => Promise.resolve(1),
  ~b=arg => Promise.resolve(arg["a"] + 2),
  ~c=_ => Promise.resolve(3),
  ~d=_ => Promise.resolve(4),
  ~e=arg => Promise.resolve(arg["a"] + arg["c"] + 3),
)
->Promise.map(Js.log)
->ignore
