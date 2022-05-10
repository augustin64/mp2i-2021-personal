(* II Plus grand carré dans une matrice *)
(* II.1 *)
let est_carre m x y k =
	let is = ref true in
	for i=x to x+k-1 do
		for j=y to y+k-1 do
			is := !is && m.(i).(j)=1
		done
	done;
	!is;;
	
(* II.2 *)
let contient_carre m k =
	let is = ref false in 
	let n = Array.length m in
	for i=0 to n-k do
		for j=0 to n-k do
			is := !is || est_carre m i j k
		done
	done;
	!is;;

(* II.3 *)
let max_carre1 m =
	let c = ref (-1) in
	for k=0 to Array.length m -1 do
		if contient_carre m k then c:= k
	done;
	!c;;

(* II.4 *)
(* O(n³k²) *)

(* II.5 *)
let init m =
	Array.map Array.copy m;;

(* II.6 *)
(*`c.(x).(y)` vaut alors 0*)

(* II.7 *)
(*
si m.(x).(y) = 1:
	c.(x).(y) = 1 + min c.(x-1).(y) c.(x).(y-1) c.(x-1).(y-1)
*)

(* II.8 *)
let remplir m c =
	let n = Array.length m in
	for i=1 to n-1 do
		for j=1 to n-1 do
			if m.(i).(j) = 1 then
				c.(i).(j) <- 1 + min c.(i).(j-1) (min c.(i-1).(j) c.(i-1).(j-1));
			done;
		done;
		c;;

(* II.9 *)
let max_carre2 m =
	let n = Array.length m in
	let c = init m in
	remplir m c;
	let maxi = ref 0 in
	for i=0 to n-1 do
		for j=0 to n-1 do
			maxi := max !maxi c.(i).(j)
		done;
	done;
	!maxi;;

(* II.10 *)
(*
  O((n-1)(p-1))
= O(np-p-n+1)
= O(np)
Or m est une matrice carrée, donc complexité en `O(n²)`
*)
