#!/usr/bin/ocaml
let swap t i j =
  let tmp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- tmp;;

let shuffle t =
  for i = 0 to Array.length t -1 do
    swap t i j (Random.int (i+1))
done;;

(*

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

*)

(*

Arbre de la question 3:

        (2, 2)
        /     \
    (1, 4)    (5, 6)
      /         /
  (0, 7)    (3, 8)

*)
