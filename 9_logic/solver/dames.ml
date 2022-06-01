let dames n =
    let f = open_out "dames.cnf" in
    Printf.fprintf f "p cnf 0 0\n";
    (*Au moins un par ligne*)
    for i=0 to n-1 do
        for j=1 to n do
            Printf.fprintf f "%d " (i*n+j);
        done;
        Printf.fprintf f "0\n";
    done;
    (*Au max un par ligne*)
    for i=0 to n-1 do
        for j1=1 to n do
            for j2=1 to n do
                if j1 <> j2 then Printf.fprintf f "-%d -%d 0\n" (i*n+j1) (i*n+j2);
            done;
        done;
    done;
    (*Au max un par colonne*)
    for j=1 to n do
        for i1=0 to n-1 do
            for i2=0 to n-1 do
                if i1 <> i2 then Printf.fprintf f "-%d -%d 0\n" (i1*n+j) (i2*n+j);
            done;
        done;
    done;
    (*Au max un par diagonale*)
    for i1=0 to n-1 do
        for i2=0 to n-1 do
            for j1=1 to n do
                for j2=1 to n do
                    if abs(i1-i2) = abs(j1-j2-2) then Printf.fprintf f "-%d -%d 0\n" (i1*n+j1) (i2*n+j2);
                done;
            done;
        done;
    done;
    flush f;
    close_out f;;


dames 8;;
Sys.command "minisat dames.cnf dames.out; cat dames.out; echo -e '\n\n'; python preview.py"