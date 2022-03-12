```ocaml
type 'a arb = V | N of 'a * 'a arb * 'a arb

let swap t i j =
  let tmp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- tmp;;

let shuffle t =
  for i = 0 to Array.length t -1 do
    swap t i (Random.int (i+1))
done;;

```



Démonstration question 2:  
  Hn: "il existe un unique arbretas contenant une liste de n couples fixés"  
  H0: E est la seule possibilité  

  Soit n dans N  
  Supposons Hk, Pour tout k <= n  

  Soit l unne liste de n+1 couples  
  Soit (e, p) le couple de l de p min  
  Soit l1 (resp. l2) la liste des couples dont l'élément est < e (resp. >)  

  D'après l'hypothèse de réccurence, il existe une unique façon de choisir  
  g et d arbretas contenant l1 et l2.  

  Donc il existe un unique arbretas contenant l.  





Arbre de la question 3:  

        (2, 2)  
        /     \\  
    (1, 4)    (5, 6)  
      /         /  
  (0, 7)    (3, 8)  



```ocaml
let rotd = function
  | N(r, N(gr, gg, gd), d) -> N(gr, gg, N(r, gd, d))
  | _ -> failwith "Pas de rotation droite possible";;

let rotg = function
  | N(gr, gg, N(r, gd, d)) -> N(r, N(gr, gg, gd), d)
  | _ -> failwith "Pas de rotation gauche possible";;

let prio = function
  | V -> max_int
  | N((e, p), g, d) -> p;;

let rec add a e = match a with
  | N(r, g, d) when fst r = fst r -> if snd r > snd e
              then N(e, a, V)
              else N(r, N(e, g, V), d)
  | N(r, g, d) when fst r < fst e -> if prio d < snd e 
              then rotg ( N(r, g, add d e) )
              else N(r, g, add d e)
  | N(r, g ,d) -> if prio g < snd e 
              then rotd ( N(r, add g e, d) )
              else N(r, add g e, d)
  | V -> N(e, V, V);;

let rec del a e = match a with
  | N(r, g, d) when e < fst r -> N(r, del g e, d)
  | N(r, g, d) when e > fst r -> N(r, g, del d e)
  | N(r, V , V) -> V
  | N(r, g, d) -> if prio g < prio d
                  then del (rotd a) e
                  else del (rotg a) e
  | V -> V;;

```
