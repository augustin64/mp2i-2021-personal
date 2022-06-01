(* Partie I *)
(* I.1 *)
let identite n =
  let m = Array.make_matrix n n 0 in
  for i=0 to n-1 do
    m.(i).(i) <- 1
  done;
  m;;

(* I.2 *)
let scalaire u v =
  let n = Array.length u in
  let w = Array.make n 0. in
  for i=0 to n-1 do
    w.(i) <- u.(i) *. v.(i)
  done;
  w;;

(* I.3 *)
let mul_possible m1 m2 =
  let m = Array.length m1.(0) in
  let n = Array.length m2 in
  m = n;;

(* I.4 *)
let mul m1 m2 =
  if not (mul_possible m1 m2) then failwith "La multiplication n'est pas possible" else (
    let m, n, p = Array.length m1, Array.length m2, Array.length m2.(0) in
    let m3 = Array.make_matrix m p 0. in
    let acc = ref 0. in
    for i=0 to m-1 do
      for j=0 to p-1 do
        acc := 0.;
        for k=0 to n-1 do
          acc := !acc +. m1.(i).(k) *. m2.(k).(j)
        done;
        m3.(i).(j) <- !acc;
      done;
    done;
    m3
  );;

(* Partie II *)
(* II.1 *)
(*
en posant :
  B1 dans Mnp
  B2 dans Mpq
  B3 dans Mqr

On a une complexité de:
  - n² * p * q² * r pour le parenthèsage à gauche.
  - n * p² * q * r² pour le parenthèsage à droite.
*)

(* II.2 *)
let rec muld = function
  | [] -> failwith "Liste vide" (* supposée non vide dans le sujet *)
  | [m] -> m
  | m::q -> mul m (muld q);;

(* II.3 *)
let mulg ml =
  let rec aux m = function
    | [] -> m
    | e::q -> aux (mul m e) q in
  aux ml;;

(* II.4 *)
let min_mul t =
  let n = Array.length t in
