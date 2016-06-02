
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"

staload "./parsing.sats"
staload "./../postiats/postiats.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

extern
fun the_d2conmap_create (): d2conmap
extern
fun the_d2conmap_find (d2conmap, stamp): d2conopt_vt
extern
fun the_d2conmap_insert (d2conmap: d2conmap, d2con: d2con): void

(* ****** ****** *)

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

in (* in of [local] *)

implement the_d2conmap_create () = let
  val d2conmap =  $HT.hashtbl_make_nil<stamp, d2con> (i2sz(2048))
in
  d2conmap
end

implement
the_d2conmap_find
  (d2conmap, k0) = let
//
in
  $HT.hashtbl_search (d2conmap, k0)
end // end of [the_d2conmap_find]

implement
the_d2conmap_insert
  (d2conmap, d2con0) = let
//
val k0 = d2con0.stamp()
val- ~None_vt ((*void*)) = $HT.hashtbl_insert (d2conmap, k0, d2con0)
//
in
  // nothing
end // end of [the_d2conmap_insert]

end  // end of [local]

(* ****** ****** *)

implement
parse_d2con
  (s2env, d2conmap, jsv0) = let
//
val-~Some_vt(jsv_stamp) =
  jsonval_get_field (jsv0, "d2con_stamp")
//
val stamp = parse_stamp (jsv_stamp)
//
val opt = the_d2conmap_find (d2conmap, stamp)
//
in
//
case+ opt of
| ~Some_vt (d2con) => d2con
| ~None_vt ((*void*)) => let
  val-~Some_vt(jsv_sym) =
    jsonval_get_field (jsv0, "d2con_sym")
  val sym = parse_symbol (jsv_sym)
  val-~Some_vt(jsv_type) = jsonval_get_field (jsv0, "d2con_type")
  val s2exp = parse_s2exp (s2env, jsv_type)
  val d2con = d2con_make (sym, s2exp, stamp)
  val ((*void*)) = the_d2conmap_insert (d2conmap, d2con)
in
  d2con
end
end // end of [parse_d2con]
//


implement
parse_d2conmap (s2env, jsv0) = let
fun
loop
(
  s2env: s2parsingenv
  , d2conmap: d2conmap
  , jsvs: jsonvalist
) : void =
(
case+ jsvs of
| list_nil () => ()
| list_cons
    (jsv, jsvs) => let
    val d2con = parse_d2con(s2env, d2conmap, jsv) in loop (s2env, d2conmap, jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val d2conmap = the_d2conmap_create ()

val () = loop (s2env, d2conmap, jsvs)
in
  d2conmap
end // end of [parse_d2conmap]




