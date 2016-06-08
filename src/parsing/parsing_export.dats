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
val-~Some_vt(jsv_s2var) =
  jsonval_get_field (jsv0, "s2varmap")
val-~Some_vt(jsv_d2con) =
  jsonval_get_field (jsv0, "d2conmap")
val-~Some_vt(jsv_d2cst) =
  jsonval_get_field (jsv0, "d2cstmap")
val-~Some_vt(jsv_d2var) =
  jsonval_get_field (jsv0, "d2varmap")
val-~Some_vt(jsv_d2eclst) =
  jsonval_get_field (jsv0, "d2eclist")
//
val '(s2cstmap, max) = parse_s2cstmap (0, jsv_s2cst)
val '(s2varmap, max) = parse_s2varmap (max, jsv_s2var)
val s2env = s2parsingenv_make (s2cstmap, s2varmap)

val '(d2conmap, max) = parse_d2conmap (max, s2env, jsv_d2con)
val '(d2cstmap, max) = parse_d2cstmap (max, s2env, jsv_d2cst)
val '(d2varmap, max) = parse_d2varmap (max, jsv_d2var)
val p2env = parsingenv_make (d2cstmap, d2conmap, d2varmap)

//
in
  '(parse_d2eclist (s2env, p2env, jsv_d2eclst), max)
end // end of [parse_d2eclist_export]
  
(* ****** ****** *)

(* end of [parsing_export.dats] *)
