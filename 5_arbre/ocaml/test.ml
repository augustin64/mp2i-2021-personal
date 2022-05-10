#use "draw_avl.ml";;


let rec test a n =
    if n=0 then a 
    else
    (
    print_newline;
    print_int n;
  	let b = add n (test a (n-1)) in
  	avl_to_tex ~file_out:(string_of_int n) b;
    b);;
