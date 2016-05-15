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

staload "./../postiats/utfpl.sats"

(* ****** ****** *)

staload "./parsing.sats"
staload _ = "./parsing.dats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

extern
fun parse_d2ecl_node (d2parsingenv, jsv: jsonval): d2ecl_node

(* ****** ****** *)

implement
parse_d2ecl
  (d2env, jsv0) = let
//
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2ecl_loc") 
val loc = parse_location (jsv)
val-~Some_vt (jsv) =
  jsonval_get_field (jsv0, "d2ecl_node") 
val node = parse_d2ecl_node (d2env, jsv)
//
in
  d2ecl_make_node (loc, node)
end // end of [parse_d2ecl]

(* ****** ****** *)
//
implement
parse_d2eclist
  (d2env, jsv0) = (
  parse_list<d2ecl> (jsv0, lam x =<cloref1> (parse_d2ecl (d2env, x)))
) (* end of [parse_d2eclist] *)
//
(* ****** ****** *)

extern
fun parse_i2mpdec (d2parsingenv, jsonval): i2mpdec

extern
fun parse_f2undec (d2parsingenv, jsonval): f2undec

extern
fun parse_v2aldec (d2parsingenv, jsonval): v2aldec

extern
fun parse_v2ardec (d2parsingenv, jsonval): v2ardec
(* ****** ****** *)

extern
fun parse_D2Cimpdec (d2parsingenv, jsonval): d2ecl_node

extern
fun parse_D2Cfundecs (d2parsingenv, jsonval): d2ecl_node
extern
fun parse_D2Cvaldecs (d2parsingenv, jsonval): d2ecl_node

extern
fun parse_D2Cvardecs (d2parsingenv, jsonval): d2ecl_node
(* ****** ****** *)

extern
fun parse_D2Clocal (d2parsingenv, jsonval): d2ecl_node

extern
fun parse_D2Cextcode (d2parsingenv, jsonval): d2ecl_node

extern
fun parse_D2Cdcstdecs (d2parsingenv, jsonval): d2ecl_node

(* ****** ****** *)

extern
fun parse_D2Cignored (jsonval): d2ecl_node

(* ****** ****** *)

implement
parse_d2ecl_node
  (d2env, jsv0) = let
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
| "D2Cimpdec" => parse_D2Cimpdec (d2env, jsv2)
//
| "D2Cfundecs" => parse_D2Cfundecs (d2env, jsv2)
| "D2Cvaldecs" => parse_D2Cvaldecs (d2env, jsv2)
| "D2Cvardecs" => parse_D2Cvardecs (d2env, jsv2)
//
| "D2Clocal" => parse_D2Clocal (d2env, jsv2)
//
| "D2Cextcode" => parse_D2Cextcode (d2env, jsv2)
| "D2Cdcstdecs" => parse_D2Cdcstdecs (d2env, jsv2)

| _(*rest*) => parse_D2Cignored (jsv2)
//
end // end of [parse_d2ecl_node]

(* ****** ****** *)

implement
parse_i2mpdec
  (d2env, jsv0) = let
//
val-~Some_vt(loc) = 
  jsonval_get_field (jsv0, "i2mpdec_loc")
val-~Some_vt(locid) = 
  jsonval_get_field (jsv0, "i2mpdec_locid")
val-~Some_vt(d2c) =
  jsonval_get_field (jsv0, "i2mpdec_cst")
val-~Some_vt(def) = 
  jsonval_get_field (jsv0, "i2mpdec_def")
//
val loc =
  parse_location (loc)
val locid =
  parse_location (locid)
val d2c = parse_d2cst (d2env.d2parsingenv_d2cstmap, d2c)
val def = parse_d2exp (d2env, def)
//
in
  i2mpdec_make (loc, locid, d2c, def)
end // end of [parse_i2mpdec]

(* ****** ****** *)

implement
parse_f2undec
  (d2env, jsv0) = let
//
val-~Some_vt(loc) = 
  jsonval_get_field (jsv0, "f2undec_loc")
val-~Some_vt(d2v) =
  jsonval_get_field (jsv0, "f2undec_var")
