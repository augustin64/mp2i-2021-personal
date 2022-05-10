(*(M. Bricout) Soit un quadrillage. Il est possible de se déplacer vers la gauche, la droite et le haut.
Il est impossible de revenir sur une case déjà visitée. Soit v(n) le nombres de chemins possibles de longueur n.
1. Calculer v(3)
2. Donner une expression de récurrence sur v(n)
3. Écrire un programme donnant la valeur de v(n)*)
let swap x y =
  let tmp = !x in
  x := !y;
  y := tmp;;

let nb_chemins n =
  let a = ref 1 in
  let b = ref 3 in
  for i=1 to (n-1) do
    a := 2 * !b + !a;
    swap a b;
  done;
  !b;;
  
  
(*(M. Bricout) Écrire un algorithme donnant le nombre de manières de monter
 un escalier de n marches en montant 1 à k marches à la fois*)
let nb_marches k n =
  let tab = Array.make (n+1) 0 in
  tab.(0) <- 1;
  for i=1 to n do
    for j=1 to min k i do
      tab.(i) <- tab.(i) + tab.(i-j)
    done;
  done;
  tab.(n);;
