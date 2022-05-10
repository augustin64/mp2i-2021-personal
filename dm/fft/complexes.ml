type complexe = {
  re : float;
  im : float;
}

let conj z = 
  {re = z.re; im = -.z.im};;

let add z1 z2 = 
  {re = z1.re +. z2.re; im = z1.im +. z2.im};;

let mult z1 z2 = 
  let re = z1.re*.z2.re-.z1.im*.z2.im in
  let im = z1.re*.z2.im+.z2.re*.z1.im in
  {re = re; im = im};;

let zero = {
	re=0.;
	im=0.
};;

let un = {
	re=1.;
	im=0.
};;
