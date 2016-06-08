(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_s2rt
  (arg0) =
(
case+ arg0 of
| S2RTbas _ => "S2RTbas"
| S2RTfun _ => "S2RTfun"
| S2RTtup _ => "S2RTtup"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_s2rt$S2RTbas: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTfun: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTtup: $d2ctype(fprint_s2rt<>)
//
(* ****** ****** *)
//
implement{}
fprint_s2rt
  (out, arg0) =
(
case+ arg0 of
| S2RTbas _ => fprint_s2rt$S2RTbas<>(out, arg0)
| S2RTfun _ => fprint_s2rt$S2RTfun<>(out, arg0)
| S2RTtup _ => fprint_s2rt$S2RTtup<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s2rt$sep: (FILEref) -> void
implement{}
fprint_s2rt$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_s2rt$lpar: (FILEref) -> void
implement{}
fprint_s2rt$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_s2rt$rpar: (FILEref) -> void
implement{}
fprint_s2rt$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_s2rt$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_s2rt$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s2rt$S2RTbas$con: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTbas$lpar: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTbas$rpar: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTbas$arg1: $d2ctype(fprint_s2rt<>)
//
implement{}
fprint_s2rt$S2RTbas(out, arg0) = 
{
//
val () = fprint_s2rt$S2RTbas$con<>(out, arg0)
val () = fprint_s2rt$S2RTbas$lpar<>(out, arg0)
val () = fprint_s2rt$S2RTbas$arg1<>(out, arg0)
val () = fprint_s2rt$S2RTbas$rpar<>(out, arg0)
//
}
implement{}
fprint_s2rt$S2RTbas$con(out, _) = fprint(out, "S2RTbas")
implement{}
fprint_s2rt$S2RTbas$lpar(out, _) = fprint_s2rt$lpar(out)
implement{}
fprint_s2rt$S2RTbas$rpar(out, _) = fprint_s2rt$rpar(out)
implement{}
fprint_s2rt$S2RTbas$arg1(out, arg0) =
  let val-S2RTbas(arg1) = arg0 in fprint_s2rt$carg(out, arg1) end
//
extern
fun{}
fprint_s2rt$S2RTfun$con: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTfun$lpar: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTfun$rpar: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTfun$sep1: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTfun$arg1: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTfun$arg2: $d2ctype(fprint_s2rt<>)
//
implement{}
fprint_s2rt$S2RTfun(out, arg0) = 
{
//
val () = fprint_s2rt$S2RTfun$con<>(out, arg0)
val () = fprint_s2rt$S2RTfun$lpar<>(out, arg0)
val () = fprint_s2rt$S2RTfun$arg1<>(out, arg0)
val () = fprint_s2rt$S2RTfun$sep1<>(out, arg0)
val () = fprint_s2rt$S2RTfun$arg2<>(out, arg0)
val () = fprint_s2rt$S2RTfun$rpar<>(out, arg0)
//
}
implement{}
fprint_s2rt$S2RTfun$con(out, _) = fprint(out, "S2RTfun")
implement{}
fprint_s2rt$S2RTfun$lpar(out, _) = fprint_s2rt$lpar(out)
implement{}
fprint_s2rt$S2RTfun$rpar(out, _) = fprint_s2rt$rpar(out)
implement{}
fprint_s2rt$S2RTfun$sep1(out, _) = fprint_s2rt$sep<>(out)
implement{}
fprint_s2rt$S2RTfun$arg1(out, arg0) =
  let val-S2RTfun(arg1, _) = arg0 in fprint_s2rt$carg(out, arg1) end
implement{}
fprint_s2rt$S2RTfun$arg2(out, arg0) =
  let val-S2RTfun(_, arg2) = arg0 in fprint_s2rt$carg(out, arg2) end
//
extern
fun{}
fprint_s2rt$S2RTtup$con: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTtup$lpar: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTtup$rpar: $d2ctype(fprint_s2rt<>)
extern
fun{}
fprint_s2rt$S2RTtup$arg1: $d2ctype(fprint_s2rt<>)
//
implement{}
fprint_s2rt$S2RTtup(out, arg0) = 
{
//
val () = fprint_s2rt$S2RTtup$con<>(out, arg0)
val () = fprint_s2rt$S2RTtup$lpar<>(out, arg0)
val () = fprint_s2rt$S2RTtup$arg1<>(out, arg0)
val () = fprint_s2rt$S2RTtup$rpar<>(out, arg0)
//
}
implement{}
fprint_s2rt$S2RTtup$con(out, _) = fprint(out, "S2RTtup")
implement{}
fprint_s2rt$S2RTtup$lpar(out, _) = fprint_s2rt$lpar(out)
implement{}
fprint_s2rt$S2RTtup$rpar(out, _) = fprint_s2rt$rpar(out)
implement{}
fprint_s2rt$S2RTtup$arg1(out, arg0) =
  let val-S2RTtup(arg1) = arg0 in fprint_s2rt$carg(out, arg1) end
//
(* ****** ****** *)
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
| D2Cvardecs _ => "D2Cvardecs"
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
| D2Eann_type _ => "D2Eann_type"
| D2Elet _ => "D2Elet"
| D2Eapplst _ => "D2Eapplst"
| D2Eifopt _ => "D2Eifopt"
| D2Ecase _ => "D2Ecase"
| D2Esing _ => "D2Esing"
| D2Elist _ => "D2Elist"
| D2Etup _ => "D2Etup"
| D2Eseq _ => "D2Eseq"
| D2Eselab _ => "D2Eselab"
| D2Elam_dyn _ => "D2Elam_dyn"
| D2Elam_sta _ => "D2Elam_sta"
| D2Efix _ => "D2Efix"
| D2Eextfcall _ => "D2Eextfcall"
| D2Eassgn _ => "D2Eassgn"
| D2Eignored _ => "D2Eignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_p2at_node
  (arg0) =
(
case+ arg0 of
| P2Tany _ => "P2Tany"
| P2Tvar _ => "P2Tvar"
| P2Tempty _ => "P2Tempty"
| P2Tann _ => "P2Tann"
| P2Trec _ => "P2Trec"
| P2Tcon _ => "P2Tcon"
| P2Ti0nt _ => "P2Ti0nt"
| P2Tignored _ => "P2Tignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_funkind
  (arg0) =
(
case+ arg0 of
| FK_fn _ => "FK_fn"
| FK_fnx _ => "FK_fnx"
| FK_fun _ => "FK_fun"
| FK_ignored _ => "FK_ignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_valkind
  (arg0) =
(
case+ arg0 of
| VK_val _ => "VK_val"
| VK_val_pos _ => "VK_val_pos"
| VK_val_neg _ => "VK_val_neg"
| VK_ignored _ => "VK_ignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_casekind
  (arg0) =
(
case+ arg0 of
| CK_case_pos _ => "CK_case_pos"
| CK_case_minus _ => "CK_case_minus"
| CK_case_none _ => "CK_case_none"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_d2exp_node$D2Ecst: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Evar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esym: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eint: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eintrep: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Echar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efloat: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Estring: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ei0nt: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ec0har: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ef0loat: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Es0tring: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eempty: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eexp: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eann_type: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elet: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eapplst: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esing: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elist: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eseq: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eselab: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eextfcall: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eassgn: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eignored: $d2ctype(fprint_d2exp_node<>)
//
(* ****** ****** *)
//
implement{}
fprint_d2exp_node
  (out, arg0) =
(
case+ arg0 of
| D2Ecst _ => fprint_d2exp_node$D2Ecst<>(out, arg0)
| D2Evar _ => fprint_d2exp_node$D2Evar<>(out, arg0)
| D2Esym _ => fprint_d2exp_node$D2Esym<>(out, arg0)
| D2Eint _ => fprint_d2exp_node$D2Eint<>(out, arg0)
| D2Eintrep _ => fprint_d2exp_node$D2Eintrep<>(out, arg0)
| D2Echar _ => fprint_d2exp_node$D2Echar<>(out, arg0)
| D2Efloat _ => fprint_d2exp_node$D2Efloat<>(out, arg0)
| D2Estring _ => fprint_d2exp_node$D2Estring<>(out, arg0)
| D2Ei0nt _ => fprint_d2exp_node$D2Ei0nt<>(out, arg0)
| D2Ec0har _ => fprint_d2exp_node$D2Ec0har<>(out, arg0)
| D2Ef0loat _ => fprint_d2exp_node$D2Ef0loat<>(out, arg0)
| D2Es0tring _ => fprint_d2exp_node$D2Es0tring<>(out, arg0)
| D2Eempty _ => fprint_d2exp_node$D2Eempty<>(out, arg0)
| D2Eexp _ => fprint_d2exp_node$D2Eexp<>(out, arg0)
| D2Eann_type _ => fprint_d2exp_node$D2Eann_type<>(out, arg0)
| D2Elet _ => fprint_d2exp_node$D2Elet<>(out, arg0)
| D2Eapplst _ => fprint_d2exp_node$D2Eapplst<>(out, arg0)
| D2Eifopt _ => fprint_d2exp_node$D2Eifopt<>(out, arg0)
| D2Ecase _ => fprint_d2exp_node$D2Ecase<>(out, arg0)
| D2Esing _ => fprint_d2exp_node$D2Esing<>(out, arg0)
| D2Elist _ => fprint_d2exp_node$D2Elist<>(out, arg0)
| D2Etup _ => fprint_d2exp_node$D2Etup<>(out, arg0)
| D2Eseq _ => fprint_d2exp_node$D2Eseq<>(out, arg0)
| D2Eselab _ => fprint_d2exp_node$D2Eselab<>(out, arg0)
| D2Elam_dyn _ => fprint_d2exp_node$D2Elam_dyn<>(out, arg0)
| D2Elam_sta _ => fprint_d2exp_node$D2Elam_sta<>(out, arg0)
| D2Efix _ => fprint_d2exp_node$D2Efix<>(out, arg0)
| D2Eextfcall _ => fprint_d2exp_node$D2Eextfcall<>(out, arg0)
| D2Eassgn _ => fprint_d2exp_node$D2Eassgn<>(out, arg0)
| D2Eignored _ => fprint_d2exp_node$D2Eignored<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_d2exp_node$sep: (FILEref) -> void
implement{}
fprint_d2exp_node$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_d2exp_node$lpar: (FILEref) -> void
implement{}
fprint_d2exp_node$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_d2exp_node$rpar: (FILEref) -> void
implement{}
fprint_d2exp_node$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_d2exp_node$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_d2exp_node$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_d2exp_node$D2Ecst$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecst$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecst$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecst$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Ecst(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Ecst$con<>(out, arg0)
val () = fprint_d2exp_node$D2Ecst$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Ecst$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Ecst$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Ecst$con(out, _) = fprint(out, "D2Ecst")
implement{}
fprint_d2exp_node$D2Ecst$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Ecst$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Ecst$arg1(out, arg0) =
  let val-D2Ecst(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Evar$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Evar$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Evar$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Evar$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Evar(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Evar$con<>(out, arg0)
val () = fprint_d2exp_node$D2Evar$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Evar$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Evar$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Evar$con(out, _) = fprint(out, "D2Evar")
implement{}
fprint_d2exp_node$D2Evar$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Evar$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Evar$arg1(out, arg0) =
  let val-D2Evar(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Esym$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esym$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esym$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esym$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Esym(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Esym$con<>(out, arg0)
val () = fprint_d2exp_node$D2Esym$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Esym$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Esym$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Esym$con(out, _) = fprint(out, "D2Esym")
implement{}
fprint_d2exp_node$D2Esym$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Esym$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Esym$arg1(out, arg0) =
  let val-D2Esym(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Eint$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eint$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eint$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eint$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eint(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eint$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eint$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eint$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eint$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eint$con(out, _) = fprint(out, "D2Eint")
implement{}
fprint_d2exp_node$D2Eint$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eint$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eint$arg1(out, arg0) =
  let val-D2Eint(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Eintrep$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eintrep$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eintrep$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eintrep$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eintrep(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eintrep$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eintrep$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eintrep$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eintrep$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eintrep$con(out, _) = fprint(out, "D2Eintrep")
implement{}
fprint_d2exp_node$D2Eintrep$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eintrep$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eintrep$arg1(out, arg0) =
  let val-D2Eintrep(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Echar$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Echar$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Echar$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Echar$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Echar(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Echar$con<>(out, arg0)
val () = fprint_d2exp_node$D2Echar$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Echar$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Echar$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Echar$con(out, _) = fprint(out, "D2Echar")
implement{}
fprint_d2exp_node$D2Echar$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Echar$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Echar$arg1(out, arg0) =
  let val-D2Echar(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Efloat$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efloat$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efloat$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efloat$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Efloat(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Efloat$con<>(out, arg0)
val () = fprint_d2exp_node$D2Efloat$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Efloat$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Efloat$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Efloat$con(out, _) = fprint(out, "D2Efloat")
implement{}
fprint_d2exp_node$D2Efloat$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Efloat$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Efloat$arg1(out, arg0) =
  let val-D2Efloat(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Estring$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Estring$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Estring$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Estring$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Estring(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Estring$con<>(out, arg0)
val () = fprint_d2exp_node$D2Estring$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Estring$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Estring$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Estring$con(out, _) = fprint(out, "D2Estring")
implement{}
fprint_d2exp_node$D2Estring$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Estring$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Estring$arg1(out, arg0) =
  let val-D2Estring(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Ei0nt$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ei0nt$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ei0nt$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ei0nt$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Ei0nt(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Ei0nt$con<>(out, arg0)
val () = fprint_d2exp_node$D2Ei0nt$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Ei0nt$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Ei0nt$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Ei0nt$con(out, _) = fprint(out, "D2Ei0nt")
implement{}
fprint_d2exp_node$D2Ei0nt$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Ei0nt$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Ei0nt$arg1(out, arg0) =
  let val-D2Ei0nt(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Ec0har$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ec0har$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ec0har$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ec0har$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Ec0har(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Ec0har$con<>(out, arg0)
val () = fprint_d2exp_node$D2Ec0har$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Ec0har$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Ec0har$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Ec0har$con(out, _) = fprint(out, "D2Ec0har")
implement{}
fprint_d2exp_node$D2Ec0har$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Ec0har$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Ec0har$arg1(out, arg0) =
  let val-D2Ec0har(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Ef0loat$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ef0loat$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ef0loat$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ef0loat$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Ef0loat(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Ef0loat$con<>(out, arg0)
val () = fprint_d2exp_node$D2Ef0loat$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Ef0loat$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Ef0loat$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Ef0loat$con(out, _) = fprint(out, "D2Ef0loat")
implement{}
fprint_d2exp_node$D2Ef0loat$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Ef0loat$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Ef0loat$arg1(out, arg0) =
  let val-D2Ef0loat(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Es0tring$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Es0tring$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Es0tring$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Es0tring$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Es0tring(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Es0tring$con<>(out, arg0)
val () = fprint_d2exp_node$D2Es0tring$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Es0tring$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Es0tring$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Es0tring$con(out, _) = fprint(out, "D2Es0tring")
implement{}
fprint_d2exp_node$D2Es0tring$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Es0tring$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Es0tring$arg1(out, arg0) =
  let val-D2Es0tring(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Eempty$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eempty$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eempty$rpar: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eempty(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eempty$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eempty$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eempty$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eempty$con(out, _) = fprint(out, "D2Eempty")
implement{}
fprint_d2exp_node$D2Eempty$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eempty$rpar(out, _) = fprint_d2exp_node$rpar(out)
//
extern
fun{}
fprint_d2exp_node$D2Eexp$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eexp$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eexp$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eexp$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eexp(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eexp$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eexp$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eexp$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eexp$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eexp$con(out, _) = fprint(out, "D2Eexp")
implement{}
fprint_d2exp_node$D2Eexp$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eexp$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eexp$arg1(out, arg0) =
  let val-D2Eexp(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Eann_type$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eann_type$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eann_type$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eann_type$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eann_type$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eann_type$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eann_type(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eann_type$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eann_type$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eann_type$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eann_type$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Eann_type$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Eann_type$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eann_type$con(out, _) = fprint(out, "D2Eann_type")
implement{}
fprint_d2exp_node$D2Eann_type$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eann_type$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eann_type$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eann_type$arg1(out, arg0) =
  let val-D2Eann_type(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Eann_type$arg2(out, arg0) =
  let val-D2Eann_type(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Elet$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elet$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elet$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elet$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elet$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elet$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Elet(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Elet$con<>(out, arg0)
val () = fprint_d2exp_node$D2Elet$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Elet$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Elet$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Elet$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Elet$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Elet$con(out, _) = fprint(out, "D2Elet")
implement{}
fprint_d2exp_node$D2Elet$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Elet$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Elet$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Elet$arg1(out, arg0) =
  let val-D2Elet(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Elet$arg2(out, arg0) =
  let val-D2Elet(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Eapplst$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eapplst$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eapplst$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eapplst$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eapplst$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eapplst$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eapplst(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eapplst$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eapplst$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eapplst$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eapplst$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Eapplst$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Eapplst$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eapplst$con(out, _) = fprint(out, "D2Eapplst")
implement{}
fprint_d2exp_node$D2Eapplst$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eapplst$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eapplst$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eapplst$arg1(out, arg0) =
  let val-D2Eapplst(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Eapplst$arg2(out, arg0) =
  let val-D2Eapplst(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Eifopt$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$sep2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$arg2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eifopt$arg3: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eifopt(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eifopt$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$sep2<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$arg3<>(out, arg0)
val () = fprint_d2exp_node$D2Eifopt$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eifopt$con(out, _) = fprint(out, "D2Eifopt")
implement{}
fprint_d2exp_node$D2Eifopt$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eifopt$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eifopt$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eifopt$sep2(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eifopt$arg1(out, arg0) =
  let val-D2Eifopt(arg1, _, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Eifopt$arg2(out, arg0) =
  let val-D2Eifopt(_, arg2, _) = arg0 in fprint_d2exp_node$carg(out, arg2) end
implement{}
fprint_d2exp_node$D2Eifopt$arg3(out, arg0) =
  let val-D2Eifopt(_, _, arg3) = arg0 in fprint_d2exp_node$carg(out, arg3) end
//
extern
fun{}
fprint_d2exp_node$D2Ecase$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$sep2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$arg2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Ecase$arg3: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Ecase(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Ecase$con<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$sep2<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$arg3<>(out, arg0)
val () = fprint_d2exp_node$D2Ecase$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Ecase$con(out, _) = fprint(out, "D2Ecase")
implement{}
fprint_d2exp_node$D2Ecase$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Ecase$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Ecase$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Ecase$sep2(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Ecase$arg1(out, arg0) =
  let val-D2Ecase(arg1, _, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Ecase$arg2(out, arg0) =
  let val-D2Ecase(_, arg2, _) = arg0 in fprint_d2exp_node$carg(out, arg2) end
implement{}
fprint_d2exp_node$D2Ecase$arg3(out, arg0) =
  let val-D2Ecase(_, _, arg3) = arg0 in fprint_d2exp_node$carg(out, arg3) end
//
extern
fun{}
fprint_d2exp_node$D2Esing$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esing$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esing$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Esing$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Esing(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Esing$con<>(out, arg0)
val () = fprint_d2exp_node$D2Esing$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Esing$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Esing$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Esing$con(out, _) = fprint(out, "D2Esing")
implement{}
fprint_d2exp_node$D2Esing$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Esing$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Esing$arg1(out, arg0) =
  let val-D2Esing(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Elist$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elist$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elist$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elist$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elist$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elist$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Elist(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Elist$con<>(out, arg0)
val () = fprint_d2exp_node$D2Elist$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Elist$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Elist$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Elist$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Elist$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Elist$con(out, _) = fprint(out, "D2Elist")
implement{}
fprint_d2exp_node$D2Elist$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Elist$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Elist$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Elist$arg1(out, arg0) =
  let val-D2Elist(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Elist$arg2(out, arg0) =
  let val-D2Elist(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Etup$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$sep2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$arg2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Etup$arg3: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Etup(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Etup$con<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$sep2<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$arg3<>(out, arg0)
val () = fprint_d2exp_node$D2Etup$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Etup$con(out, _) = fprint(out, "D2Etup")
implement{}
fprint_d2exp_node$D2Etup$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Etup$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Etup$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Etup$sep2(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Etup$arg1(out, arg0) =
  let val-D2Etup(arg1, _, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Etup$arg2(out, arg0) =
  let val-D2Etup(_, arg2, _) = arg0 in fprint_d2exp_node$carg(out, arg2) end
implement{}
fprint_d2exp_node$D2Etup$arg3(out, arg0) =
  let val-D2Etup(_, _, arg3) = arg0 in fprint_d2exp_node$carg(out, arg3) end
//
extern
fun{}
fprint_d2exp_node$D2Eseq$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eseq$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eseq$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eseq$arg1: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eseq(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eseq$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eseq$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eseq$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eseq$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eseq$con(out, _) = fprint(out, "D2Eseq")
implement{}
fprint_d2exp_node$D2Eseq$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eseq$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eseq$arg1(out, arg0) =
  let val-D2Eseq(arg1) = arg0 in fprint_d2exp_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2exp_node$D2Eselab$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eselab$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eselab$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eselab$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eselab$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eselab$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eselab(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eselab$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eselab$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eselab$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eselab$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Eselab$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Eselab$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eselab$con(out, _) = fprint(out, "D2Eselab")
implement{}
fprint_d2exp_node$D2Eselab$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eselab$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eselab$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eselab$arg1(out, arg0) =
  let val-D2Eselab(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Eselab$arg2(out, arg0) =
  let val-D2Eselab(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$sep2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$arg2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_dyn$arg3: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Elam_dyn(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Elam_dyn$con<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$sep2<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$arg3<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_dyn$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Elam_dyn$con(out, _) = fprint(out, "D2Elam_dyn")
implement{}
fprint_d2exp_node$D2Elam_dyn$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Elam_dyn$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Elam_dyn$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Elam_dyn$sep2(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Elam_dyn$arg1(out, arg0) =
  let val-D2Elam_dyn(arg1, _, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Elam_dyn$arg2(out, arg0) =
  let val-D2Elam_dyn(_, arg2, _) = arg0 in fprint_d2exp_node$carg(out, arg2) end
implement{}
fprint_d2exp_node$D2Elam_dyn$arg3(out, arg0) =
  let val-D2Elam_dyn(_, _, arg3) = arg0 in fprint_d2exp_node$carg(out, arg3) end
//
extern
fun{}
fprint_d2exp_node$D2Elam_sta$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$sep2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$arg2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Elam_sta$arg3: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Elam_sta(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Elam_sta$con<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$sep2<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$arg3<>(out, arg0)
val () = fprint_d2exp_node$D2Elam_sta$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Elam_sta$con(out, _) = fprint(out, "D2Elam_sta")
implement{}
fprint_d2exp_node$D2Elam_sta$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Elam_sta$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Elam_sta$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Elam_sta$sep2(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Elam_sta$arg1(out, arg0) =
  let val-D2Elam_sta(arg1, _, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Elam_sta$arg2(out, arg0) =
  let val-D2Elam_sta(_, arg2, _) = arg0 in fprint_d2exp_node$carg(out, arg2) end
implement{}
fprint_d2exp_node$D2Elam_sta$arg3(out, arg0) =
  let val-D2Elam_sta(_, _, arg3) = arg0 in fprint_d2exp_node$carg(out, arg3) end
//
extern
fun{}
fprint_d2exp_node$D2Efix$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$sep2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$arg2: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Efix$arg3: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Efix(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Efix$con<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$sep2<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$arg3<>(out, arg0)
val () = fprint_d2exp_node$D2Efix$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Efix$con(out, _) = fprint(out, "D2Efix")
implement{}
fprint_d2exp_node$D2Efix$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Efix$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Efix$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Efix$sep2(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Efix$arg1(out, arg0) =
  let val-D2Efix(arg1, _, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Efix$arg2(out, arg0) =
  let val-D2Efix(_, arg2, _) = arg0 in fprint_d2exp_node$carg(out, arg2) end
implement{}
fprint_d2exp_node$D2Efix$arg3(out, arg0) =
  let val-D2Efix(_, _, arg3) = arg0 in fprint_d2exp_node$carg(out, arg3) end
//
extern
fun{}
fprint_d2exp_node$D2Eextfcall$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eextfcall$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eextfcall$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eextfcall$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eextfcall$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eextfcall$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eextfcall(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eextfcall$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eextfcall$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eextfcall$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eextfcall$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Eextfcall$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Eextfcall$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eextfcall$con(out, _) = fprint(out, "D2Eextfcall")
implement{}
fprint_d2exp_node$D2Eextfcall$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eextfcall$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eextfcall$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eextfcall$arg1(out, arg0) =
  let val-D2Eextfcall(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Eextfcall$arg2(out, arg0) =
  let val-D2Eextfcall(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Eassgn$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eassgn$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eassgn$rpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eassgn$sep1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eassgn$arg1: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eassgn$arg2: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eassgn(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eassgn$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eassgn$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eassgn$arg1<>(out, arg0)
val () = fprint_d2exp_node$D2Eassgn$sep1<>(out, arg0)
val () = fprint_d2exp_node$D2Eassgn$arg2<>(out, arg0)
val () = fprint_d2exp_node$D2Eassgn$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eassgn$con(out, _) = fprint(out, "D2Eassgn")
implement{}
fprint_d2exp_node$D2Eassgn$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eassgn$rpar(out, _) = fprint_d2exp_node$rpar(out)
implement{}
fprint_d2exp_node$D2Eassgn$sep1(out, _) = fprint_d2exp_node$sep<>(out)
implement{}
fprint_d2exp_node$D2Eassgn$arg1(out, arg0) =
  let val-D2Eassgn(arg1, _) = arg0 in fprint_d2exp_node$carg(out, arg1) end
implement{}
fprint_d2exp_node$D2Eassgn$arg2(out, arg0) =
  let val-D2Eassgn(_, arg2) = arg0 in fprint_d2exp_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2exp_node$D2Eignored$con: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eignored$lpar: $d2ctype(fprint_d2exp_node<>)
extern
fun{}
fprint_d2exp_node$D2Eignored$rpar: $d2ctype(fprint_d2exp_node<>)
//
implement{}
fprint_d2exp_node$D2Eignored(out, arg0) = 
{
//
val () = fprint_d2exp_node$D2Eignored$con<>(out, arg0)
val () = fprint_d2exp_node$D2Eignored$lpar<>(out, arg0)
val () = fprint_d2exp_node$D2Eignored$rpar<>(out, arg0)
//
}
implement{}
fprint_d2exp_node$D2Eignored$con(out, _) = fprint(out, "D2Eignored")
implement{}
fprint_d2exp_node$D2Eignored$lpar(out, _) = fprint_d2exp_node$lpar(out)
implement{}
fprint_d2exp_node$D2Eignored$rpar(out, _) = fprint_d2exp_node$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_d2ecl_node$D2Cimpdec: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cfundecs: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvardecs: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Clocal: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cextcode: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cignored: $d2ctype(fprint_d2ecl_node<>)
//
(* ****** ****** *)
//
implement{}
fprint_d2ecl_node
  (out, arg0) =
(
case+ arg0 of
| D2Cimpdec _ => fprint_d2ecl_node$D2Cimpdec<>(out, arg0)
| D2Cfundecs _ => fprint_d2ecl_node$D2Cfundecs<>(out, arg0)
| D2Cvaldecs _ => fprint_d2ecl_node$D2Cvaldecs<>(out, arg0)
| D2Cvardecs _ => fprint_d2ecl_node$D2Cvardecs<>(out, arg0)
| D2Cdcstdecs _ => fprint_d2ecl_node$D2Cdcstdecs<>(out, arg0)
| D2Clocal _ => fprint_d2ecl_node$D2Clocal<>(out, arg0)
| D2Cextcode _ => fprint_d2ecl_node$D2Cextcode<>(out, arg0)
| D2Cignored _ => fprint_d2ecl_node$D2Cignored<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_d2ecl_node$sep: (FILEref) -> void
implement{}
fprint_d2ecl_node$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_d2ecl_node$lpar: (FILEref) -> void
implement{}
fprint_d2ecl_node$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_d2ecl_node$rpar: (FILEref) -> void
implement{}
fprint_d2ecl_node$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_d2ecl_node$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_d2ecl_node$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_d2ecl_node$D2Cimpdec$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cimpdec$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cimpdec$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cimpdec$sep1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cimpdec$arg1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cimpdec$arg2: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cimpdec(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cimpdec$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cimpdec$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cimpdec$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cimpdec$sep1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cimpdec$arg2<>(out, arg0)
val () = fprint_d2ecl_node$D2Cimpdec$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cimpdec$con(out, _) = fprint(out, "D2Cimpdec")
implement{}
fprint_d2ecl_node$D2Cimpdec$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cimpdec$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Cimpdec$sep1(out, _) = fprint_d2ecl_node$sep<>(out)
implement{}
fprint_d2ecl_node$D2Cimpdec$arg1(out, arg0) =
  let val-D2Cimpdec(arg1, _) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
implement{}
fprint_d2ecl_node$D2Cimpdec$arg2(out, arg0) =
  let val-D2Cimpdec(_, arg2) = arg0 in fprint_d2ecl_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2ecl_node$D2Cfundecs$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cfundecs$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cfundecs$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cfundecs$sep1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cfundecs$arg1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cfundecs$arg2: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cfundecs(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cfundecs$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cfundecs$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cfundecs$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cfundecs$sep1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cfundecs$arg2<>(out, arg0)
val () = fprint_d2ecl_node$D2Cfundecs$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cfundecs$con(out, _) = fprint(out, "D2Cfundecs")
implement{}
fprint_d2ecl_node$D2Cfundecs$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cfundecs$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Cfundecs$sep1(out, _) = fprint_d2ecl_node$sep<>(out)
implement{}
fprint_d2ecl_node$D2Cfundecs$arg1(out, arg0) =
  let val-D2Cfundecs(arg1, _) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
implement{}
fprint_d2ecl_node$D2Cfundecs$arg2(out, arg0) =
  let val-D2Cfundecs(_, arg2) = arg0 in fprint_d2ecl_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs$sep1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs$arg1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvaldecs$arg2: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cvaldecs(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cvaldecs$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvaldecs$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvaldecs$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvaldecs$sep1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvaldecs$arg2<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvaldecs$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cvaldecs$con(out, _) = fprint(out, "D2Cvaldecs")
implement{}
fprint_d2ecl_node$D2Cvaldecs$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cvaldecs$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Cvaldecs$sep1(out, _) = fprint_d2ecl_node$sep<>(out)
implement{}
fprint_d2ecl_node$D2Cvaldecs$arg1(out, arg0) =
  let val-D2Cvaldecs(arg1, _) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
implement{}
fprint_d2ecl_node$D2Cvaldecs$arg2(out, arg0) =
  let val-D2Cvaldecs(_, arg2) = arg0 in fprint_d2ecl_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2ecl_node$D2Cvardecs$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvardecs$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvardecs$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cvardecs$arg1: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cvardecs(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cvardecs$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvardecs$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvardecs$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cvardecs$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cvardecs$con(out, _) = fprint(out, "D2Cvardecs")
implement{}
fprint_d2ecl_node$D2Cvardecs$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cvardecs$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Cvardecs$arg1(out, arg0) =
  let val-D2Cvardecs(arg1) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs$sep1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs$arg1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cdcstdecs$arg2: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cdcstdecs(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cdcstdecs$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cdcstdecs$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cdcstdecs$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cdcstdecs$sep1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cdcstdecs$arg2<>(out, arg0)
val () = fprint_d2ecl_node$D2Cdcstdecs$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cdcstdecs$con(out, _) = fprint(out, "D2Cdcstdecs")
implement{}
fprint_d2ecl_node$D2Cdcstdecs$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cdcstdecs$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Cdcstdecs$sep1(out, _) = fprint_d2ecl_node$sep<>(out)
implement{}
fprint_d2ecl_node$D2Cdcstdecs$arg1(out, arg0) =
  let val-D2Cdcstdecs(arg1, _) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
implement{}
fprint_d2ecl_node$D2Cdcstdecs$arg2(out, arg0) =
  let val-D2Cdcstdecs(_, arg2) = arg0 in fprint_d2ecl_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2ecl_node$D2Clocal$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Clocal$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Clocal$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Clocal$sep1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Clocal$arg1: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Clocal$arg2: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Clocal(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Clocal$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Clocal$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Clocal$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Clocal$sep1<>(out, arg0)
val () = fprint_d2ecl_node$D2Clocal$arg2<>(out, arg0)
val () = fprint_d2ecl_node$D2Clocal$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Clocal$con(out, _) = fprint(out, "D2Clocal")
implement{}
fprint_d2ecl_node$D2Clocal$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Clocal$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Clocal$sep1(out, _) = fprint_d2ecl_node$sep<>(out)
implement{}
fprint_d2ecl_node$D2Clocal$arg1(out, arg0) =
  let val-D2Clocal(arg1, _) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
implement{}
fprint_d2ecl_node$D2Clocal$arg2(out, arg0) =
  let val-D2Clocal(_, arg2) = arg0 in fprint_d2ecl_node$carg(out, arg2) end
//
extern
fun{}
fprint_d2ecl_node$D2Cextcode$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cextcode$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cextcode$rpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cextcode$arg1: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cextcode(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cextcode$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cextcode$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cextcode$arg1<>(out, arg0)
val () = fprint_d2ecl_node$D2Cextcode$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cextcode$con(out, _) = fprint(out, "D2Cextcode")
implement{}
fprint_d2ecl_node$D2Cextcode$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cextcode$rpar(out, _) = fprint_d2ecl_node$rpar(out)
implement{}
fprint_d2ecl_node$D2Cextcode$arg1(out, arg0) =
  let val-D2Cextcode(arg1) = arg0 in fprint_d2ecl_node$carg(out, arg1) end
//
extern
fun{}
fprint_d2ecl_node$D2Cignored$con: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cignored$lpar: $d2ctype(fprint_d2ecl_node<>)
extern
fun{}
fprint_d2ecl_node$D2Cignored$rpar: $d2ctype(fprint_d2ecl_node<>)
//
implement{}
fprint_d2ecl_node$D2Cignored(out, arg0) = 
{
//
val () = fprint_d2ecl_node$D2Cignored$con<>(out, arg0)
val () = fprint_d2ecl_node$D2Cignored$lpar<>(out, arg0)
val () = fprint_d2ecl_node$D2Cignored$rpar<>(out, arg0)
//
}
implement{}
fprint_d2ecl_node$D2Cignored$con(out, _) = fprint(out, "D2Cignored")
implement{}
fprint_d2ecl_node$D2Cignored$lpar(out, _) = fprint_d2ecl_node$lpar(out)
implement{}
fprint_d2ecl_node$D2Cignored$rpar(out, _) = fprint_d2ecl_node$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_p2at_node$P2Tany: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tvar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tempty: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tann: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Ti0nt: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tignored: $d2ctype(fprint_p2at_node<>)
//
(* ****** ****** *)
//
implement{}
fprint_p2at_node
  (out, arg0) =
(
case+ arg0 of
| P2Tany _ => fprint_p2at_node$P2Tany<>(out, arg0)
| P2Tvar _ => fprint_p2at_node$P2Tvar<>(out, arg0)
| P2Tempty _ => fprint_p2at_node$P2Tempty<>(out, arg0)
| P2Tann _ => fprint_p2at_node$P2Tann<>(out, arg0)
| P2Trec _ => fprint_p2at_node$P2Trec<>(out, arg0)
| P2Tcon _ => fprint_p2at_node$P2Tcon<>(out, arg0)
| P2Ti0nt _ => fprint_p2at_node$P2Ti0nt<>(out, arg0)
| P2Tignored _ => fprint_p2at_node$P2Tignored<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_p2at_node$sep: (FILEref) -> void
implement{}
fprint_p2at_node$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_p2at_node$lpar: (FILEref) -> void
implement{}
fprint_p2at_node$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_p2at_node$rpar: (FILEref) -> void
implement{}
fprint_p2at_node$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_p2at_node$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_p2at_node$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_p2at_node$P2Tany$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tany$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tany$rpar: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Tany(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Tany$con<>(out, arg0)
val () = fprint_p2at_node$P2Tany$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Tany$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Tany$con(out, _) = fprint(out, "P2Tany")
implement{}
fprint_p2at_node$P2Tany$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Tany$rpar(out, _) = fprint_p2at_node$rpar(out)
//
extern
fun{}
fprint_p2at_node$P2Tvar$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tvar$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tvar$rpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tvar$arg1: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Tvar(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Tvar$con<>(out, arg0)
val () = fprint_p2at_node$P2Tvar$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Tvar$arg1<>(out, arg0)
val () = fprint_p2at_node$P2Tvar$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Tvar$con(out, _) = fprint(out, "P2Tvar")
implement{}
fprint_p2at_node$P2Tvar$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Tvar$rpar(out, _) = fprint_p2at_node$rpar(out)
implement{}
fprint_p2at_node$P2Tvar$arg1(out, arg0) =
  let val-P2Tvar(arg1) = arg0 in fprint_p2at_node$carg(out, arg1) end
//
extern
fun{}
fprint_p2at_node$P2Tempty$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tempty$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tempty$rpar: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Tempty(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Tempty$con<>(out, arg0)
val () = fprint_p2at_node$P2Tempty$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Tempty$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Tempty$con(out, _) = fprint(out, "P2Tempty")
implement{}
fprint_p2at_node$P2Tempty$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Tempty$rpar(out, _) = fprint_p2at_node$rpar(out)
//
extern
fun{}
fprint_p2at_node$P2Tann$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tann$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tann$rpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tann$sep1: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tann$arg1: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tann$arg2: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Tann(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Tann$con<>(out, arg0)
val () = fprint_p2at_node$P2Tann$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Tann$arg1<>(out, arg0)
val () = fprint_p2at_node$P2Tann$sep1<>(out, arg0)
val () = fprint_p2at_node$P2Tann$arg2<>(out, arg0)
val () = fprint_p2at_node$P2Tann$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Tann$con(out, _) = fprint(out, "P2Tann")
implement{}
fprint_p2at_node$P2Tann$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Tann$rpar(out, _) = fprint_p2at_node$rpar(out)
implement{}
fprint_p2at_node$P2Tann$sep1(out, _) = fprint_p2at_node$sep<>(out)
implement{}
fprint_p2at_node$P2Tann$arg1(out, arg0) =
  let val-P2Tann(arg1, _) = arg0 in fprint_p2at_node$carg(out, arg1) end
implement{}
fprint_p2at_node$P2Tann$arg2(out, arg0) =
  let val-P2Tann(_, arg2) = arg0 in fprint_p2at_node$carg(out, arg2) end
//
extern
fun{}
fprint_p2at_node$P2Trec$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$rpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$sep1: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$sep2: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$arg1: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$arg2: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Trec$arg3: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Trec(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Trec$con<>(out, arg0)
val () = fprint_p2at_node$P2Trec$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Trec$arg1<>(out, arg0)
val () = fprint_p2at_node$P2Trec$sep1<>(out, arg0)
val () = fprint_p2at_node$P2Trec$arg2<>(out, arg0)
val () = fprint_p2at_node$P2Trec$sep2<>(out, arg0)
val () = fprint_p2at_node$P2Trec$arg3<>(out, arg0)
val () = fprint_p2at_node$P2Trec$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Trec$con(out, _) = fprint(out, "P2Trec")
implement{}
fprint_p2at_node$P2Trec$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Trec$rpar(out, _) = fprint_p2at_node$rpar(out)
implement{}
fprint_p2at_node$P2Trec$sep1(out, _) = fprint_p2at_node$sep<>(out)
implement{}
fprint_p2at_node$P2Trec$sep2(out, _) = fprint_p2at_node$sep<>(out)
implement{}
fprint_p2at_node$P2Trec$arg1(out, arg0) =
  let val-P2Trec(arg1, _, _) = arg0 in fprint_p2at_node$carg(out, arg1) end
implement{}
fprint_p2at_node$P2Trec$arg2(out, arg0) =
  let val-P2Trec(_, arg2, _) = arg0 in fprint_p2at_node$carg(out, arg2) end
implement{}
fprint_p2at_node$P2Trec$arg3(out, arg0) =
  let val-P2Trec(_, _, arg3) = arg0 in fprint_p2at_node$carg(out, arg3) end
//
extern
fun{}
fprint_p2at_node$P2Tcon$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$rpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$sep1: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$sep2: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$arg1: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$arg2: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tcon$arg3: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Tcon(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Tcon$con<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$arg1<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$sep1<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$arg2<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$sep2<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$arg3<>(out, arg0)
val () = fprint_p2at_node$P2Tcon$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Tcon$con(out, _) = fprint(out, "P2Tcon")
implement{}
fprint_p2at_node$P2Tcon$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Tcon$rpar(out, _) = fprint_p2at_node$rpar(out)
implement{}
fprint_p2at_node$P2Tcon$sep1(out, _) = fprint_p2at_node$sep<>(out)
implement{}
fprint_p2at_node$P2Tcon$sep2(out, _) = fprint_p2at_node$sep<>(out)
implement{}
fprint_p2at_node$P2Tcon$arg1(out, arg0) =
  let val-P2Tcon(arg1, _, _) = arg0 in fprint_p2at_node$carg(out, arg1) end
implement{}
fprint_p2at_node$P2Tcon$arg2(out, arg0) =
  let val-P2Tcon(_, arg2, _) = arg0 in fprint_p2at_node$carg(out, arg2) end
implement{}
fprint_p2at_node$P2Tcon$arg3(out, arg0) =
  let val-P2Tcon(_, _, arg3) = arg0 in fprint_p2at_node$carg(out, arg3) end
//
extern
fun{}
fprint_p2at_node$P2Ti0nt$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Ti0nt$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Ti0nt$rpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Ti0nt$arg1: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Ti0nt(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Ti0nt$con<>(out, arg0)
val () = fprint_p2at_node$P2Ti0nt$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Ti0nt$arg1<>(out, arg0)
val () = fprint_p2at_node$P2Ti0nt$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Ti0nt$con(out, _) = fprint(out, "P2Ti0nt")
implement{}
fprint_p2at_node$P2Ti0nt$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Ti0nt$rpar(out, _) = fprint_p2at_node$rpar(out)
implement{}
fprint_p2at_node$P2Ti0nt$arg1(out, arg0) =
  let val-P2Ti0nt(arg1) = arg0 in fprint_p2at_node$carg(out, arg1) end
//
extern
fun{}
fprint_p2at_node$P2Tignored$con: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tignored$lpar: $d2ctype(fprint_p2at_node<>)
extern
fun{}
fprint_p2at_node$P2Tignored$rpar: $d2ctype(fprint_p2at_node<>)
//
implement{}
fprint_p2at_node$P2Tignored(out, arg0) = 
{
//
val () = fprint_p2at_node$P2Tignored$con<>(out, arg0)
val () = fprint_p2at_node$P2Tignored$lpar<>(out, arg0)
val () = fprint_p2at_node$P2Tignored$rpar<>(out, arg0)
//
}
implement{}
fprint_p2at_node$P2Tignored$con(out, _) = fprint(out, "P2Tignored")
implement{}
fprint_p2at_node$P2Tignored$lpar(out, _) = fprint_p2at_node$lpar(out)
implement{}
fprint_p2at_node$P2Tignored$rpar(out, _) = fprint_p2at_node$rpar(out)
//
(* ****** ****** *)
