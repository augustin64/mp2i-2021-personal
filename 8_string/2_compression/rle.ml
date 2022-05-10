(* Run Length Encoding *)
let rle_code s =
  let ind = ref s.[0] in
  let nb = ref 1 in
  let l = ref [] in
  for i=1 to String.length s -1 do
    if (!ind <> s.[i]) then (
      l := (!ind, !nb)::!l;
      ind := s.[i];
      nb := 1;
    )
    else incr nb
  done;
  List.rev ((!ind, !nb)::!l );;

let rec rle_decode = function
  | [] -> ""
  | (c, n)::q -> (String.make n c)^(rle_decode q);;
