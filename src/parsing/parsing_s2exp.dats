
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

(*
* E.g.  (int, int) -> Message
*)
extern 
fun parse_S2Efun (s2parsingenv, jsonval): s2exp_node

extern 
fun parse_S2Eignored (jsonval): s2exp_node

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
| "S2Eignored" => parse_S2Eignored (jsv2)
| "S2Efun" => parse_S2Efun (s2env, jsv2)
//
| s (*rest*) => let
  val () = print! (s,  " is ignored in parsing/parsing_s2exp.dats")
in
  parse_S2Eignored (jsv2)
end
//
end // end of [parse_d2exp_node]

implement parse_S2Ecst (s2cstmap, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2c = parse_s2cst (s2cstmap, jsvs[0])
//
in
  S2Ecst (s2c)
end // end of [parse_S2Ecst]


implement parse_S2Evar (s2varmap, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val s2v = parse_s2var (s2varmap, jsvs[0])
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




implement
parse_S2Eignored (jsv) = S2Eignored ((*void*))


