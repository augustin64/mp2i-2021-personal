type 'a tree_huffman = F of 'a | N of 'a tree_huffman * 'a tree_huffman

type 'a fp = {
  add : 'a -> unit;
  is_empty : unit -> bool;
  take_min : unit -> 'a;
}

type ('k, 'v) dico = {
  get : 'k -> 'v option;
  add : ('k*'v) -> unit;
}

val create : unit -> ('k * 'v) dico (* crée un dico vide *)


let rec read t l = match t with
  | F(a) -> a, l
  | N(r, g) -> match l with
    | e::q when e=0 -> read r q
    | e::q -> read g q
    | [] -> failwith "Pas de lettre à cet emplacement";;


let rec decode t l = match l with
| [] -> []
| _ -> let a, q = read t l in
        a::(decode t q);;


let to_huffman f l =
  let rec remplir = function
    | [] -> ()
    | (f, c)::q -> file.add (f, F(c)); remplir q in
  remplir l;
  let rec retire () =
    if not f.is_empty () then
    let f1, a1 = f.take_min () in
        if f.is_empty () then
          f.add (f1, a1)
        else
          let f2, a2 = f.take_min () in
          f.add (f1+f2, N(a1, a2)) in
  retire ();
  f;;


let to_dico arb =
  let d = create () in
  let rec ajouter a p = match a with
    | F(c) -> d.add (c, List.rev p)
    | N(g, r) -> ajouter g (0::p);
                ajouter r (1::p) in
  ajouter arb [];
  d;;


let rec encoder d t = match t with
  | [] -> []
  | e::q -> let v = get e in
  match v with
    | None -> encoder d q
    | Some(a) -> a@(encoder d q)
