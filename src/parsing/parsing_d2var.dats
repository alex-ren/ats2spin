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
fun the_d2varmap_find (d2varmap: d2varmap, stamp): d2varopt_vt
extern
fun the_d2varmap_insert (d2varmap: d2varmap, d2v: d2var): void

(* ****** ****** *)

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

//
in (* in of [local] *)

implement
the_d2varmap_find
  (d2varmap, k0) = let
in
  $HT.hashtbl_search (d2varmap, k0)
end // end of [the_d2varmap_find]

implement
the_d2varmap_insert
  (d2varmap, d2v0) = let
//
val k0 = d2v0.stamp()
val- ~None_vt ((*void*)) = $HT.hashtbl_insert (d2varmap, k0, d2v0)
//
in
  // nothing
end // end of [the_d2varmap_find]

end // end of [local]

(* ****** ****** *)

implement
parse_d2var
  (d2varmap, jsv0) = let
//
val-~Some_vt(jsv2) =
  jsonval_get_field (jsv0, "d2var_stamp")
//
val stamp = parse_stamp (jsv2)
//
val opt = the_d2varmap_find (d2varmap, stamp)
//
in
//
case+ opt of
| ~Some_vt (d2v) => d2v
| ~None_vt ((*void*)) => d2v where
  {
    val-~Some_vt(jsv1) =
      jsonval_get_field (jsv0, "d2var_sym")
    val sym = parse_symbol (jsv1)
    val d2v = d2var_make (sym, stamp)
    val ((*void*)) = the_d2varmap_insert (d2varmap, d2v)
  } (* end of [None_vt] *)
//
end // end of [parse_d2var]

(* ****** ****** *)

local

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

in  // in of [local]

implement
parse_d2varmap
  (jsv0) = let
//
fun
loop
(
  d2varmap: d2varmap
  , jsvs: jsonvalist
) : void =
(
case+ jsvs of
| list_nil () => ()
| list_cons
    (jsv, jsvs) => let
    val d2v = parse_d2var(d2varmap, jsv) in loop (d2varmap, jsvs)
  end // end of [list_cons]
)
//
val-JSONarray(jsvs) = jsv0
//
val d2varmap = $HT. hashtbl_make_nil (i2sz(2048))

val () = loop (d2varmap, jsvs)
in
  d2varmap
end // end of [parse_d2varmap]

end  // end of [local]

(* ****** ****** *)

(* end of [parsing_d2var.dats] *)


