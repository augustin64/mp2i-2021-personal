#use "module.ml"

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


let get_ht d k =
  let h = d.hash k in
  let rec aux = function
    | [] -> None
    | (k', v)::q when k=k' -> Some v
    | _::q -> aux q in
  aux d.values.(h);;


let add_ht d (k, v) =
  let h = d.hash k in
  match get_ht d k with
    | None -> d.values.(h) <- (k, v)::d.values.(h)
    | Some v' -> d.values.(h) <- replace (k, v') (k, v) d.values.(h);;

(* Arbres *)
type 'a arb = E | N of 'a * 'a arb * 'a arb;;


let rec infixe = function
  | E -> []
  | N(r, g, d) -> (infixe g)@[r]@(infixe d);;


let rec del_max = function
  | E -> E, -1
  | N(r, g, E) -> g, r
  | N(r, g, d) -> let d', m = del_max d in
                  N(r, g, d'), m;;


let rec del_arb e = function
  | E -> failwith "L'élément n'existe pas."
  | N(r, g, d) when r=e -> let g', m = del_max g in
                            N(m, g', d)
  | N(r, g, d) when r > e -> N(r, del_arb e g, d)
  | N(r, g, d) -> N(r, g, del_arb e d);;


let rec add_arb e = function
  | E -> N(e, E, E)
  | N(r, g, d) when r=e -> N(r,  N(r, g, E), d)
  | N(r, g, d) when r<e -> N(r, g, add_arb e d)
  | N(r, g, d) -> N(r, add_arb e g, d);;


let rec list_to_arb = function
  | [] -> E
  | e::q -> add_arb e (list_to_arb q);;


let arb_sort l = list_to_arb l |> infixe;;

(* Graphes *)
let dfs g r =
    let n = Array.length g in
    let vus = Array.make n false in
    let rec aux u =
      if not vus.(u) then (
        vus.(u) <- true;
        List.iter aux g.(u)
      ) in
    aux r;;


let bfs g r =
    let n = Array.length g in
    let q = ref Bst.empty in
    let vus = Array.make n false in
    let add v =
      if not vus.(v) then (vus.(v) <- true; q := Bst.add v !q) in
    add r;
    while not (Bst.is_empty !q) do
      let u = Bst.peek_min !q in
      q := Bst.take_min !q;
      List.iter add (g.(u))
    done;;