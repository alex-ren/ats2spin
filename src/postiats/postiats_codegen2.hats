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
| D2Cdcstdecs _ => "D2Cdcstdecs"
| D2Clocal _ => "D2Clocal"
| D2Cextcode _ => "D2Cextcode"
| D2Cignored _ => "D2Cignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_d2exp_node
  (arg0) =
(
case+ arg0 of
| D2Ecst _ => "D2Ecst"
| D2Evar _ => "D2Evar"
| D2Esym _ => "D2Esym"
| D2Eint _ => "D2Eint"
| D2Eintrep _ => "D2Eintrep"
| D2Echar _ => "D2Echar"
| D2Efloat _ => "D2Efloat"
| D2Estring _ => "D2Estring"
| D2Ei0nt _ => "D2Ei0nt"
| D2Ec0har _ => "D2Ec0har"
| D2Ef0loat _ => "D2Ef0loat"
| D2Es0tring _ => "D2Es0tring"
| D2Eempty _ => "D2Eempty"
| D2Eexp _ => "D2Eexp"
| D2Elet _ => "D2Elet"
| D2Eapplst _ => "D2Eapplst"
| D2Eifopt _ => "D2Eifopt"
| D2Esing _ => "D2Esing"
| D2Elist _ => "D2Elist"
| D2Etup _ => "D2Etup"
| D2Eseq _ => "D2Eseq"
| D2Eselab _ => "D2Eselab"
| D2Elam _ => "D2Elam"
| D2Efix _ => "D2Efix"
| D2Eextfcall _ => "D2Eextfcall"
| D2Eassgn _ => "D2Eassgn"
| D2Eignored _ => "D2Eignored"
)
//
(* ****** ****** *)
