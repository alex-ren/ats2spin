(*
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
//
#include "share/HATS/atspre_staload_libats_ML.hats"
//
staload "./../utils/utils.dats"
(* ****** ****** *)

staload "./postiats.sats"

#include "./postiats_codegen2.hats"

(* ****** ****** *)

implement fprint_val<d2cst> = fprint_d2cst
implement fprint_val<d2var> = fprint_d2var
implement fprint_val<d2sym> = fprint_d2sym
implement fprint_val<d2exp> = fprint_d2exp
implement fprint_val<casekind> = fprint_casekind

implement fprint_val<d2eclist> = fprint_d2eclist
implement fprint_val<d2exparglst> = fprint_d2exparglst
implement fprint_val<d2expopt> = fprint_d2expopt
implement fprint_val<c2laulst> = fprint_c2laulst
implement fprint_val<d2explst> = fprint_d2explst
implement fprint_val<d2lablst> = fprint_d2lablst
implement fprint_val<p2atlst> = fprint_p2atlst

implement fprint_val<s2exp> = fprint_s2exp

implement fprint_val<s2var> = fprint_s2var

implement{}
fprint_d2exp_node$D2Elet$arg1(out, arg0) =
  let val-D2Elet(arg1, _) = arg0 
in fprint_d2exp_node$carg<d2eclist>(out, arg1) end

implement{}
fprint_d2exp_node$D2Eapplst$arg2(out, arg0) =
  let val-D2Eapplst(_, arg2) = arg0 
in fprint_d2exp_node$carg<d2exparglst>(out, arg2) end

implement{}
fprint_d2exp_node$D2Eifopt$arg3(out, arg0) =
  let val-D2Eifopt(_, _, arg3) = arg0 
in fprint_d2exp_node$carg<d2expopt>(out, arg3) end


implement{}
fprint_d2exp_node$D2Ecase$arg2(out, arg0) =
  let val-D2Ecase(_, arg2, _) = arg0 
in fprint_d2exp_node$carg<d2explst>(out, arg2) end

implement{}
fprint_d2exp_node$D2Ecase$arg3(out, arg0) =
  let val-D2Ecase(_, _, arg3) = arg0 
in fprint_d2exp_node$carg<c2laulst>(out, arg3) end

implement{}
fprint_d2exp_node$D2Elist$arg2(out, arg0) =
  let val-D2Elist(_, arg2) = arg0 
in fprint_d2exp_node$carg<d2explst>(out, arg2) end


implement{}
fprint_d2exp_node$D2Etup$arg3(out, arg0) =
  let val-D2Etup(_, _, arg3) = arg0 
in fprint_d2exp_node$carg<d2explst>(out, arg3) end

implement{}
fprint_d2exp_node$D2Eseq$arg1(out, arg0) =
  let val-D2Eseq(arg1) = arg0 
in fprint_d2exp_node$carg<d2explst>(out, arg1) end

implement{}
fprint_d2exp_node$D2Eselab$arg2(out, arg0) =
  let val-D2Eselab(_, arg2) = arg0 
in fprint_d2exp_node$carg<d2lablst>(out, arg2) end

implement{}
fprint_d2exp_node$D2Elam_dyn$arg2(out, arg0) =
  let val-D2Elam_dyn(_, arg2, _) = arg0 
in fprint_d2exp_node$carg<p2atlst>(out, arg2) end

implement{}
fprint_d2exp_node$D2Efix$arg2(out, arg0) =
  let val-D2Efix(_, arg2, _) = arg0 
in fprint_d2exp_node$carg<p2atlst>(out, arg2) end

implement{}
fprint_d2exp_node$D2Eextfcall$arg3(out, arg0) =
  let val-D2Eextfcall(_, _, arg3) = arg0 
in fprint_d2exp_node$carg<d2explst>(out, arg3) end

(* ****** ****** *)
// for pretty print
implement{}
fprint_d2exp_node$D2Ecase$lpar(out, _) = fprint (out, "(\n")
implement{}
fprint_d2exp_node$D2Ecase$rpar(out, _) = fprint (out, "\n)")
implement{}
fprint_d2exp_node$D2Ecase$sep1(out, _) = fprint (out, ",\n")
implement{}
fprint_d2exp_node$D2Ecase$sep2(out, _) = fprint (out, ",\n")

implement{}
fprint_d2exp_node$D2Elet$lpar(out, _) = fprint (out, "(\n")
implement{}
fprint_d2exp_node$D2Elet$sep1(out, _) = fprint (out, "\nin\n")

(* ****** ****** *)

implement
myfprint_d2exp_node (out, node) = fprint_d2exp_node<> (out, node)

implement
fprint_d2exp
  (out, d2e0) = let
in
  myfprint_d2exp_node (out, d2e0.d2exp_node)
end

(* ****** ****** *)

implement
fprint_d2explst
  (out, d2es) = let
//
implement
fprint_val<d2exp> = fprint_d2exp
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2exp> (out, d2es)
end // end of [fprint_d2explst]

(* ****** ****** *)

implement
fprint_d2expopt
  (out, d2es) = let
//
implement
fprint_val<d2exp> = fprint_d2exp
//
in
  fprint_option<d2exp> (out, d2es)
end // end of [fprint_d2expopt]

(* ****** ****** *)

implement
fprint_d2exparg
  (out, d2a) = let
in
//
case+ d2a of
| D2EXPARGsta () =>
    fprint! (out, "D2EXPARGsta(", ")")
| D2EXPARGdyn (npf, loc, d2es) =>
    fprint! (out, "D2EXPARGdyn(", npf, "; ", d2es, ")")
//
end // end of [fprint_d2exparg]

(* ****** ****** *)

implement
fprint_d2exparglst
  (out, d2as) = let
//
implement
fprint_val<d2exparg> = fprint_d2exparg
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2exparg> (out, d2as)
end // end of [fprint_d2exparglst]

(* ****** ****** *)

implement
fprint_d2lab
  (out, d2l0) =
(
  case d2l0 of
  | D2LABlab (lab) => fprint! (out, "D2LABlab(", lab, ")")
  | D2LABind (d2es) => fprint! (out, "D2LABind(", d2es, ")")
) (* end of [fprint_d2lab] *)

(* ****** ****** *)

implement
fprint_d2lablst
  (out, d2ls) = let
//
implement
fprint_val<d2lab> = fprint_d2lab
implement
fprint_list$sep<> (out) = fprint_string (out, ", ")
//
in
  fprint_list<d2lab> (out, d2ls)
end // end of [fprint_d2lablst]

(* ****** ****** *)

implement
d2exp_make_node
  (loc, node) = '{
  d2exp_loc= loc, d2exp_node= node
} (* end of [d2exp_make_node] *)

