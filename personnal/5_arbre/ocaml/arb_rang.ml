type 'a arb_rang = E | N of 'a * 'a arb_rang * 'a arb_rang * int;;


let rec add e = function
    | E -> N(e, E, E, 1)
    | N(r, g, d, s) when r >= e -> N(r, add e g, d, s+1)
    | N(r, g, d, s) -> N(r, g, add e d, s+1);;


let sz = function
    | N(_, _, _, s) -> s
    | E -> 0;;


let value = function
    | N(r, _, _, _) -> r
    | E -> failwith "Pas de valeur";;


let gauche = function
    | N(_, g, _, _) -> g
    | E -> failwith "Pas de branche gauche";;


let droit = function
    | N(_, _, d, _) -> d
    | E -> failwith "Pas de branche droite";;


let rec merge g d = match g with
    | N(r, g', d', s) -> N(r, g', merge d' d, s+(sz d))
    | E -> d


let rec get k = function
    | E -> failwith "Pas de k-ième élément"
    | N(r, g, d, _) -> let size_g = sz g in
                    if size_g = (k - 1) then r
                    else if size_g >= k then get k g
                    else get (k - size_g - 1) d;;


let rec del k = function
    | E -> failwith "Pas de k-ième élément"
    | N(r, g, d, s) -> let size_g = sz g in 
                    if size_g = (k - 1) then merge g d
                    else if size_g >= k then N(r, del k g, d, s-1)
                    else N(r, g, del (k - size_g - 1) d, s-1);;
