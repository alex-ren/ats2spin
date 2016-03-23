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
fun the_d2varmap_find (stamp): d2varopt
extern
fun the_d2varmap_insert (d2v: d2var): void
extern
fun the_d2varmap_get (): d2varmap

(* ****** ****** *)

local

staload "./../utils/mymap.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

staload _(*anon*) = "./../utils/mymap.dats"
//
var mymap: d2varmap = mylinmap_create ()
val the_d2varmap =
  ref_make_viewptr{d2varmap} (view@mymap | addr@mymap)
//

implement mylinmap_hash_key<stamp> (x) = hash_stamp (x)

implement
mylinmap_equal_key_key<stamp> = eq_stamp_stamp
//
in (* in of [local] *)

implement
the_d2varmap_find
  (k0) = let
//
val (vbox(pf) | p) = ref_get_viewptr (the_d2varmap)
//
in
  $effmask_ref (mylinmap_find (!p, k0))
end // end of [the_d2varmap_find]

implement
the_d2varmap_insert
  (d2v0) = let
//
val k0 = d2v0.stamp()
val (vbox(pf) | p) = ref_get_viewptr (the_d2varmap)
val- None ((*void*)) = $effmask_ref (mylinmap_insert (!p, k0, d2v0))
//
in
  // nothing
end // end of [the_d2varmap_find]

implement the_d2varmap_get () = let
  val (vbox(pf) | p) = ref_get_viewptr (the_d2varmap)
in
  !p
end

end // end of [local]

(* ****** ****** *)

implement
parse_d2var
  (jsv0) = let
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2var_stamp")
//
val stamp = parse_stamp (jsv2)
//
val opt = the_d2varmap_find (stamp)
//
in
//
case+ opt of
| Some (d2v) => d2v
| None ((*void*)) => d2v where
  {
    val-~Some_vt(jsv1) =
      jsonval_get_field (jsv0, "d2var_sym")
    val sym = parse_symbol (jsv1)
    val d2v = d2var_make (sym, stamp)
    val ((*void*)) = the_d2varmap_insert (d2v)
  } (* end of [None_vt] *)
//
end // end of [parse_d2var]

(* ****** ****** *)

implement
parse_d2varmap
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
    val d2v = parse_d2var(jsv) in loop (jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val () = loop (jsvs)
in
  the_d2varmap_get ()
end // end of [parse_d2varmap]

(* ****** ****** *)

(* end of [parsing_d2var.dats] *)
