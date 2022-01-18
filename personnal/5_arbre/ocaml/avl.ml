type 'a avl = V | N of 'a * 'a avl * 'a avl * int

let ht = function
    | V -> -1
    | N(_, _, _, h) -> h;;

let node r g d =
    N(r, g, d, 1+ max (ht g) (ht d));;

let rotd = function
    | N(r, N(gr, gg, gd, _), d, _) -> node gr gg (node r gd d)
    | _ -> failwith "rotd: Pas de sous arbre gauche";;

let rotg = function
    | N(gr, gg, N(r, gd, d, _), _) -> node r (node gr gg gd) d
    | _ -> failwith "rotg: Pas de sous arbre droit";;

let balance r g d =
    if ht g > ht d +1
    then match g with 
        | N(gr, gg, gd, gh) when ht gg > ht gd -> rotd (node r g d)
        | _ -> rotd (node r (rotg g) d)
    else if ht d > ht g + 1
    then match d with
        | N(dr, dg, dd, dh) when ht dd > ht dg -> rotg (node r g d)
        | _ -> rotg (node r g (rotd d))
    else node r g d;;

let rec add e = function
    | V ->  N(e, V, V, 0)
    | N(r, g, d, _) when e < r -> balance r (add e g) d
    | N(r, g, d, _) -> balance r g (add e d);;

let rec del_max = function
    | V -> min_int V
    | N(r, g, V, _) -> r, g
    | N(r, g, d, _) -> let m, d' = del_max d in
                        m, balance r g d';;

let rec has e t = match t with
    | V -> false
    | N(r, g, d, _) when r = e -> true
    | N(r, g, d, _) when r < e -> has e d
    | N(r, g, d, _) -> has e g;;

let rec del e = function
    | V -> V
    | N(r, g, d, h) when e=r -> if g = V then d
        else let m, g' = del_max g in
            balance m g' d


