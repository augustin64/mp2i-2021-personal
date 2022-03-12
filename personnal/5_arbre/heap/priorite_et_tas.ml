type 'a heap = { a: 'a array; mutable n : int };

type 'a tree = E | N of 'a * 'a tree * 'a tree;

type 'a fp = {
  add : 'a -> unit;
  is_empty : unit -> bool;
  take_min : unit -> a;
}


(* I.3 : conversion d'un tas en arbre *)
let heap_to_tree h =
  let rec aux i = (* Renvoie l'arbre enracîné en h.a.(i) *)
    if i >= h.n then E
    else N(h.a.(i), aux 2*i+1, aux 2*i+2) in
  aux 0;;


(* I.5: Fusion de k listes triées en O(n log k) *)
let kfusion ll = 
  let file = create () in
  let rec remplir = function
    | [] -> ()
    | e::q -> file.add e; remplir q in
  remplir ll;
  let rec extract () =
    if file.is_empty () then []
    else match file.take_min () with
      | [] -> ()
      | e::q -> e::(extract q)
  extract ();;


(* Seconde méthode de fusion de k listes triées*)
let rec divise = function
  | [] -> [], []
  | [l] -> [l], []
  | l1::l2::q -> let ll1, ll2 = divise q in
                  l1::ll1, l2::ll2;;

let rec fusion l1 l2 = match l1, l2 with
  | [], _ -> l2
  | _, [] -> l1
  | e1::q1, e2::q2 -> if e1 < e2 then e1::(fusion q1 l2)
                      else e2::(fusion l1 q2);;

let rec kfusion2 = function
  | [] -> []
  | [l] -> l
  | ll -> let ll1, ll2 = divise ll in
          fusion (kfusion2 ll1) (kfusion2 ll2);;
