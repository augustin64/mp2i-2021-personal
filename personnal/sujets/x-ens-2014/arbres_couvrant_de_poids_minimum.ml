(* Partie I. Implémentation des graphes *)
let liste_aretes t =
  let n = Array.length t in
  let ar = ref [] in
  for i=0 to n-1 do
    for j=i to n-1 do
      if t.(i).(j) <> 0 then
        ar := (i, j, t.(i).(j))::!ar
    done
  done;
  !ar;;

let rec split = function
  | [] -> [], []
  | [e] -> [e], []
  | e1::e2::q -> let l1, l2 = split q in e1::l1, e2::l2;;

let rec fusion l1 l2 = match l1, l2 with
  | [], l2 -> l2
  | l1, [] -> l1
  | e1::q1, e2::q2 -> let _, _, w1 = e1 in
                      let _, _, w2 = e2 in
                      if w1 < w2 then e1::(fusion q1 l2)
                      else e2::(fusion l1 q2);;

let rec tri = function
  | [] -> []
  | [e] -> [e]
  | l -> let l1, l2 = split l i fusion (tri l1) (tri l2);;

let liste_aretes_triees m =
  tri (liste_aretes m);;

(* Partie II. Préliminaires sur les arbres *)
