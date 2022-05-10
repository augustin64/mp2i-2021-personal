type 'a arb = N of 'a * 'a arb list


let exc g r =
  let dist = Array.make (Array.length g) (-1) in
  let rec aux d cur next = match cur with
    | [] -> if next <> [] then aux (d + 1) next [] else d
    | u::q when dist.(u) = -1 -> aux d q next
    | u::q -> dist.(u) <- d;
              aux d q (g.(u) @ next) in
  aux 0 [r] [];;


let diametre g =
  let n = Array.length g in
  let a = ref 0 in
  for i=0 to n-1 do
    a := max (exc g i) !a
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


(* Si g est un arbre, on a : *)
let rec diam_arb = function
  | N(r, []) -> 0, 0 (* renvoie diametre, hauteur *)
  | N(r, e::q) -> let dq, hq = diam_arb (N(r, q)) in
                  let de, dq = diam_arb e in
                  max de (max dq (he + hq + 1)), max (he + 1) hq

(* I.5 *)
(* On définit G' = (V', E')
      où  V' = (V\S)u{s}
          E' = E\{ {u, v}∈E | u∈S } u { {s,v} | {u,v}∈E, u∈S }

    Solution simple:
      Faire un BFS avec initialement
      cur = S (ou une file contenant S)
*)

(* I.6 *)
(*  Plus court chemin de u à w, passant par v :
    - Faire un BFS depuis v
    - Concaténer plus court chemin C1 de u vers v et C2 de v vers w
*)

(* I.7 *)
(*Un BFS part de u, un autre part de v*)
