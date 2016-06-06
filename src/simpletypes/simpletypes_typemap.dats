

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"


// vtypedef s3typeopt_vt = Option_vt (s3type)

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

extern fun s3typemap_find (s3typemap, stamp): s3typeopt
extern fun s3typemap_update (
  s3typemap: s3typemap, stamp: stamp, s3type: s3type): void

in (* in of [local] *)


implement s3typemap_create () = let
  val s3typemap =  $HT.hashtbl_make_nil<stamp, s3type> (i2sz(2048))
in
  s3typemap
end

implement s3typemap_find_d2cst (tmap, d2cst) =
s3typemap_find (tmap, d2cst_get_stamp (d2cst))

implement s3typemap_find (tmap, stamp) = 
case+ $HT.hashtbl_search (tmap, stamp) of
| ~Some_vt (s3type) => Some0 s3type
| ~None_vt () => None0

implement
s3typemap_update_d2cst
  (tmap, d2cst, s3type) = 
  s3typemap_update (tmap, d2cst_get_stamp (d2cst), s3type)


implement
s3typemap_update
  (tmap, stamp, s3type) = $HT.hashtbl_insert_any (tmap, stamp, s3type)


end  // end of [local]
(* ****** ****** *)



