type 'a binary_tree =
    | E (* arbre vide *)
    | N of 'a * 'a binary_tree * 'a binary_tree;;

(* renvoie une fp min vide*)
let empty () = E;;

(* vérifie si la fp est vide *)
let is_empty = function
  | E -> true
  | _ -> false;;

let sum x y =
  if x = max_int || y = max_int then max_int
  else x + y;;

(* ajoute un élément dans la fp *)
let rec add q = function
    | (e, u) -> match q with
      | E -> N((e, u), E, E)
      | N(r, g, d) -> match r with
        | (a, b) when e < a -> N((a, b), add g (e, u), d)
        | (a, b) -> N((a, b), g, add d (e, u));;

(* renvoie le plus petit élément de la fp *)
let rec take_min q = match q with
  | N(r, E, d) -> r, d
  | N(r, g, d) -> let e, q' = take_min g in
                  e, N(r, q', d)
  | E -> failwith "Pas de min ?";;

(* charge le fichier en mémoire *)
let load_file () =
    let f = open_in "p081_matrix.txt" in
    let rec read () =
        try (
          let l = input_line f
            |> String.split_on_char ','
            |> Array.of_list
            |> Array.map int_of_string in
          l::read ()
        )
        with End_of_file -> [] in
    read () |> Array.of_list;;

(* renvoie le plus court chemin en utilisant toutes les directions *)
let shortest () =
  let m = load_file () in
  let n = Array.length m in
  let q = ref (empty ()) in
  let dist = Array.make (n*n) max_int in
  q := add !q (m.(0).(0), 0);
  (* renvoie le poids de v dans m *)
  let w u v =
    m.(v mod n).(v / n) in
  (* renvoie la liste des voisins de u *)
  let voisins u =
    let vois = ref [] in
    if u >= n then vois := (u-n)::!vois;
    if (u mod n) > 0 then vois := (u-1)::!vois;
    if (u mod n) < n-1 then vois := (u+1)::!vois;
    if (u/n) < n-1 then vois := (u+n)::!vois;
    !vois in
  (* applique dijkstra sur le tableau *)
  while not (is_empty !q) do
    let tmp', tmp = take_min !q in
    q := tmp;
    let d, u = tmp' in
    if dist.(u) = max_int then (
      dist.(u) <- d;
      List.iter (fun v -> q := add !q (sum d (w u v), v)) (voisins u)
      )
  done;
  let n' = Array.length dist in
  dist.(n'-1);;
