(*(M. Fortier) MTF (Move-To-Front) est un algorithme de prétraitement permettant une compression plus efficace du texte. Les lettres sont supposées entre a et z.
Initialement, à chaque lettre est associée un code entre 0 et 25: Puis pour chaque lettre de c, on ajoute le codage de c au texte codé et on donne le codage 0 à c (en décalant le codage des autres lettres).
Coder MTF en OCaml *)
let rec pos p l = match l with
  | [] -> failwith "N'est pas dans l'alphabet"
  | e::q when e=p -> q, 0
  | e::q -> let r, m = pos p q in
            e::r, m+1;;

let move_to_front s =
  let n = String.length s in
  let t = Array.make n 0 in
  let rec aux i =
    if i=0 then [25]
    else (25-i)::aux (i-1) in
  let code = ref (aux 25) in
  for i=0 to n-1 do
    let l, m = pos (Char.code s.[i] - Char.code 'a') !code in
    t.(i) <- m; code := (Char.code s.[i] - Char.code 'a')::l
  done;
  t;;

(*(M. Fortier) Soit s une chaîne de 0 et 1. Quelle est le nombre de découpes possibles de s telles que chaque sous-chaîne contienne exactement deux '0' ?
Après avoir déterminé une équation de récurrence, écrire l'algorithme correspondant.
 *)
let decoupes s =
  let n = String.length s in
  let m = ref 1 in
  let j = ref 1 in
  let inter =  ref false in
  for i=0 to n-1 do
    if not !inter then
      if s.[i] = '0' then (
        inter := not !inter;
        m := !m * !j;
        j := 1;
      ) else incr j
    else if s.[i] = '0' then (
        inter := not !inter;
      )
  done;
  m := !m * !j;
  !m;;
