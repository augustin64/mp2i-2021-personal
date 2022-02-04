#!/usr/bin/ocaml
let exc g r =
  let dist = Array.make g.n (-1) in
  let rec aux d cur next = match cur with
    | [] -> if next <> [] then aux (d + 1) next [] else d
    | u::q when dist.(u) = -1 -> aux d q next
    | u::q -> dist.(u) <- d;
              aux d q (next @ (g.adj u)) in
  aux 0 [r] [];;

let diametre g =
  let n = g.n in
  let a = ref 0 in
  for i=0 to n-1 do
    a := max (exc g i, !a)
  done;
  !a;;

let centre g =
  let n = g.n in
  let a = ref 0 in
  let s = ref 0 in
  for i=0 to n-1 do
    if exc g i < !a
      then (a := exc g i; s := i)
  done;
  !s;;
