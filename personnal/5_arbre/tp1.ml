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


