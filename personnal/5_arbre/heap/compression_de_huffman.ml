type 'a tree_huffman = F of 'a | N of 'a tree_huffman * 'a tree_huffman;

let rec read t l = match t with
  | F(a) -> a, l
  | N(r, g) -> match l with
    | e::q when e=0 -> read r q
    | e::q -> read g q
    | [] -> failwith "Pas de lettre à cet emplacement";;

let rec decode t l = match l with
| [] -> []
| _ -> let a, q = read t l in
        a::(read t q);;
