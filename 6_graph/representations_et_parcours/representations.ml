type 'a arb = N of 'a * 'a arb list


let trou_noir m =
  let i = ref 0 in
  for j=0 to Array.length m-1 do
    if m.(!i).(j) = 1
    then i := j
  done;
  !i;;


let rec to_arb tf i = (* to_arb tf i est l'arbre de racine i *)
  N(i, List.map (to_arb tf) tf.(i));;


let fils t =
  let n = Array.length t in
  let tf = Array.make n [] in
  for i=0 to n-1 do
    if t.(i) <> i then
      tf.(t.(i)) <- i::tf.(t.(i))
  done;
  tf;;


let root t =
  let r = ref 0 in
  for i=0 to Array.length t -1 do
    if t.(i) = i then
      r := i;
  done;
  !r;;


let arb_of_pere t =
  to_arb (fils t) (root t);;

(* I.4 *)
(*On a $\binom{100}{2}$ possibilités*)
