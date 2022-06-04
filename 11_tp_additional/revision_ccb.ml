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

(* Dictionnaire par table de hachage *)
type ('a, 'b) dict = {hash: 'a -> int; values: ('a * 'b) list array};;

let create_dict n = {
    hash=(fun a -> a mod n);
    values=Array.make n []
  };;


let rec replace a b = function
    | [] -> [b]
    | e::q when a=e -> b::q
    | e::q  -> e::(replace b a q);;


let get d k =
  let h = d.hash k in
  let rec aux = function
    | [] -> None
    | (k', v)::q when k=k' -> Some v
    | _::q -> aux q in
  aux d.values.(h);;


let add d (k, v) =
  let h = d.hash k in
  match get d k with
    | None -> d.values.(h) <- (k, v)::d.values.(h)
    | Some v' -> d.values.(h) <- replace (k, v') (k, v) d.values.(h);;
