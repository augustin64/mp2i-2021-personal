## I.1
La structure de tableau des pères est plus pertinente dans cet exercice car on ne s'intéresse qu'aux pères, pas aux fils ou quoi que ce soit d'autre  

## I.2

      3  
    /   \\     4  
    7   5    /  
  /    /    6  
  0   1      \\  
              2  

```ocaml
type unionfind = {
  a: int array;
  rang: int array;
}


let create n = {
  a = Array.init n (fun x -> x);
  rang = Array.make n 0;
};;


let find (uf:unionfind) i =
  let rec aux j =
    if uf.a.(j) == j then ( uf.a.(i) <- j; j )
    else aux uf.a.(j) in
  aux i;;


let rang uf =(* Calcule le rang à partir d'un tableau de prédecesseurs *)
  let n = Array.length uf in
  let rang = Array.make n 0 in
  let rec aux x acc =
    rang.(x) <- max rang.(x) acc;
    if uf.(x) <> x then 
      aux uf.(x) (acc+1) in
  for k=0 to n-1 do
    aux k 0
  done;
  rang;;


let union uf i j = 
  let ri = find uf i in
  let rj = find uf j in
  if uf.rang.(ri) >= uf.rang.(rj) then (
    uf.a.(rj) <- ri;
    uf.rang.(ri) <- max uf.rang.(ri) (1 + uf.rang.(rj))
  )
  else uf.a.(ri) <- rj;;

```

## I.4
On pourrait utiliser une structure de  
tableau dynamique pour permettre  
d'ajouter des éléments  

Exemple du sujet:  
```ocaml
let pred = [|7; 5; 6; 3; 4; 3; 4; 3|];;
let uf = {a=pred;rang=rang pred};;

```
