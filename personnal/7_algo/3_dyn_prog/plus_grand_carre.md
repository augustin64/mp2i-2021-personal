# II Plus grand carré dans une matrice
## II.1 
```ocaml
let est_carre m x y k =
	let is = ref true in
	for i=x to x+k-1 do
		for j=y to y+k-1 do
			is := !is && m.(i).(j)=1
		done
	done;
	!is;;
	
```

## II.2 
```ocaml
let contient_carre m k =
	let is = ref false in 
	let n = Array.length m in
	for i=0 to n-k do
		for j=0 to n-k do
			is := !is || est_carre m i j k
		done
	done;
	!is;;

```

## II.3 
```ocaml
let max_carre1 m =
	let c = ref (-1) in
	for k=0 to Array.length m -1 do
		if contient_carre m k then c:= k
	done;
	!c;;

```

## II.4 
O(n³k²) 

