(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../postiats/postiats.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload _ = "./parsing.dats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

extern
fun parse_d2exparg (parsingenv, jsonval): d2exparg

(* ****** ****** *)

extern fun parse_d2lab (parsingenv, jsonval): d2lab
extern fun parse_d2lab_node (parsingenv, jsonval): d2lab

(* ****** ****** *)
//
extern
fun
parse_d2exp_node (parsingenv, jsonval): d2exp_node
//
(* ****** ****** *)

implement
parse_d2exp
  (p2env, jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2exp_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2exp_node") 
val node = parse_d2exp_node (p2env, jsv)
//
in
  d2exp_make_node (loc, node)
end // end of [parse_d2exp]

(* ****** ****** *)
//
implement
parse_d2explst
  (p2env, jsv0) = let
in
  parse_list<d2exp> (jsv0, lam x => parse_d2exp (p2env, x))
end (* end of [parse_d2explst] *)
//
implement
parse_d2expopt
  (d2cstmap, jsv0) = (
  parse_option<d2exp> (jsv0, lam x => parse_d2exp (d2cstmap, x))
) (* end of [parse_d2expopt] *)
//
(* ****** ****** *)

extern
fun parse_D2Ecst (d2cstmap, jsonval): d2exp_node
extern
fun parse_D2Evar (d2varmap, jsonval): d2exp_node
extern
fun parse_D2Esym (jsonval): d2exp_node

extern
fun parse_D2Eint (jsonval): d2exp_node
extern
fun parse_D2Eintrep (jsonval): d2exp_node

extern
fun parse_D2Ei0nt (jsonval): d2exp_node
extern
fun parse_D2Ec0har (jsonval): d2exp_node
extern
fun parse_D2Ef0loat (jsonval): d2exp_node
extern
fun parse_D2Es0tring (jsonval): d2exp_node

extern
fun parse_D2Eempty (jsonval): d2exp_node

extern
fun parse_D2Elet (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Eapplst (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Eifhead (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Ecasehead (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Esing (parsingenv, jsonval): d2exp_node
extern
fun parse_D2Elist (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Etup (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Eseq (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Eselab (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Elam_dyn (parsingenv, jsonval): d2exp_node
extern
fun parse_D2Elam_sta (parsingenv, jsonval): d2exp_node

extern
fun parse_D2Eann_seff (parsingenv, jsonval): d2exp_node
extern
fun parse_D2Eann_type (parsingenv, jsonval): d2exp_node
extern
fun parse_D2Eann_funclo (parsingenv, jsonval): d2exp_node
extern
fun parse_D2Eextfcall (parsingenv, jsonval): d2exp_node
extern
fun parse_D2Eassgn (parsingenv, jsonval): d2exp_node

extern
fun parse_c2lau (parsingenv, jsonval): c2lau
extern
fun parse_c2laulst (parsingenv, jsonval): c2laulst

extern
fun parse_D2Eignored (jsonval): d2exp_node

(* ****** ****** *)

implement
parse_d2exp_node
  (p2env, jsv0) = let
(*
val (
) = fprintln!
  (stdout_ref, "parse_d2exp_node: jsv0 = ", jsv0)
*)
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "D2Ecst" => parse_D2Ecst (p2env.parsingenv_d2cstmap, jsv2)
| "D2Evar" => parse_D2Evar (p2env.parsingenv_d2varmap, jsv2)
| "D2Esym" => parse_D2Esym (jsv2)
//
| "D2Eint" => parse_D2Eint (jsv2)
| "D2Eintrep" => parse_D2Eintrep (jsv2)
//
| "D2Ei0nt" => parse_D2Ei0nt (jsv2)
| "D2Ec0har" => parse_D2Ec0har (jsv2)
| "D2Ef0loat" => parse_D2Ef0loat (jsv2)
| "D2Es0tring" => parse_D2Es0tring (jsv2)
//
| "D2Eempty" => parse_D2Eempty (jsv2)
//
| "D2Elet" => parse_D2Elet (p2env, jsv2)
//
| "D2Eapplst" => parse_D2Eapplst (p2env, jsv2)
//
| "D2Eifhead" => parse_D2Eifhead (p2env, jsv2)
| "D2Ecasehead" => parse_D2Ecasehead (p2env, jsv2)
//
| "D2Esing" => parse_D2Esing (p2env, jsv2)
| "D2Elist" => parse_D2Elist (p2env, jsv2)
//
| "D2Etup" => parse_D2Etup (p2env, jsv2)
| "D2Eseq" => parse_D2Eseq (p2env, jsv2)
//
| "D2Eselab" => parse_D2Eselab (p2env, jsv2)
//
| "D2Elam_dyn" => parse_D2Elam_dyn (p2env, jsv2)
| "D2Elam_sta" => parse_D2Elam_sta (p2env, jsv2)
//
| "D2Eann_seff" => parse_D2Eann_seff (p2env, jsv2)
| "D2Eann_type" => parse_D2Eann_type (p2env, jsv2)
| "D2Eann_funclo" => parse_D2Eann_funclo (p2env, jsv2)
| "D2Eextfcall" => parse_D2Eextfcall (p2env, jsv2)
| "D2Eassgn" => parse_D2Eassgn (p2env, jsv2)
//
| s (*rest*) => let
  val () = print! (s,  " is ignored in parsing/parsing_d2exp.dats")
in
  parse_D2Eignored (jsv2)
end
//
end // end of [parse_d2exp_node]

(* ****** ****** *)

implement
parse_D2Ecst
  (d2cstmap, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2c = parse_d2cst (d2cstmap, jsvs[0])
//
in
  D2Ecst (d2c)
end // end of [parse_D2Ecst]

(* ****** ****** *)

implement
parse_D2Evar
  (d2varmap, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2v = parse_d2var (d2varmap, jsvs[0])
//
in
  D2Evar (d2v)
end // end of [parse_D2Evar]

(* ****** ****** *)

implement
parse_D2Esym
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2s = parse_d2sym (jsvs[0])
//
in
  D2Esym (d2s)
end // end of [parse_D2Esym]

(* ****** ****** *)

implement
parse_D2Eint
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val int = parse_int (jsvs[0])
//
in
  D2Eint (int)
end // end of [parse_D2Eint]

implement
parse_D2Eintrep
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Eintrep (rep)
end // end of [parse_D2Eintrep]

(* ****** ****** *)

implement
parse_D2Ei0nt
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Ei0nt (rep)
end // end of [parse_D2Ei0nt]

(* ****** ****** *)

implement
parse_D2Ec0har
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val int = parse_int (jsvs[0])
//
in
  D2Ec0har (int2char0(int))
end // end of [parse_D2Ec0har]

(* ****** ****** *)

implement
parse_D2Ef0loat
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Ef0loat (rep)
end // end of [parse_D2Ef0loat]

(* ****** ****** *)

implement
parse_D2Es0tring
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val rep = parse_string (jsvs[0])
//
in
  D2Es0tring (rep)
end // end of [parse_D2Es0tring]

(* ****** ****** *)

implement
parse_D2Eempty
  (jsv0) = let
//
val-JSONarray(jsvs) = jsv0
//
in
  D2Eempty ()
end // end of [parse_D2Eempty]

(* ****** ****** *)

implement
parse_D2Elet
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2cs = parse_d2eclist (p2env, jsvs[0])
val d2e_body = parse_d2exp (p2env, jsvs[1])
//
in
  D2Elet (d2cs, d2e_body)
end // end of [parse_D2Elet]

(* ****** ****** *)

implement
parse_D2Eapplst
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e_fun = parse_d2exp (p2env, jsvs[0])
val d2as_arg = parse_list<d2exparg> (jsvs[1], lam x => parse_d2exparg (p2env, x))
//
in
  D2Eapplst (d2e_fun, d2as_arg)
end // end of [parse_D2Eapplst]

(* ****** ****** *)

implement
parse_D2Eifhead
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
//
val _test = parse_d2exp (p2env, jsvs[1])
val _then = parse_d2exp (p2env, jsvs[2])
val _else = parse_d2expopt (p2env, jsvs[3])
//
in
  D2Eifopt (_test, _then, _else)
end // end of [parse_D2Eifhead]

(* ****** ****** *)

implement
parse_D2Ecasehead
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
//
val casekind = parse_casekind (jsvs[0])
val- JSONarray (jsv2_arr) = jsvs[2]
val () = assertloc (length (jsv2_arr) >= 1)
val _test = parse_d2exp (p2env, jsv2_arr[0])
val c2laulst = parse_c2laulst (p2env, jsvs[3])
//
in
  D2Ecase (casekind, _test, c2laulst)
end // end of [parse_D2Eifhead]


implement parse_c2laulst (p2env, jsv0) = let
in
  parse_list<c2lau> (jsv0, lam x => parse_c2lau (p2env, x))
end

implement parse_c2lau (p2env, jsv0) = let
  val-~Some_vt(jsv_loc) = jsonval_get_field (jsv0, "c2lau_loc") 
  val c2lau_loc = parse_location (jsv_loc)


  val-~Some_vt(jsv_patlst) = jsonval_get_field (jsv0, "c2lau_pat") 
  val c2lau_patlst = parse_p2atlst (p2env.parsingenv_d2varmap, jsv_patlst)


  val-~Some_vt(jsv_body) = jsonval_get_field (jsv0, "c2lau_body") 
  val c2lau_body = parse_d2exp (p2env, jsv_body)

  val c2lau = '{
    c2lau_loc = c2lau_loc
    , c2lau_patlst = c2lau_patlst
    , c2lau_body = c2lau_body
  }
in c2lau end


(* ****** ****** *)

implement
parse_D2Esing
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2e = parse_d2exp (p2env, jsvs[0])
//
in
  D2Esing (d2e)
end // end of [parse_D2Esing]

(* ****** ****** *)

implement
parse_D2Elist
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2es = parse_d2explst (p2env, jsvs[1])
//
in
  D2Elist (d2es)
end // end of [parse_D2Elist]

(* ****** ****** *)

implement
parse_D2Etup
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val d2es = parse_d2explst (p2env, jsvs[2])
//
in
  D2Etup (d2es)
end // end of [parse_D2Etup]

(* ****** ****** *)

implement
parse_D2Eseq
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val d2es = parse_d2explst (p2env, jsvs[0])
//
in
  D2Eseq (d2es)
end // end of [parse_D2Eseq]

(* ****** ****** *)

implement
parse_D2Eselab
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (p2env, jsvs[0])
val d2ls = parse_list<d2lab> (jsvs[1], lam x => parse_d2lab (p2env, x))
//
in
  D2Eselab (d2e, d2ls)
end // end of [parse_D2Eselab]

(* ****** ****** *)

implement
parse_D2Elam_dyn
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 4)
val p2ts = parse_p2atlst (p2env.parsingenv_d2varmap, jsvs[2])
val d2e_body = parse_d2exp (p2env, jsvs[3])
//
in
  D2Elam (p2ts, d2e_body)
end // end of [parse_D2Elam_dyn]

(* ****** ****** *)

implement
parse_D2Elam_sta
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val d2e = parse_d2exp (p2env, jsvs[2])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Elam_sta]

(* ****** ****** *)

implement
parse_D2Eann_seff
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (p2env, jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_seff]

(* ****** ****** *)

implement
parse_D2Eann_type
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (p2env, jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_type]

(* ****** ****** *)

implement
parse_D2Eann_funclo
  (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val d2e = parse_d2exp (p2env, jsvs[0])
//
in
  D2Eexp (d2e)
end // end of [parse_D2Eann_funclo]

(* ****** ****** *)

implement
parse_D2Eextfcall (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val fname = parse_string (jsvs[1])
val d2es = parse_d2explst (p2env, jsvs[2])
in
  D2Eextfcall (fname, d2es)
end

implement
parse_D2Eassgn (p2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val exp_left = parse_d2exp (p2env, jsvs[0])
val exp_right = parse_d2exp (p2env, jsvs[1])
in
  D2Eassgn (exp_left, exp_right)
end

(* ****** ****** *)

implement
parse_D2Eignored (jsv) = D2Eignored ((*void*))

(* ****** ****** *)

implement
parse_d2exparg
  (p2env, jsv0) = let
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "D2EXPARGsta" => let
     val-JSONarray(jsvs) = jsv2
   in
     D2EXPARGsta ((*void*))
   end // end of [D2EXPARGsta]
| "D2EXPARGdyn" => let
     val-JSONarray(jsvs) = jsv2
     val () = assertloc (length(jsvs) >= 3)
     val npf = parse_int (jsvs[0])
     val loc = parse_location (jsvs[1])
     val d2es = parse_d2explst (p2env, jsvs[2])
   in
     D2EXPARGdyn (npf, loc, d2es)
   end // end of [D2EXPARGdyn]
//
| _ => let val () = assertloc (false) in exit(1) end
//
end // end of [parse_d2exparg]

(* ****** ****** *)

implement
parse_d2lab
  (p2env, jsv0) = let
//
(*
val-~Some_vt(jsv) =
  jsonval_get_field (jsv0, "d2lab_loc") 
val loc = parse_location (jsv)
*)
val-~Some_vt(jsv) =
  jsonval_get_field (jsv0, "d2lab_node") 
in
  parse_d2lab_node (p2env, jsv)
end // end of [parse_d2lab]

(* ****** ****** *)

implement
parse_d2lab_node
  (p2env, jsv0) = let
//
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "D2LABlab" => let
    val-JSONarray(jsvs) = jsv2
    val () = assertloc (length(jsvs) >= 1)
    val lab = parse_label (jsvs[0])
  in
    D2LABlab (lab)
  end // end of [D2LABlab]
| "D2LABind" => let
    val-JSONarray(jsvs) = jsv2
    val () = assertloc (length(jsvs) >= 1)
    val d2es = parse_d2explst (p2env, jsvs[0])
  in
    D2LABind (d2es)
  end // end of [D2LABin]
| _(*deadcode*) =>
    let val () = assertloc (false) in exit(1) end
//
end // end of [parse_d2lab_node]

(* ****** ****** *)

(* end of [parsing_d2exp.dats] *)
