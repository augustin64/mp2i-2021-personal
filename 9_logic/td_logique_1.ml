(* Exercice 3 - Énigme gastronomique *)
(*
1. xa => xb
2. phi = (xb v xc)^(¬xb v ¬xc)
3. xa v xc
4. xc => xa

| xa | xb | xc | xa => xb | phi | xa v xc | xc => xa |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 0 | 0 | 0 | 1 | 0 | - | - |
| 0 | 0 | 1 | 1 | 1 | 1 | 0 |
| 1 | 1 | 0 | 1 | 1 | 1 | 1 |

Donc A et B mangent un dessert.
 *)

(* Exercice 5 - Système complet logique *)
(* 5.1 *)
(*
NAND a b = ¬x ^ y
NOR  a b = ¬(x v y)
XOR  a b = (a v b)^(¬a v ¬b)
 *)
(* 5.2 *)
(*
Loi de de Morgan:
  x v y = ¬(¬x ^ ¬y)
*)
(* 5.3 *)
(*
¬x = T NAND x = x NAND x

x^y = ¬(x NAND y)
 *)
