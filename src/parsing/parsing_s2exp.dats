
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
fun
parse_s2exp_node (s2parsingenv, jsonval): s2exp_node

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

