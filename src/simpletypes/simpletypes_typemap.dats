

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


extern
fun the_s3typemap_create (): s3typemap
extern
fun the_s3typemap_find (s3typemap, stamp): s3typeopt_vt
extern
fun the_s3typemap_insert (s3typemap: s3typemap, stamp: stamp, s3type): void

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

implement the_s3typemap_create () = let
  val s3typemap =  $HT.hashtbl_make_nil<stamp, s3type> (i2sz(2048))
in
  s3typemap
end

implement
the_s3typemap_find
  (s3typemap, k0) = let
//
in
  $HT.hashtbl_search (s3typemap, k0)
end // end of [the_s3typemap_find]

implement
the_s3typemap_insert
  (s3typemap, stamp, s3type) = let
//
val- ~None_vt ((*void*)) = 
  $HT.hashtbl_insert (s3typemap, stamp, s3type)
//
in
  // nothing
end // end of [the_s3typemap_insert]

end  // end of [local]
(* ****** ****** *)

implement s3typemap_create () = the_s3typemap_create ()

