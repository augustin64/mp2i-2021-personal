type mot = int list;;

(* I Préliminaires sur les mots *)
(* I.1 *)
let rec longueurMot = function
  | [] -> 0
  | e::q -> 1 + (longueurMot q);;

(* I.2 *)
let rec iemeCar n s = match s with
  | [] -> failwith "empty"
  | e::q -> if n=0 then e else iemeCar (n-1) q;;

(* I.3 *)
let rec prefixe n s = match s with
  | _ when n=0 -> []
  | e::q -> e::(prefixe (n-1) q)
  | [] -> failwith "n'existe pas";;

(* I.4 *)
let rec suffixe n s = match s with
  | [] -> []
  | e::q -> if n=0 then e::q
            else suffixe (n-1) q;;

(* II Opérations sur les cordes *)
type corde =
  | Vide
  | Feuille of int*mot
  | Noeud of int*corde*corde

(* II.5 *)
let longueur = function
  | Vide -> 0
  | Feuille(n, _) | Noeud(n, _, _) -> n;;

(* II.6 *)
let nouvelleCorde l = 
  let n = longueurMot l in
  if n = 0 then Vide
  else Feuille(n, l);;

(* II.7 *)
let concat c1 c2 = match c1, c2 with
  | Vide, _ -> c2
  | _, Vide -> c1
  | _, _ -> Noeud(longueur c1 + longueur c2, c1, c2);;
