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
staload "./../postiats/utfpl.sats"

(* ****** ****** *)
  
staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

implement
parse_d2eclist_export
  (jsv0) = let
//
val-~Some_vt(jsv1) =
  jsonval_get_field (jsv0, "d2cstmap")
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2varmap")
val-~Some_vt(jsv3) =
  jsonval_get_field (jsv0, "d2eclist")
//
val cstmap = parse_d2cstmap (jsv1)
val varmap = parse_d2varmap (jsv2)
val d2env = '{
  d2parsingenv_d2cstmap = cstmap
  , d2parsingenv_d2varmap = varmap
  }

//
in
  parse_d2eclist (d2env, jsv3)
end // end of [parse_d2eclist_export]
  
(* ****** ****** *)

(* end of [parsing_export.dats] *)
