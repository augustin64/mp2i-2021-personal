#use "complexes.ml"

(*
(* Méthode avec des tableaux *)
let horner l z =
  let z_out = ref {re=0.;im=0.} in
  let pow = ref {re=1.;im=0.} in
  for i=0 to Array.length l -1 do
    z_out := mult !pow l.(i);
    pow := mult !pow z;
  done;
  !z_out;;*)

let rec horner p x = match p with
  | [] -> zero;
  | e::q -> add e (mult x (horner q x));;

let rec divise l = match l with
  | [] -> ([], [])
  | [e] -> ([e], [])
  | e1::e2::q -> let q1, q2 = divise q in
                  (e1::q1, e2::q2);;

let rec merge l1 l2 = match l1, l2 with
  | e1::q1, e2::q2 -> e1::e2::(merge q1 q2)
  | [], [] -> []
  | _ -> failwith "N'est pas puissance de 2";;

let rec fft p w =
  let q1, q2 = divise p in
  let list = ref (merge (fft q1 (mult w w))
  (List.map (fun x -> mult x w)(fft q2 (mult w w)))) in
    let w_puiss = ref w in
    while !w_puiss.re != 1. do
	  if !w_puiss.im > 0. then ()
      else (
	    list := (horner p !w_puiss)::!list
	  );
      w_puiss := mult !w_puiss w;
	done;
	!list;;

let rec est_puiss2 n = match n with
  | 1 -> true
  | _ -> (n/2)*2 = n && est_puiss2 (n/2);;

let rec puiss2 l = 
  if est_puiss2 (List.length l) then l
  else puiss2 (l @ [{re=0.;im=0.}]);;

let rec taille l = match l with
  | [] -> 0
  | e::q -> 1 + List.length q;;

let completer l = 
    let t = List.length l in
    let rec aux n l1 =
      if n = 0 then l1
      else aux (n-1) ({re=0.;im=0.}::l1) in
    l @ (aux (t-1) []);;

let exp x = 
  (* useless function to simulate complex exp to avoid compiler errors *)
  mult x x;;

let mul_ft l p =
  let l' = completer (puiss2 l) in
  let p' = completer (puiss2 p) in
  let n = float (taille l') in
  let w = exp (mult {im=Float.pi*.2.;re=0.} {re=1./.n;im=0.}) in
  let l_ft = fft l' w in
  let p_ft = fft p' w in
  let rec aux l p = match l, p with
    | [], [] -> []
    | el::l', ep::p' -> (mult el ep)::(aux l' p')
    | _, _ -> failwith "Les polynômes initiaux ne sont pas de la même taille" in
  aux l_ft p_ft;;

let coeff r =
  let n = (taille r)/2 in
  print_int n;
  let rec aux l = match l with
    | [] -> []
    | e::q -> (mult e {im=0.;re=1./.(float n)})::(aux q) in
  aux r;;

let mul_poly p q =
  let r = mul_ft p q in
  let n =  float (taille r) in
  let w = exp (mult {im=Float.pi*.2.;re=0.} {re=1./.n;im=0.}) in
  let r' = fft r w in
  coeff r';;
