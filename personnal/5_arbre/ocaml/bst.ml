#use "tree.ml"

let rec add e = function
    | E -> N(e, E, E)
    | N(r, g, d) when e < r -> N(r, add e g, d)
    | N(r, g, d) -> N(r, g, add e d);;

let rec del_max = function
    | E -> max_int, E
    | N(r, g, E) -> r, g
    | N(r, g, d) -> let m, d' = del_max d in
                    m, N(r, g, d')

let rec del e = function
    | E -> E
    | N(r, g, d) when e = r -> let m, g' = del_max g in
                                N(m, g', d)
    | N(r, g, d) when e < r -> N(r, del e g, d)
    | N(r, g, d) -> N(r, g, del e d);;