val-~Some_vt(def) = 
  jsonval_get_field (jsv0, "f2undec_def")
//
val loc =
  parse_location (loc)
val d2v = parse_d2var (d2env.d2parsingenv_d2varmap, d2v)
val def = parse_d2exp (d2env, def)
//
in
  f2undec_make (loc, d2v, def)
end // end of [parse_f2undec]

(* ****** ****** *)

implement
parse_v2aldec
  (d2env, jsv0) = let
//
val-~Some_vt(loc) = 
  jsonval_get_field (jsv0, "v2aldec_loc")
val-~Some_vt(p2t) =
  jsonval_get_field (jsv0, "v2aldec_pat")
val-~Some_vt(def) = 
  jsonval_get_field (jsv0, "v2aldec_def")
//
val loc =
  parse_location (loc)
val p2t = parse_p2at (d2env.d2parsingenv_d2varmap, p2t)
val def = parse_d2exp (d2env, def)
//
in
  v2aldec_make (loc, p2t, def)
end // end of [parse_v2aldec]

(* ****** ****** *)

implement
parse_v2ardec
  (d2env, jsv0) = let
//
val-~Some_vt(loc) = 
  jsonval_get_field (jsv0, "v2ardec_loc")
val-~Some_vt(dvar) = 
  jsonval_get_field (jsv0, "v2ardec_dvar")
val-~Some_vt(init) = 
  jsonval_get_field (jsv0, "v2ardec_init")
//
val loc  = parse_location (loc)
val name = parse_d2var (d2env.d2parsingenv_d2varmap, dvar)
val init  = parse_d2exp (d2env, init)
//
in
  v2ardec_make (loc, name, init)
end // end of [parse_v2ardec]

(* ****** ****** *)

implement
parse_D2Cimpdec
  (d2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val knd = parse_int (jsvs[0])
val imp = parse_i2mpdec (d2env, jsvs[1])
//
in
  D2Cimpdec (knd, imp)
end // end of [parse_D2Cimpdec]

(* ****** ****** *)

implement parse_D2Cdcstdecs (d2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val knd = parse_int (jsvs[0])
val-JSONarray(jsvs1) = jsvs[2]
val () = assertloc (length jsvs1 >= 1)
val d2cst = parse_d2cst (d2env.d2parsingenv_d2cstmap, jsvs1[0])
//
in
  D2Cdcstdecs (knd, d2cst)
end

(* ****** ****** *)

implement
parse_D2Cfundecs
  (d2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val knd = parse_funkind (jsvs[0])
val f2ds = parse_list<f2undec> (jsvs[2], lam x => parse_f2undec (d2env, x))
//
in
  D2Cfundecs (knd, f2ds)
end // end of [parse_D2Cfundecs]

(* ****** ****** *)

implement
parse_D2Cvaldecs
  (d2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val knd = parse_valkind (jsvs[0])
val v2ds = parse_list<v2aldec> (jsvs[1], lam x => parse_v2aldec (d2env, x))
//
in
  D2Cvaldecs (knd, v2ds)
end // end of [parse_D2Cvaldecs]

(* ****** ****** *)

implement
parse_D2Cvardecs
  (d2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 1)
val v2ds = parse_list<v2ardec> (jsvs[0], lam x => parse_v2ardec (d2env, x))
//
in
  D2Cvardecs (v2ds)
end // end of [parse_D2Cvaldecs]

(* ****** ****** *)
implement
parse_D2Clocal
  (d2env, jsv0) = let
//
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 2)
val head = parse_d2eclist (d2env, jsvs[0])
val body = parse_d2eclist (d2env, jsvs[1])
//
in
  D2Clocal (head, body)
end // end of [parse_D2Clocal]

(* ****** ****** *)

implement parse_D2Cextcode (d2env, jsv0) = let
val-JSONarray(jsvs) = jsv0
val () = assertloc (length(jsvs) >= 3)
val code = parse_string (jsvs[2])
in
  D2Cextcode (code)
end

(* ****** ****** *)

implement
parse_D2Cignored (jsv0) = D2Cignored ((*void*))

(* ****** ****** *)

(* end of [parsing_d2ecl.dats] *)
