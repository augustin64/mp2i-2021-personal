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

(* Question 3)
   - Cas 1: u et v sont dans des composantes connexes différentes:

     Soit U (resp. V) composante connexe de u (resp. v)

     alors UuV est connexe: en effet si x ∈ U, y ∈ V

     alors  x~u (car U est connexe)
            y~v (car V est connexe)

     Donc il existe un chemin de x à u auquel on ajoute l'arête {u,v}
     puis un chemin de v vers y, ce qui donne un
     chemin entre x et y

     -> UuV est maximal pour C
     Sinon, il existe W connexe dans G+uv tel que UuV est inclus strictement dans W
     Il existe w∈W\UuV
     Comme W est connexe, si x∈UuV alors
     il existe un chemin C de w à x.
     Soit y le 1er sommet de UuV le long de C.

     Soit C' la partie de C entre w et y
     C' n'utilise pas uv donc est un chemin dans G

     Donc w et y étaient dans la même CC dans G

     Ce qui est absurde par maximalité de U et de V.
     Donc G+uv possède une CC de moins


     Si il existe un cycle contenant uv dans G+uv
     Alors C auquel on enlève uv est un chemin de u à v dans G
     Donc u et v sont dans la même CC, ce qui est absurde.

   - Cas 2: u et v sont dans la même composante connexe X:
     Ajouter uv ne change pas le nombre de CC
     De plus, il y a un chemin C de u à v dans G,
     qui forme un cycle en ajoutant uv
 *)

(* Question 5)
   Récurrence ou parcours (dfs, bfs)
*)
