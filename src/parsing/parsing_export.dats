(*
** Parsing: ATS/JSON -> UTFPL
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload "./../postiats/postiats.sats"

(* ****** ****** *)
  
staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

implement
parse_d2eclist_export
  (jsv0) = let
//
val-~Some_vt(jsv_s2cst) =
  jsonval_get_field (jsv0, "s2cstmap")
val-~Some_vt(jsv_d2cst) =
  jsonval_get_field (jsv0, "d2cstmap")
val-~Some_vt(jsv_d2var) =
  jsonval_get_field (jsv0, "d2varmap")
val-~Some_vt(jsv_d2eclst) =
  jsonval_get_field (jsv0, "d2eclist")
//
val s2cstmap = parse_s2cstmap (jsv_s2cst)
val d2cstmap = parse_d2cstmap (jsv_d2cst)
val d2varmap = parse_d2varmap (jsv_d2var)
val p2env = '{
  parsingenv_s2cstmap = s2cstmap
  , parsingenv_d2cstmap = d2cstmap
  , parsingenv_d2varmap = d2varmap
  }

//
in
  parse_d2eclist (p2env, jsv_d2eclst)
end // end of [parse_d2eclist_export]
  
(* ****** ****** *)

(* end of [parsing_export.dats] *)
