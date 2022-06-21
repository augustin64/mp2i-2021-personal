let rec min_tournoi t i j =
  if i = j then t.(i), []
  else
    let m = (i + j)/2 in
    let m1, l1 = min_tournoi t i m in
    let m2, l2 = min_tournoi t (m + 1) j in
    if m1 < m2 then m1, m2::l1
    else m2, m1::l2;;
