#use "tree.ml"

let rec somme = function
    | N(r, g, d) -> r + (somme g) + (somme d)
    | E -> 0;;

let rec appartient e = function
    | N(r, g, d) when r = e -> true
    | N(r, g, d) -> appartient e g || appartient e d
    | E -> false;;

let rec egal t1 t2 = match t1, t2 with
    | E, E -> true
    | N(r, g, d), N(r', g', d') -> r=r' && egal g g' && egal d d'
    | _ -> false;;
