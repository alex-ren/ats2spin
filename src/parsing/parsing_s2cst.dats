
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

staload _ = "./parsing.dats"

(* ****** ****** *)

extern
fun the_s2cstmap_create (): s2cstmap
extern
fun the_s2cstmap_find (s2cstmap, stamp): s2cstopt_vt
extern
fun the_s2cstmap_insert (s2cstmap: s2cstmap, s2c: s2cst): void
extern
fun s2cstmap_listize1_ (s2cstmap: s2cstmap): list0 @(stamp, s2cst)

(* ****** ****** *)

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
(* for qstruct_insert *)
staload _(*anon*) = "libats/DATS/qlist.dats"
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

(* **************** **************** *)

implement
the_s2cstmap_find
  (s2cstmap, k0) = let
//
in
  $HT.hashtbl_search (s2cstmap, k0)
end // end of [the_s2cstmap_find]

(* **************** **************** *)

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

(* **************** **************** *)

implement s2cstmap_listize1_ (s2cstmap) = hashtbl_listize1(s2cstmap)

end  // end of [local]

(* ****** ****** *)
implement
parse_s2cst0
  (s2cstmap, jsv0) = (parse_s2cst (0, s2cstmap, jsv0)).0

implement
parse_s2cst
  (max, s2cstmap, jsv0) = let
//
val-~Some_vt(jsv_stamp) =
  jsonval_get_field (jsv0, "s2cst_stamp")
//
val stamp = parse_stamp (jsv_stamp)
val n = stamp_get_value (stamp)
val max = if n > max then n else max
//
val opt = the_s2cstmap_find (s2cstmap, stamp)
//
in
//
case+ opt of
| ~Some_vt (s2c) => '(s2c, max)
| ~None_vt ((*void*)) => let
  // val () = fprint (stderr_ref, "s2cst's stamp is ")
  // val () = fprint_stamp (stderr_ref, stamp)
  // val () = fprint (stderr_ref, "\n")
  val-~Some_vt(jsv_sym) =
    jsonval_get_field (jsv0, "s2cst_sym")
  val sym = parse_symbol (jsv_sym)
  val-~Some_vt(jsv_srt) = jsonval_get_field (jsv0, "s2cst_srt")
  val srt = parse_s2rt (jsv_srt)

  val-~Some_vt(jsv_dconlst) = jsonval_get_field (jsv0, "s2cst_dconlst")
  val-JSONarray(jsvs_dconlst) = jsv_dconlst
in
  if (length (jsvs_dconlst) > 0) then let
    fun parse_dcon_stamp (jsv0: jsonval):<cloref1> stamp = let
      val-~Some_vt (jsv_stamp) = jsonval_get_field (jsv0, "d2con_stamp")
      val stamp = parse_stamp (jsv_stamp)
    in
      stamp
    end
    val dconlst = parse_list0<stamp> (jsvs_dconlst[0], parse_dcon_stamp)
    val s2c = s2cst_make (sym, stamp, srt, dconlst)
    val ((*void*)) = the_s2cstmap_insert (s2cstmap, s2c)
  in
    '(s2c, max)
  end
  else let
    val dconlst = nil0 ()
    val s2c = s2cst_make (sym, stamp, srt, dconlst)
    val ((*void*)) = the_s2cstmap_insert (s2cstmap, s2c)
  in
    '(s2c, max)
  end
end
end // end of [parse_s2cst]
//


implement
parse_s2cstmap (max, jsv0) = let
fun
loop
(
  max: int
  , s2cstmap: s2cstmap
  , jsvs: jsonvalist
) : int =
(
case+ jsvs of
| list_nil () => max
| list_cons
    (jsv, jsvs) => let
    val '(s2c, max) = parse_s2cst(max, s2cstmap, jsv) 
  in 
    loop (max, s2cstmap, jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val s2cstmap = the_s2cstmap_create ()

val max = loop (max, s2cstmap, jsvs)
in
  '(s2cstmap, max)
end // end of [parse_s2cstmap]

(* **************** **************** *)

implement s2cstmap_listize1 (s2cstmap) = s2cstmap_listize1_ (s2cstmap)



