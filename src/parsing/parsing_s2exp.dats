
(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"

staload "./parsing.sats"
staload _ = "./parsing.dats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)
extern
fun parse_s2exp_node (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Ecst (s2cstmap, jsonval): s2exp_node

extern 
fun parse_S2Evar (s2varmap, jsonval): s2exp_node

extern 
fun parse_S2Eextkind (jsonval): s2exp_node

extern 
fun parse_S2Eapp (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Eeqeq (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Eexi (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Euni (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Eint (jsonval): s2exp_node

extern 
fun parse_S2Eintinf (jsonval): s2exp_node

extern 
fun parse_S2Einvar (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Esizeof (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Etyrec (s2parsingenv, jsonval): s2exp_node

(*
* E.g.  (int, int) -> Message
*)
extern 
fun parse_S2Efun (s2parsingenv, jsonval): s2exp_node

(* This is for the return type of a function whose parameters use
* reference type
*)
extern 
fun parse_S2Ewthtype (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_wths2explst (s2parsingenv, jsonval): wths2explst

(* This is for the reference type used for function parameters *)
extern 
fun parse_S2Erefarg (s2parsingenv, jsonval): s2exp_node

(* One user case is inside a S2Erefarg *)
extern
fun parse_S2Etop (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Eignored (jsonval): s2exp_node

extern 
fun parse_tyreckind (s2env: s2parsingenv, jsv0: jsonval): int

extern
fun parse_labs2exp (s2env: s2parsingenv, jsv0: jsonval): labs2exp

implement
parse_s2exp (s2env, jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "s2exp_srt") 
val s2rt = parse_s2rt (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "s2exp_node") 
val node = parse_s2exp_node (s2env, jsv)
//
in
  s2exp_make_node (s2rt, node)
end // end of [parse_s2exp]


implement
parse_s2exp_node (s2env, jsv0) = let
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
| "S2Ecst" => parse_S2Ecst (s2env.s2parsingenv_s2cstmap, jsv2)
| "S2Evar" => parse_S2Evar (s2env.s2parsingenv_s2varmap, jsv2)
| "S2Eextkind" => parse_S2Eextkind (jsv2)
| "S2Eapp" => parse_S2Eapp (s2env, jsv2)
| "S2Eeqeq" => parse_S2Eeqeq (s2env, jsv2)
| "S2Eexi" => parse_S2Eexi (s2env, jsv2)
| "S2Euni" => parse_S2Euni (s2env, jsv2)
| "S2Eint" => parse_S2Eint (jsv2)
| "S2Eintinf" => parse_S2Eintinf (jsv2)
| "S2Einvar" => parse_S2Einvar (s2env, jsv2)
| "S2Esizeof" => parse_S2Esizeof (s2env, jsv2)
| "S2Etyrec" => parse_S2Etyrec (s2env, jsv2)
| "S2Eignored" => parse_S2Eignored (jsv2)
| "S2Efun" => parse_S2Efun (s2env, jsv2)
| "S2Ewthtype" => parse_S2Ewthtype (s2env, jsv2)
| "S2Erefarg" => parse_S2Erefarg (s2env, jsv2)
| "S2Etop" => parse_S2Etop (s2env, jsv2)
| "S2Eerr" => exitlocmsg ("Check this\n")
| s (*rest*) => let
  val () = print! (s,  " is ignored in parsing/parsing_s2exp.dats")
in
  parse_S2Eignored (jsv2)
end

end // end of [parse_d2exp_node]

implement parse_S2Ecst (s2cstmap, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2c = parse_s2cst0 (s2cstmap, jsvs[0])
//
in
  S2Ecst (s2c)
end // end of [parse_S2Ecst]


implement parse_S2Evar (s2varmap, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2v = parse_s2var0 (s2varmap, jsvs[0])
//
in
  S2Evar (s2v)
end // end of [parse_S2Evar]

implement parse_S2Eextkind (jsv0) = let
  val-JSONarray(jsvs) = jsv0
  val () = assertloc (length(jsvs) >= 1)
  val kind = parse_symbol (jsvs[0])
in
S2Eextkind (kind)
end

implement parse_S2Eapp (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2e_fun = parse_s2exp (s2env, jsvs[0])
val s2e_args = parse_list0<s2exp> (jsvs[1], lam x => parse_s2exp (s2env, x))
//
in
  S2Eapp (s2e_fun, s2e_args)
end // end of [parse_S2Eapp]

implement parse_S2Eeqeq (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) = 2)
val s2e1 = parse_s2exp (s2env, jsvs[0])
val s2e2 = parse_s2exp (s2env, jsvs[1])
//
in
  S2Eeqeq (s2e1, s2e2)
end // end of [parse_S2Eeqeq]

implement parse_S2Eexi (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)

val s2e_varlst = parse_list0<s2var> (
       jsvs[0]
       , lam x => parse_s2var0 (s2env.s2parsingenv_s2varmap, x))
val s2e_predicates = parse_list0<s2exp> (jsvs[1], lam x => parse_s2exp (s2env, x))
val s2e_body = parse_s2exp (s2env, jsvs[2])
//
in
  S2Eexi (s2e_varlst, s2e_predicates, s2e_body)
end // end of [parse_S2Eexi]

implement parse_S2Euni (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)

val s2e_varlst = parse_list0<s2var> (
       jsvs[0]
       , lam x => parse_s2var0 (s2env.s2parsingenv_s2varmap, x))
val s2e_predicates = parse_list0<s2exp> (jsvs[1], lam x => parse_s2exp (s2env, x))
val s2e_body = parse_s2exp (s2env, jsvs[2])
//
in
  S2Euni (s2e_varlst, s2e_predicates, s2e_body)
end // end of [parse_S2Euni]

implement parse_S2Eint (jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val n = parse_int (jsvs[0])
//
in
  S2Eint (n)
end // end of [parse_S2Eint]

implement parse_S2Eintinf (jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val str = parse_string (jsvs[0])
//
in
  S2Eintinf (str)
end // end of [parse_S2Eintinf]

implement parse_S2Einvar (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2e = parse_s2exp (s2env, jsvs[0])
//
in
  S2Einvar (s2e)
end // end of [parse_S2Einvar]

implement parse_S2Esizeof (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2e = parse_s2exp (s2env, jsvs[0])
//
in
  S2Esizeof (s2e)
end // end of [parse_S2Esizeof]

implement parse_S2Etyrec (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val kind = parse_tyreckind (s2env, jsvs[0])
val npf = parse_int (jsvs[1])
val labs2explst = parse_list0<labs2exp> (jsvs[2], lam x => parse_labs2exp (s2env, x))
//
in
  S2Etyrec (kind, npf, labs2explst)
end // end of [parse_S2Etyrec]

implement parse_S2Efun (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val s2e_npf = parse_int (jsvs[0])
val s2e_args = parse_list0<s2exp> (jsvs[1], lam x => parse_s2exp (s2env, x))
val s2e_res = parse_s2exp (s2env, jsvs[2])
//
in
  S2Efun (s2e_npf, s2e_args, s2e_res)
end // end of [parse_S2Efun]


implement parse_S2Ewthtype (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2e = parse_s2exp (s2env, jsvs[0])

val wths2explst = parse_wths2explst (s2env, jsvs[1])
in
  S2Ewthtype (s2e, wths2explst)
end

implement parse_wths2explst (s2env, jsv0) = let
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv1 = lx.1
//
val-JSONarray(jsvs) = jsv1
in
//
(
case+ name of
//
| "WTHS2EXPLSTcons_none" => let
  val () = assertloc (length(jsvs) >= 1)
in
  WTHS2EXPLSTcons_none (parse_wths2explst (s2env, jsvs[0]))
end
| "WTHS2EXPLSTcons_trans" => let
  val () = assertloc (length(jsvs) >= 3)
  val refval = parse_int (jsvs[0])
  val s2exp = parse_s2exp (s2env, jsvs[1])
  val wths2explst = parse_wths2explst (s2env, jsvs[2])
in
  WTHS2EXPLSTcons_trans (refval, s2exp, wths2explst)
end
| "WTHS2EXPLSTcons_invar" => let
  val () = assertloc (length(jsvs) >= 3)
  val refval = parse_int (jsvs[0])
  val s2exp = parse_s2exp (s2env, jsvs[1])
  val wths2explst = parse_wths2explst (s2env, jsvs[2])
in
  WTHS2EXPLSTcons_invar (refval, s2exp, wths2explst)
end
| "WTHS2EXPLSTnil" => WTHS2EXPLSTnil ()
| str => exitlocmsg (str + " is not supported")
)
end


implement parse_S2Erefarg (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2e = parse_s2exp (s2env, jsvs[1])
in
  S2Erefarg (s2e)
end

implement parse_S2Etop (s2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val s2e = parse_s2exp (s2env, jsvs[1])
in
  S2Etop (s2e)
end

implement
parse_S2Eignored (jsv) = S2Eignored ((*void*))

implement parse_tyreckind (s2env, jsv0) = let
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
// todo: Some information is trashed currently.
| "TYRECKINDbox" => 1
| "TYRECKINDbox_lin" => 1
| "TYRECKINDflt0" => 0
| "TYRECKINDflt1" => 0
| "TYRECKINDflt_ext" => 0
| s => exitlocmsg (s + " is not handled.\n")
end  // end of [parse_tyreckind]

implement parse_labs2exp (s2env, jsv0) = let
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "SL0ABELED") 
val-JSONarray(jsvs) = jsv
val () = assertloc (length(jsvs) >= 3)

val label = parse_label (jsvs[0])
val nameopt = parse_option0<string> (jsvs[1], lam x => parse_string (x))
val s2exp = parse_s2exp (s2env, jsvs[2])
in
'{labs2exp_label = label
, labs2exp_nameopt = nameopt
, labs2exp_s2exp  = s2exp
}
end


