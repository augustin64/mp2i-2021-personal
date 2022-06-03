(* Recherche par dichotomie *)
let dicho t e =
  let n = Array.length t in
  let rec aux i j =
    if i > j then false
    else
      let m = (i+j)/2 in
      if t.(m) = e then true
      else if t.(m) > e then aux i (m-1)
      else aux (m+1) j in
    aux 0 (n-1);;

(* Quicksort *)
let rec split p = function
    | [] -> [], []
    | e::q when e < p -> let q1, q2 = split p q in
                          e::q1, q2
    | e::q -> let q1, q2 = split p q in
              q1, e::q2

let rec concat l1 l2 = match l1 with
    | [] -> l2
    | e::q -> e::(concat q l2)

let rec quicksort l = match l with
    | [] | [_] -> l
    | e::q -> let l1, l2 = split e q in
              concat (quicksort l1) (e::quicksort l2);;