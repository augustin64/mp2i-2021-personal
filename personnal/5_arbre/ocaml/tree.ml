type 'a binary_tree =
    | E (* arbre vide *)
    | N of 'a * 'a binary_tree * 'a binary_tree;;

let t_ex = N(0,
    N(1, 
        N(2, E, E), 
        N(3, N(4, E, E), E)),
    N(5,
        N(6, E, E),
        N(7, E, E)));;

let rec diametre t = match t with
    | E -> -1, -1
    | N(_, g, d) -> let dg, hg = diametre g in
                    let dd, hd = diametre d in
                    max (max dg dd) (hg + hd + 2), 1 + max hg hd;;

let rec add e = function
    | E -> N(e, E, E)
    | N(r, g, d) when e < r -> N(r, add e g, d)
    | N(r, g, d) -> N(r, g, add e d);;
