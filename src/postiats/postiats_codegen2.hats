(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_d2ecl_node
  (arg0) =
(
case+ arg0 of
| D2Cimpdec _ => "D2Cimpdec"
| D2Cfundecs _ => "D2Cfundecs"
| D2Cvaldecs _ => "D2Cvaldecs"
| D2Clocal _ => "D2Clocal"
| D2Cignored _ => "D2Cignored"
)
//
(* ****** ****** *)
