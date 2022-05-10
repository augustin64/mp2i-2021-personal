let naive s t =
  let n = String.length s in
  let p = String.length t in
  let verif = ref false in
  for i=0 to n-p do
    verif := !verif || (String.sub s i p) = t
  done;
  !verif;;


let hash b q s =
  let rec aux i p =
    if i = -1 then 0
    else ((Char.code s.[i])*p + aux (i-1) ((p * b) mod q)) mod q in
  aux (String.length s - 1) 1;;


let rec pow a n q = match n with
  | 0 -> 1
  | 1 -> a
  | n -> 
    let b = pow a (n / 2) q in
    (b * b * (if n mod 2 = 0 then 1 else a)) mod q;;


let rabin_karp text w =
  let k, n = String.length w, String.length text in
  let q = 3719 in (* prime number for modulo *)
  let b = 256 in (* number of characters (basis) *)
  let p = pow b (k - 1) q in (* maximum power of b *)
  let h_w = hash b q w in
  let rec search i h =
    if h = h_w && w = String.sub text i k then true
    else if i >= n - k then false
    else let h_ = (b*(h - p*Char.code text.[i]) + Char.code text.[i + k]) mod q in
      search (i + 1) (if h_ >= 0 then h_  else h_ + q) in
  search 0 (hash b q (String.sub text 0 k));;


let benchmark f file w v =
  let file = open_in file in
  let rec read () =
      try let l = input_line file in l^(read ())
      with End_of_file -> "" in
  let file = read () in
  let t = Sys.time () in
  (* Format.printf "%s@." (read ()): *)
  assert (f file w = v);
  Sys.time() -. t;;
