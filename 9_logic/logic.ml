type 'a formula =
    | T | F
    | Var of 'a
    | Not of 'a formula
    | And of 'a formula * 'a formula
    | Or  of 'a formula * 'a formula
    | Forall of 'a * 'a formula
    | Exists of 'a * 'a formula

exception Return;;

let rec eval d = function
  | T -> true
  | F -> false
  | Var (x) -> d x
  | Not (p) -> not (eval d p)
  | And (p, q) -> (eval d p) && (eval d q)
  | Or (p, q) -> (eval d p) || (eval d q)
  | _ -> true;;

let tautologie p n =
  try for v=0 to Int.shift_left 1 n-1 do
    let d = fun i -> (Int.shift_right v i) mod 2 = 1 in
    if eval d p then raise Return
  done;
  false
  with Return -> true;;

module S = Set.Make(Int);;
let rec var_libre = function
  | T | F -> S.empty
  | Var x -> S.add x S.empty
  | Not f -> var_libre f
  | And (f, g) | Or (f, g) -> S.union (var_libre f) (var_libre g)
  | Exists (x, f) | Forall (x, f) -> S.remove x (var_libre f);;
