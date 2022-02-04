type 'v graph = { (* 'v est le type des sommets *)
  add_edge : 'v -> 'v -> unit;
  del_edge : 'v -> 'v -> unit;
  edge : 'v -> 'v -> bool;
  n : int; (* nombre de sommets *)
  adj : 'v -> 'v list; (* liste des sommets adjacents *)
  (* add_vertex : 'v -> unit; *)
}

let create_adj_graph n =
  let m = Array.make_matrix n n 0 in {
    add_edge = (fun u v -> m.(u).(v) <- 1);
    del_edge = (fun u v -> m.(u).(v) <- 0);
    edge = (fun u v -> m.(u).(v) = 1);
    n = n;
    adj = (fun u ->
      let rec aux v =
        if v = n then []
        else if m.(u).(v) = 1 then v::aux (v + 1)
        else aux (v + 1) in
      aux 0
    )
  }

let mat_to_list m =
  let n = Array.length m in
  let t = Array.make n [] in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      if m.(i).(j) = 1 then
        t.(i) <- j::t.(i)
      done
  done;
  t;;

let list_to_mat t =
  let n = Array.length t in
  let m = Array.make_matrix n n 0 in
  for i = 0 to n - 1 do
    List.iter (fun j -> m.(i).(j) <- 1) t.(i);
  done;
  m;;
