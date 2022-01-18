let mul_poly_naive p q =
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
  r;;
