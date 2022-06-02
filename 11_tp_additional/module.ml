module Polynome = struct (* Polynome est un module *)
    let deg p = (* deg p renvoie le degré du polynôme représenté par la liste p *)
        1 + List.length p
    let rec add p1 p2 = match p1, p2 with (* add renvoie la liste représentant la somme de deux polynômes *)
        | [], _ -> p2
        | _, [] -> p1
        | c1::q1, c2::q2 -> (c1 +. c2)::add q1 q2
    let mult p1 p2 =
        let p = Array.of_list p1 in
        let q = Array.of_list p2 in
        let np = Array.length p in
        let nq = Array.length q in
        let n = np + nq -1 in
        let r = Array.make n 0. in
        let tmp = ref 0. in
        for k=0 to n-1 do
          tmp := 0.;
          for i=0 to k do
            if (i < np) && ((k-i) < nq) then
              tmp := !tmp +. p.(i) *. q.(k-i)
            else ();
          done;
          r.(k) <- !tmp;
        done;
        Array.to_list r
end


module type Anneau = sig
  type t (* type des éléments du groupe *)
  val neutre_somme : t (* élément neutre pour + *)
  val neutre_mult : t (* élément neutre pour * *)
  val somme : t -> t -> t (* + *)
  val mult : t -> t -> t (* * *)
  val somme_inv : t -> t (* inverse additif *)
  val print : t -> unit (* pour afficher une valeur *)
end


type complex = {re: float; im: float};;

module C : Anneau = struct
  type t = complex
  let neutre_somme = {re=0.; im=0.}
  let neutre_mult = {re=1.; im=0.}
  let somme z1 z2 = {re=z1.re +. z2.re; im=z1.im +. z2.im}
  let mult z1 z2 = {re=z1.re*.z2.re -. z1.im*.z2.im; im=z1.re*.z2.im +. z2.re*.z1.im}
  let somme_inv z = {re= -.z.re; im= -.z.im}
  let print z = Format.printf "%0.1f + %0.1fi@." z.re z.im
end


module type PrioQ = sig
  type 'a t (* structure contenant les éléments de la file de priorité *)
  val empty : 'a t (* file de priorité vide *)
  val is_empty : 'a t -> bool (* teste si une file de priorité est vide *)
  val add : 'a -> 'a t -> 'a t (* ajoute un élément à la file de priorité *)
  val peek_min : 'a t -> 'a (* renvoie le minimum de la file de priorité *)
  val take_min : 'a t -> 'a t (* extrait le minimum de la file de priorité *)
end


module Bst : PrioQ = struct
  type 'a t = E | N of 'a * 'a t * 'a t (* type d'arbre binaire *)
  let empty = E
  let is_empty = function
    | N(_, _, _) -> false
    | E -> true
  let rec add e = function
    | E -> N(e, E, E)
    | N(r, g, d) when e < r -> N(r, add e g, d)
    | N(r, g, d) -> N(r, g, add e d)
  let rec peek_min = function
    | E -> failwith "Arbre Vide"
    | N(r, E, _) -> r
    | N(r, g, d) -> peek_min g
  let rec take_min = function
    | E -> failwith "Arbre Vide"
    | N(r, E, d) -> d
    | N(r, g, d) -> N(r, take_min g, d)
end


module Dijkstra (Q : PrioQ) = struct
  let distances g (r:int) = (* renvoie un tableau des distances de r aux sommets de g *)
      let vus = Array.make (Array.length g) max_int in
      let q = ref Q.empty in
      q := Q.add (r, 0) !q;
      while not (Q.is_empty !q) do
        let v, d = Q.peek_min !q in
        q := Q.take_min !q;
        if vus.(v) = max_int then (
          vus.(v) <- d;
          List.iter (fun v ->  q := Q.add (v, d+1) !q)  g.(v)
        )
      done;
      vus
end