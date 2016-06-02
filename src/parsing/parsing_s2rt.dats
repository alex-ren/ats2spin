
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"

staload "./parsing.sats"
staload _ = "./parsing.dats"

(* ****** ****** *)

staload "./../postiats/postiats.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

extern
fun parse_S2RTbas (jsonval): s2rt

extern
fun parse_S2RTfun (jsonval): s2rt

implement parse_s2rt (jsv0) = let
val-JSONobject(lxs) = jsv0
val-list_cons (lx, lxs) = lxs
//
val name = lx.0 and jsv2 = lx.1
//
in
//
case+ name of
//
| "S2RTbas" => parse_S2RTbas (jsv2)
//
| "S2RTfun" => parse_S2RTfun (jsv2)
| "S2RTtup" => exitlocmsg (name + " is not supported")
| _(*rest*) => exitlocmsg (name + " is not supported")
//
end // end of [parse_s2rt]

implement parse_S2RTbas (jsv0) = let
  val-JSONarray(jsvs) = jsv0
  val len = length jsvs
  val () = assertloc (len = 1)
  val sym = parse_symbol (jsvs[0])
in
  S2RTbas (sym)
end

implement parse_S2RTfun (jsv0) = let
  val-JSONarray(jsvs) = jsv0
  val len = length jsvs
  val () = assertloc (len = 2)

  val args = parse_list0 (jsvs[0], lam x => parse_s2rt (x))
  val res = parse_s2rt (jsvs[1])
in
  S2RTfun (args, res)
end


