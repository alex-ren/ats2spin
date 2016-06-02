

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
fun the_s2varmap_create (): s2varmap
extern
fun the_s2varmap_find (s2varmap, stamp): s2varopt_vt
extern
fun the_s2varmap_insert (s2varmap: s2varmap, s2var: s2var): void

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

implement the_s2varmap_create () = let
  val s2varmap =  $HT.hashtbl_make_nil<stamp, s2var> (i2sz(2048))
in
  s2varmap
end

implement
the_s2varmap_find
  (s2varmap, k0) = let
//
in
  $HT.hashtbl_search (s2varmap, k0)
end // end of [the_s2varmap_find]

implement
the_s2varmap_insert
  (s2varmap, s2var0) = let
//
val k0 = s2var0.stamp()
val- ~None_vt ((*void*)) = $HT.hashtbl_insert (s2varmap, k0, s2var0)
//
in
  // nothing
end // end of [the_s2varmap_insert]

end  // end of [local]

(* ****** ****** *)

implement
parse_s2var
  (s2varmap, jsv0) = let
//
val-~Some_vt(jsv_stamp) =
  jsonval_get_field (jsv0, "s2var_stamp")
//
val stamp = parse_stamp (jsv_stamp)
//
val opt = the_s2varmap_find (s2varmap, stamp)
//
in
//
case+ opt of
| ~Some_vt (s2var) => s2var
| ~None_vt ((*void*)) => let
  val-~Some_vt(jsv_name) =
    jsonval_get_field (jsv0, "s2var_name")
  val name = parse_symbol (jsv_name)
  val-~Some_vt(jsv_srt) = jsonval_get_field (jsv0, "s2var_srt")
  val srt = parse_s2rt (jsv_srt)
  val s2var = s2var_make (name, stamp, srt)
  val ((*void*)) = the_s2varmap_insert (s2varmap, s2var)
in
  s2var
end
end // end of [parse_s2var]
//


implement
parse_s2varmap (jsv0) = let
fun
loop
(
  s2varmap: s2varmap
  , jsvs: jsonvalist
) : void =
(
case+ jsvs of
| list_nil () => ()
| list_cons
    (jsv, jsvs) => let
    val s2var = parse_s2var(s2varmap, jsv) in loop (s2varmap, jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val s2varmap = the_s2varmap_create ()

val () = loop (s2varmap, jsvs)
in
  s2varmap
end // end of [parse_s2varmap]




