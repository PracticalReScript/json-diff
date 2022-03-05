open Js

type t<'data>

type result<'data> = {
  value: option<'data>,
  done: bool,
}

@send external next: t<'data> => Js.Promise.t<result<'data>> = "next"

let to_array = t => {
  let rec aux = acc => {
    next(t) |> Promise.then_(result => {
      switch result {
      | {value: Some(el)} => aux(Array.concat([el], acc))
      | {value: None} => Promise.resolve(acc)
      }
    })
  }
  aux([])
}
