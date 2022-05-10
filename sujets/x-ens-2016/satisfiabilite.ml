(* I Préliminaires *)
type formule =
  | Var of int
  | Non of formule
  | Et of formule * formule
  | Ou of formule * formule

(* I.1 *)
(*
a) Non
b) Oui
c) Oui
d) Non
*)

type litteral =
  | V of int (* variable *)
  | NV of int;; (* négation de variable *)
type clause = litteral list;;
type fnc = clause list;;

(* I.2 *)
let rec var_max f = match f with
  | [] -> min_int
  | c::q -> let rec aux_clause = function
      | [] -> min_int
      | (V x)::q' | (NV x)::q' -> max x (aux_clause q') in
  max (aux_clause c) (var_max q);;

(* I.3 *)
type trileen =
  | Vrai
  | Faux
  | Indetermine;;

let un_sat f =
  let t = Array.make ( 1 + var_max f ) Indetermine in
  let rec aux = function
    | [] -> true
    | [V x]::q  -> if t.(x) = Faux then false else (t.(x) <- Vrai; aux q)
    | [NV x]::q -> if t.(x) = Vrai then false else (t.(x) <- Faux; aux q)
    | _ -> failwith "not 1SAT" in
  aux f;;

(* II Résolution de 2-SAT *)
(* II.1 Recherche de composantes fortement connexes dans un graphe orienté *)
let dfs_tri g =
  let deja_vu = Array.make (Array.length g) false in
  let resultat = ref [] in
  let rec dfs_rec i =
    if not deja_vu.(i) then begin
      deja_vu.(i) <- true;
      List.iter dfs_rec g.(i);
      resultat := i::!resultat;
    end in
  for i=0 to Array.length g -1 do
    dfs_rec i
  done;
  !resultat;;

(* II.1.5 *)
let renverser g =
  let n = Array.length g in
  let t = Array.make n [] in
  for i=0 to n-1 do
    List.iter (fun v -> t.(v) <- i::t.(v)) g.(i)
  done;
  t;;

(* II.1.6 *)
let rec dfs_cfc g l =
  let deja_vu = Array.make (Array.length g) false in
  let dfs g v =
    let resultat = ref [] in
    let rec dfs_rec i =
      if not deja_vu.(i) then (
        deja_vu.(i) <- true;
        List.iter dfs_rec g.(i);
        resultat := i::!resultat;
      ) in
    dfs_rec v;
    !resultat in
  List.map (dfs g) l
  |> List.filter ((<>) []);;

(* II.1.7 *)
let cfc g =
  let l = dfs_tri g in
  let g' = renverser g in
  dfs_cfc g' l;;

(* II.1.8 *)
(*
On note C1 <= C2 si C1 est subordonné à C2

Réflexif :
  Il existe un chemin un chemin C ~> C
  Donc C <= C

Transitif :
  c1 = C1 ~> C2 et c2 = C2 ~> C3
  Soit v1 la fin de c1
  Soit v2 la fin de c2
  Donc il existe un chemin c3 = v1 ~> v2 dans C2
  c1 + c2 + c3 est un chemin de C1 vers C3
  donc C1 <= C3
*)

(* II.2 Des composantes fortement connexes à 2-SAT *)
(* II.2.12 *)

(* II.2.13 *)
let deux_sat_vers_graphe f =
  let n = var_max f + 1 in (* nb de variables *)
  let g = Array.make (2*n) [] in
  let rec aux f = match f with
    | [] -> ()
    | e::q -> (match e with
      | [V  i] -> g.(2*i+1) <- 2 * i::g.(2*i+1)
      | [NV i] -> g.( 2*i ) <- 2*i+1::g.( 2*i )
      | [V i; V j]-> if i <> j then (
          g.(2*i+1) <- (2*j)::g.(2*i+1);
          g.(2*j+1) <- (2*i)::g.(2*j+1)
        )
      | [V i; NV j] -> if i <> j then (
        g.(2*i+1) <- (2*j+1)::g.(2*i+1);
        g.( 2*j ) <- ( 2*i )::g.( 2*j )
        )
      | [NV i; NV j] -> if i <> j then (
          g.( 2*i ) <- (2*j+1)::g.( 2*i );
          g.( 2*j ) <- (2*i+1)::g.( 2*j )
        )
      | [NV i; V j] -> if i <> j then (
          g.( 2*i ) <- ( 2*j )::g.( 2*i );
          g.(2*j+1) <- (2*i+1)::g.(2*j+1)
        )
      | _ -> ());
      aux q in
  aux f;
  g;;

(* II.2.16 *)
let deux_sat f =
  let g = deux_sat_vers_graphe f in
  let n = Array.length g in
  let rec sat ccs = match ccs with
  | [] -> true
  | cc::q -> let tab = Array.make n false in
    let rec sat_cc = function
      | [] -> true
      | v::qcc -> if v mod 2 = 0 && tab.(v+1) then false
                else if v mod 2 = 1 && tab.(v-1) then false
                else (tab.(v) <- true; sat_cc qcc) in
      sat_cc cc && sat q in
  deux_sat_vers_graphe f |> cfc |> sat;;

(* III Résolution de k-SAT pour k arbitraire *)
(* III.17 *)
let et a b = match a, b with
  | Faux, _ | _, Faux -> Faux
  | Vrai, Vrai -> Vrai
  | _ -> Indetermine;;

let non = function
  | Vrai -> Faux
  | Faux -> Vrai
  | Indetermine -> Indetermine;;

let ou a b = match a, b with
  | Vrai, _ | _, Vrai -> Vrai
  | Faux, Faux -> Faux
  | _ -> Indetermine;;

(* III.18 *)
let rec eval_clause v = function
  | [] -> Faux
  | (V  x)::q -> ou v.(x) (eval_clause v q)
  | (NV x)::q -> ou (non v.(x)) (eval_clause v q);;

let rec eval f v = match f with
  | [] -> Vrai
  | c::q -> et (eval_clause v c) (eval q v);;
