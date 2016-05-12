

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../postiats/utfpl.sats"
staload "./instr0.sats"

// staload "libats/ML/SATS/basis.sats"
staload HT = "libats/ML/SATS/hashtblref.sats"

local

(* For hash table *)
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

(* for qstruct_insert *)
staload _(*anon*) = "libats/DATS/qlist.dats"
// staload _(*anon*) = "libats/ML/DATS/list0.dats"

(* ************ ************* *)

// typedef i0funmap = $HT.hashtbl (i0id, i0fundef)
implement $HT.hash_key<i0id> (x) = hash_stamp (i0id_get_stamp x)
 
implement
$HT.equal_key_key<i0id> (k1, k2) = 
  eq_stamp_stamp (i0id_get_stamp k1, i0id_get_stamp k2)

implement $HT.hash_key<i0id> (x) = hash_stamp (i0id_get_stamp x)

(* ************ ************* *)

in

implement i0funmap_create (sz) =
  $HT.hashtbl_make_nil<i0id, i0fundef> (sz)

implement i0funmap_insert_any (i0funmap, i0id, i0fundef) =
  $HT.hashtbl_insert_any (i0funmap, i0id, i0fundef)

implement i0funmap_listize1 (i0funmap) =
  $HT.hashtbl_listize1 (i0funmap)

implement i0funmap_search0 (i0funmap, i0id) = let
  val- ~Some_vt(ret) = $HT.hashtbl_search<i0id, i0fundef> (i0funmap, i0id)
in
  ret
end
end

