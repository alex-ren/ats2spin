
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./instr0.sats"

staload "./../postiats/utfpl.sats"

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

implement i0idmap_create (sz) =
  $HT.hashtbl_make_nil<i0id, i0id> (sz)

implement i0idmap_insert_any (i0idmap, key, v) =
  $HT.hashtbl_insert_any (i0idmap, key, v)

implement i0idmap_listize1 (i0idmap) =
  $HT.hashtbl_listize1 (i0idmap)

implement i0idmap_search (i0idmap, key) = 
  $HT.hashtbl_search<i0id, i0id> (i0idmap, key)

end  // end of [local]

