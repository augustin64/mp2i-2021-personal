let rec post_dfs_array g vu r =
	let dfs = ref [r] in
	vu.(r) <- 1;
	for i=0 to Array.length g -1 do
		if g.(r).(i) == 1 && vu.(i) == 0 then
			dfs := ((post_dfs_array g vu i)) @ !dfs;
	done;
	!dfs;;

let mat = [|
	[|0;0;0;0;1;1;0;0;0|];
	[|1;0;0;0;0;0;0;0;0|];
	[|0;0;0;0;0;0;1;0;0|];
	[|1;1;0;0;0;0;0;0;1|];
	[|0;1;0;0;0;0;0;0;0|];
	[|0;1;0;0;0;0;1;0;0|];
	[|0;0;1;0;0;0;0;0;0|];
	[|0;0;0;1;0;0;0;0;0|];
	[|0;0;0;0;0;0;0;1;0|]
|];;

let rec post_dfs g vu r =
	if vu.(r) then []
	else ( vu.(r) <- true;
				(List.map (post_dfs g vu) g.(r)
				|> List.concat)
				@ [r]
	);;

(* 3.
		Supposons que (vi, vj) soit un arc
		( i>j veut dire que l'appel récursif sur vi
		se termine après celui de vj )

		1) Si vi a été visité avant vj,
			alors l'appel récursif sur vi fait un appel sur vj


*)
