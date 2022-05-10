```ocaml
let load_file () =
    let f = open_in "p081_matrix.txt" in
    let rec read () =
        try (
          let l = input_line f
            |> String.split_on_char ','
            |> Array.of_list
            |> Array.map int_of_string in
          l::read ()
        )
        with End_of_file -> [] in
    read () |> Array.of_list;;


let shortest () =
  let m = load_file () in
  let n = Array.length m in
  let s = Array.map Array.copy m in
  for i=1 to n-1 do 
    s.(0).(i) <- s.(0).(i-1) + m.(0).(i);
    s.(i).(0) <- s.(i-1).(0) + m.(i).(0)
  done;
  for i=1 to n-1 do
    for j=1 to n-1 do
      s.(i).(j) <- (min s.(i).(j-1) s.(i-1).(j)) + m.(i).(j)
    done;
  done;
  s.(n-1).(n-1);;

```
