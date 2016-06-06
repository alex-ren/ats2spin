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

(* ****** ****** *)

(* ****** ****** *)





local

staload HT = "libats/ML/SATS/hashtblref.sats"
assume s3poly_para_map = $HT.hashtbl (stamp, s3type)

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

in (* in of [local] *)

implement s3poly_para_map_create () = let
  val map =  $HT.hashtbl_make_nil<stamp, s3type> (i2sz(2048))
in
  map
end

implement s3poly_para_map_insert (map, s2var, s3type) = let
  val k0 = s2var.stamp()
  val- ~None_vt ((*void*)) = $HT.hashtbl_insert (map, k0, s3type)
in end

implement s3poly_para_map_find (map, s2var) = let
  val k0 = s2var.stamp()
  val opt = $HT.hashtbl_search (map, k0)
in
  case+ opt of
  | ~Some_vt (s3type) => Some0 (s3type)
  | ~None_vt () => None0 ()
end


end  // end of [local]

(* ****** ****** *)


