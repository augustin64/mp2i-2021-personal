#use "tree.ml"

let rec prefix acc = function
    | E -> acc
    | N(r, g, d) -> r::prefix (prefix acc d) g;;

let rec infix = function
    | E -> []
    | N(r, g, d) -> (infix g)@(r::infix d);;

let rec suffix = function
    | E -> []
    | N(r, g, d) -> (suffix g)@(suffix d)@[r];;

let bfs a =
    let rec aux cur next = match cur with
        | [] -> if next = [] then [] else aux next []
        | e::q -> match e with
            | E -> aux q next
            | N(r, g, d) -> r::aux q (g::d::next) in
    aux [a] [];;

let rec reconstruct pre inf =
    if Array.length pre = 0 then E else (
        let r = pre.(0) in
        let g_s = ref 0 in
        while inf.(!g_s) <> r do
            incr g_s
        done;
        let g_inf = Array.make (!g_s + 1) 0 in
        let g_pre = Array.make (!g_s + 1) 0 in
        for i=0 to !g_s do
            g_pre.(i) <- pre.(i + 1);
            g_inf.(i) <- inf.(i);
        done;
        let d_inf = Array.make (Array.length pre -1 - !g_s) 0 in
        let d_pre = Array.make (Array.length pre -1 - !g_s) 0 in
        for i=(!g_s + 1) to (Array.length pre) do
            d_inf.(i) <- inf.(i);
            d_pre.(i) <- pre.(i);
        done;
        N(r, (reconstruct g_pre g_inf), (reconstruct d_pre d_inf)));;

let croissant l =
    let rec aux = function
        | [] -> true, max_int
        | e::q -> let v, prec = aux q in
                (e <= prec && v), e in
    let verif, last = aux l in verif;;
