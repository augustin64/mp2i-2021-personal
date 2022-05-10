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
    if i=0 then j
    else if j=0 then i
    else if d.(i).(j) <> -1 then d.(i).(j)
    else if b.(i) = c.(j) then aux (i-1) (j-1)
    else (
      d.(i).(j) <- 1 + min (aux (i-1) j) (min (aux (i-1) (j-1)) (aux i (j-1))); d.(i).(j)
      ) in
  aux (nb-1) (nc-1);;
