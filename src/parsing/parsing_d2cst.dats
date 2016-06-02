(*
*)

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
fun the_d2cstmap_create (): d2cstmap
extern
fun the_d2cstmap_find (d2cstmap, stamp): d2cstopt_vt
extern
fun the_d2cstmap_insert (d2cstmap: d2cstmap, d2c: d2cst): void

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

implement the_d2cstmap_create () = let
  val d2cstmap =  $HT.hashtbl_make_nil<stamp, d2cst> (i2sz(2048))
in
  d2cstmap
end

implement
the_d2cstmap_find
  (d2cstmap, k0) = let
//
in
  $HT.hashtbl_search (d2cstmap, k0)
end // end of [the_d2cstmap_find]

implement
the_d2cstmap_insert
  (d2cstmap, d2c0) = let
//
val k0 = d2c0.stamp()
val- ~None_vt ((*void*)) = $HT.hashtbl_insert (d2cstmap, k0, d2c0)
//
in
  // nothing
end // end of [the_d2cstmap_insert]

end  // end of [local]
(* ****** ****** *)

implement parse_d2cst_extdef (jsv) = let
  val jsv0 = jsonval_get_field (jsv, "DCSTEXTDEFsome_ext")
in
  case+ jsv0 of
  | ~Some_vt (jsv1) => let
    val-JSONarray(jsvs) = jsv1
    val () = assertloc (length(jsvs) >= 1)
    val jsv2 = jsvs[0]
    val extdef = parse_string (jsv2)
  in
    Some (extdef)
  end
  | ~None_vt () => let
    val jsv0 = jsonval_get_field (jsv, "DCSTEXTDEFsome_mac")
  in
    case+ jsv0 of
    | ~Some_vt (jsv1) => let
      val-JSONarray(jsvs) = jsv1
      val () = assertloc (length(jsvs) >= 1)
      val jsv2 = jsvs[0]
      val extdef = parse_string (jsv2)
    in
      Some (extdef)
    end
    | ~None_vt () => None ()
  end
end


implement
parse_d2cst
  (d2cstmap, jsv0) = let
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2cst_stamp")
//
val stamp = parse_stamp (jsv2)
//
val opt = the_d2cstmap_find (d2cstmap, stamp)
//
in
//
case+ opt of
| ~Some_vt (d2c) => d2c
| ~None_vt ((*void*)) => let
  val-~Some_vt(jsv1) =
    jsonval_get_field (jsv0, "d2cst_sym")
  val sym = parse_symbol (jsv1)
  val jsv2 = jsonval_get_field (jsv0, "d2cst_extdef")
in
  case+ jsv2 of
  | ~Some_vt (jsv3) =>
  let
    val extdef = parse_d2cst_extdef (jsv3)
    val d2c = d2cst_make (sym, stamp, extdef)
    val ((*void*)) = the_d2cstmap_insert (d2cstmap, d2c)
  in
    d2c
  end
  | ~None_vt () => let
    val d2c = d2cst_make (sym, stamp, None)
    val ((*void*)) = the_d2cstmap_insert (d2cstmap, d2c)
  in
    d2c
  end
end
//
end // end of [parse_d2cst]

(* ****** ****** *)
  
implement
parse_d2cstmap
  (jsv0) = let
//
fun
loop
(
  d2cstmap: d2cstmap
  , jsvs: jsonvalist
) : void =
(
case+ jsvs of
| list_nil () => ()
| list_cons
    (jsv, jsvs) => let
    val d2c = parse_d2cst(d2cstmap, jsv) in loop (d2cstmap, jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val d2cstmap = the_d2cstmap_create ()

val () = loop (d2cstmap, jsvs)
in
  d2cstmap
end // end of [parse_d2cstmap]
  
(* ****** ****** *)

(* end of [parsing_d2cst.dats] *)


