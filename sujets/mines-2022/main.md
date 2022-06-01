```ocaml
type mot = char list;;

let array_of_mot w =
  let t = Array.make (List.length w) ' ' in
  let rec aux l n = match l with
    | [] -> ()
    | e::q -> t.(n) <- e; aux q (n+1) in
  aux w 0;
  t;;

let distance b c =
  let b, c = array_of_mot b, array_of_mot c in
  let nb, nc = Array.length b, Array.length c in
  let d = Array.make_matrix nb nc (-1) in
  (* initialisation *)
  let rec aux i j = (* renvoie d(i, j) *)
    if i=-1 then j+1
    else if j=-1 then i+1
    else if d.(i).(j) <> -1 then d.(i).(j)
    else if b.(i) = c.(j) then aux (i-1) (j-1)
    else (
      d.(i).(j) <- 1 + min (aux (i-1) j) (min (aux (i-1) (j-1)) (aux i (j-1))); d.(i).(j)
      ) in
  aux (nb-1) (nc-1);;

module CharMap = Map.Make(Char);;
type trie = Node of trie CharMap.t;;

```

## II.1.13
```ocaml
let trie_vide = Node CharMap.empty;;

let trie_mot_vide = Node (CharMap.add '$' trie_vide CharMap.empty);;

```

## II.1.14
```ocaml
let trie_singleton x = Node (CharMap.add x trie_mot_vide CharMap.empty);;

```

## II.1.15
```ocaml
let rec trie_mem (c : char list) (Node tcm) = match c with
  | [] -> CharMap.find_opt '$' tcm <> None
  | e::q -> match CharMap.find_opt e tcm with
          | None -> false
          | Some a -> trie_mem q a;;

```

## II.1.16
```ocaml
let rec trie_add c (Node tcm) = match c with
  | [] -> Node(CharMap.add '$' trie_vide tcm)
  | e::q -> match CharMap.find_opt e tcm with
      | Some a -> trie_add q a
      | None -> Node (CharMap.add e (trie_add q trie_vide) tcm);;

```

## II.1.18
```ocaml
let rec trie_trim (Node tcm:trie) : trie =
  let filtre (x:char) (y:trie) : trie option =
    let y = trie_trim y in
    if y = trie_vide && x <> '$' then None
    else Some y
  in
  Node(CharMap.filter_map filtre tcm);;

```
