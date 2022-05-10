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


let rec merge_naive a1 a2 = match a2 with
    | N(r, E, E) -> add r a1
    | N(r, g, d) -> merge_naive (merge_naive d (add r a1)) g
    | E -> a1;;


let rec merge_inf g d = match d with
    | N(r, g', E) -> N(r, g', d)
    | N(r, g', d') -> N(r, g', merge_inf d' d)
    | E -> failwith "impossible";;


let rec merge_list l1 l2 = match l1, l2 with
    | _, [] -> l1
    | [], _ -> l2
    | e1::q1, e2::q2 when e2 <= e1 -> e2::(merge_list l1 q2)
    | e1::q1, e2::q2 -> e1::(merge_list q1 l2)


let rec infix = function
    | E -> []
    | N(r, g, d) -> (infix g)@(r::infix d);;


let array_to_abr t =
    let a = ref (E) in
    for i=Array.length t -1 downto 0 do
        a := N(t.(i), !a, E)
    done; !a;;


let fusion a1 a2 =
    let l = merge_list (infix a1) (infix a2) in
    array_to_abr (Array.of_list l);;