(* ****** ****** *)

implement d2exp_expose_lam_dyn (d2exp) =
case+ d2exp.d2exp_node of
| D2Elam_sta (_, _, d2exp1) => d2exp_expose_lam_dyn (d2exp1)
| D2Elam_dyn (_, _, d2exp1) => d2exp1
| _ => exitlocmsg ("This is not allowed.\n")

(* ****** ****** *)
//
implement
d2exp_cst
  (loc, d2c) =
  d2exp_make_node (loc, D2Ecst (d2c))
//
implement
d2exp_var
  (loc, d2v) =
  d2exp_make_node (loc, D2Evar (d2v))
//
implement
d2exp_sym
  (loc, d2s) =
  d2exp_make_node (loc, D2Esym (d2s))
//
(* ****** ****** *)

implement
d2exp_int
  (loc, int) =
  d2exp_make_node (loc, D2Eint (int))
// end of [d2exp_int]

implement
d2exp_float
  (loc, dbl) =
  d2exp_make_node (loc, D2Efloat (dbl))
// end of [d2exp_float]

implement
d2exp_string
  (loc, str) =
  d2exp_make_node (loc, D2Estring (str))
// end of [d2exp_string]

(* ****** ****** *)

implement
d2exp_i0nt
  (loc, rep) =
  d2exp_make_node (loc, D2Ei0nt (rep))
// end of [d2exp_i0nt]

implement
d2exp_f0loat
  (loc, rep) =
  d2exp_make_node (loc, D2Ef0loat (rep))
// end of [d2exp_f0loat]

implement
d2exp_s0tring
  (loc, rep) =
  d2exp_make_node (loc, D2Es0tring (rep))
// end of [d2exp_s0tring]

(* ****** ****** *)
//
// implement
// d2exp_exp
//   (loc, d2e) =
//   d2exp_make_node (loc, D2Eexp (d2e))
//
(* ****** ****** *)
//
implement
d2exp_let
  (loc, d2cs, d2e) =
  d2exp_make_node (loc, D2Elet (d2cs, d2e))
//
(* ****** ****** *)
//
implement
d2exp_applst
  (loc, d2e, d2as) =
  d2exp_make_node (loc, D2Eapplst (d2e, d2as))
//
(* ****** ****** *)
//
implement
d2exp_ifopt
  (loc, _test, _then, _else) =
  d2exp_make_node (loc, D2Eifopt (_test, _then, _else))
//
(* ****** ****** *)
//
implement
d2exp_sing
  (loc, d2e) = d2exp_make_node (loc, D2Esing(d2e))
// end of [d2exp_sing]
//
implement
d2exp_list
  (loc, npf, d2es) = d2exp_make_node (loc, D2Elist(npf, d2es))
// end of [d2exp_list]
//
(* ****** ****** *)
//
implement
d2exp_lam_dyn
  (loc, npf, p2ts_arg, d2e_body) =
  d2exp_make_node (loc, D2Elam_dyn (npf, p2ts_arg, d2e_body))
//
implement
d2exp_fix
  (loc, d2v, p2ts_arg, d2e_body) =
  d2exp_make_node (loc, D2Efix (d2v, p2ts_arg, d2e_body))
//
(* ****** ****** *)

implement
d2exp_ignored (loc) = d2exp_make_node (loc, D2Eignored())

(* ****** ****** *)

(* ****** ****** *)

(* end of [postiats_d2exp.dats] *)

