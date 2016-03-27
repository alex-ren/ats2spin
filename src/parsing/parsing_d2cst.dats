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

staload "./parsing.sats"
staload "./../postiats/utfpl.sats"

(* ****** ****** *)

staload "{$JSONC}/SATS/json_ML.sats"

(* ****** ****** *)

extern
fun the_d2cstmap_find (stamp): d2cstopt_vt
extern
fun the_d2cstmap_insert (d2c: d2cst): void
extern
fun the_d2cstmap_get (): d2cstmap

(* ****** ****** *)

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
var mymap: d2cstmap =  $HT.hashtbl_make_nil (i2sz(2048))
val the_d2cstmap =
  ref_make_viewptr{d2cstmap} (view@mymap | addr@mymap)

implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

in (* in of [local] *)

implement
the_d2cstmap_find
  (k0) = let
//
val (vbox(pf) | p) = ref_get_viewptr (the_d2cstmap)
//
in
  $effmask_ref ($HT.hashtbl_search (!p, k0))
end // end of [the_d2cstmap_find]

implement
the_d2cstmap_insert
  (d2c0) = let
//
val k0 = d2c0.stamp()
val (vbox(pf) | p) = ref_get_viewptr (the_d2cstmap)
val- ~None_vt ((*void*)) = $effmask_ref ($HT.hashtbl_insert (!p, k0, d2c0))
//
in
  // nothing
end // end of [the_d2cstmap_insert]

implement the_d2cstmap_get () = let
  val (vbox(pf) | p) = ref_get_viewptr (the_d2cstmap)
in
  !p
end

end // end of [local]

(* ****** ****** *)

implement
parse_d2cst
  (jsv0) = let
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2cst_stamp")
//
val stamp = parse_stamp (jsv2)
//
val opt = the_d2cstmap_find (stamp)
//
in
//
case+ opt of
| ~Some_vt (d2c) => d2c
| ~None_vt ((*void*)) => d2c where
  {
    val-~Some_vt(jsv1) =
      jsonval_get_field (jsv0, "d2cst_sym")
    val sym = parse_symbol (jsv1)
    val d2c = d2cst_make (sym, stamp)
    val ((*void*)) = the_d2cstmap_insert (d2c)
  } (* end of [None_vt] *)
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
  jsvs: jsonvalist
) : void =
(
case+ jsvs of
| list_nil () => ()
| list_cons
    (jsv, jsvs) => let
    val d2c = parse_d2cst(jsv) in loop (jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val () = loop (jsvs)
in
  the_d2cstmap_get ()
end // end of [parse_d2cstmap]
  
(* ****** ****** *)

(* end of [parsing_d2cst.dats] *)

