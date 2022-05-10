type ('v, 'w) g = {
	n: () ->  n
	edges: () -> ('v, 'v) list;
	add_edge: 'v -> 'v -> ();
	del_edge: 'v -> 'v -> ();
	edge: 'v -> 'v -> bool;
	w: 'v -> 'v -> 'w;
	adj: 'v -> 'v list;
}

let kruskal g = 
	let uf = create () in 
	let rec aux = function
		| [] -> []
		| (u, v)::q  when find uf u = find uf v -> aux q 
		| (u, v)::q -> (union uf u v; (u,v):(aux q)) in
	g.edges 
	|> List.sort ( fun e f -> g.w e -  g.w f)
	|> aux;;

let prim g = 
	let pq = create_pq () in
	let rec aux =  function
		| [] -> ()
		| v::q -> add_pq pq (g.w 0 v, 0, v); aux q in
	aux (g.adj 0);
	let rec aux2 () = 
		let (w, u, v) = take_min_pq pq in (* poids, , sommet *)
		if not seen.(v) then (
			seen.(v) <- true;
			(u, v)::aux2);;
