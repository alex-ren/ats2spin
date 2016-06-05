
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
fun the_s2cstmap_create (): s2cstmap
extern
fun the_s2cstmap_find (s2cstmap, stamp): s2cstopt_vt
extern
fun the_s2cstmap_insert (s2cstmap: s2cstmap, s2c: s2cst): void

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

implement the_s2cstmap_create () = let
  val s2cstmap =  $HT.hashtbl_make_nil<stamp, s2cst> (i2sz(2048))
in
  s2cstmap
end

implement
the_s2cstmap_find
  (s2cstmap, k0) = let
//
in
  $HT.hashtbl_search (s2cstmap, k0)
end // end of [the_s2cstmap_find]

implement
the_s2cstmap_insert
  (s2cstmap, s2c0) = let
//
val k0 = s2c0.stamp()
val- ~None_vt ((*void*)) = $HT.hashtbl_insert (s2cstmap, k0, s2c0)
//
in
  // nothing
end // end of [the_s2cstmap_insert]

end  // end of [local]

(* ****** ****** *)

implement
parse_s2cst
  (s2cstmap, jsv0) = let
//
val-~Some_vt(jsv_stamp) =
  jsonval_get_field (jsv0, "s2cst_stamp")
//
val stamp = parse_stamp (jsv_stamp)
//
val opt = the_s2cstmap_find (s2cstmap, stamp)
//
in
//
case+ opt of
| ~Some_vt (s2c) => s2c
| ~None_vt ((*void*)) => let
  val-~Some_vt(jsv_sym) =
    jsonval_get_field (jsv0, "s2cst_sym")
  val sym = parse_symbol (jsv_sym)
  val-~Some_vt(jsv_srt) = jsonval_get_field (jsv0, "s2cst_srt")
  val srt = parse_s2rt (jsv_srt)
  val s2c = s2cst_make (sym, stamp, srt)
  val ((*void*)) = the_s2cstmap_insert (s2cstmap, s2c)
in
  s2c
end
end // end of [parse_s2cst]
//


implement
parse_s2cstmap (jsv0) = let
fun
loop
(
  s2cstmap: s2cstmap
  , jsvs: jsonvalist
) : void =
(
case+ jsvs of
| list_nil () => ()
| list_cons
    (jsv, jsvs) => let
    val s2c = parse_s2cst(s2cstmap, jsv) in loop (s2cstmap, jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val s2cstmap = the_s2cstmap_create ()

val () = loop (s2cstmap, jsvs)
in
  s2cstmap
end // end of [parse_s2cstmap]




