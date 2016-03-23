
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

// To use myfunmap, please put the following into the dats file.
// staload _(*anon*) = "libats/DATS/funmap_avltree.dats"
// staload _(*anon*) = "./utils/mymap.dats"

abstype myfunmap (key_t: t@ype, itm_t: t@ype) = ptr

// stub whose implementation is left to the user of the template.
fun {key_t:t@ype} 
  myfunmap_compare_key_key (k1: key_t, k2: key_t):<> int

fun {} 
  myfunmap_create {key_t,itm_t:t@ype} (): myfunmap (key_t, itm_t)

fun {key_t,itm_t:t@ype} 
  myfunmap_haskey (map: myfunmap (key_t, itm_t), key: key_t): bool

fun {key_t,itm_t:t@ype} 
  myfunmap_find (map: myfunmap (key_t, itm_t), key: key_t): Option (itm_t)

(*
* If key is already in the map, then the associated item is returned.
*)
fun {key_t,itm_t:t@ype} 
  myfunmap_insert (map: &myfunmap (key_t, itm_t) >> _, key: key_t, itm: itm_t): Option (itm_t)

fun {key_t,itm_t:t@ype} 
  myfunmap_remove (map: &myfunmap (key_t, itm_t) >> _, key: key_t): bool

(* ********* ********* *)

// To use mylinmap, please put the following into the dats file.
// staload _(*anon*) = "libats/DATS/hashfun.dats"
// staload _(*anon*) = "libats/DATS/linmap_list.dats"
// staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
// staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
// staload _(*anon*) = "./utils/mymap.dats"

abstype mylinmap (key_t: t@ype, itm_t: t@ype) = ptr

// stub whose implementation is left to the user of the template.
fun {key_t:t@ype} 
  mylinmap_equal_key_key (k1: key_t, k2: key_t):<> bool

// stub whose implementation is left to the user of the template.
fun {key_t:t@ype}
  mylinmap_hash_key (k: key_t):<> ulint

fun {} 
  mylinmap_create {key_t,itm_t:t@ype} (): mylinmap (key_t, itm_t)

fun {key_t,itm_t:t@ype} 
  mylinmap_haskey (map: mylinmap (key_t, itm_t), key: key_t): bool

fun {key_t,itm_t:t@ype} 
  mylinmap_find (map: mylinmap (key_t, itm_t), key: key_t): Option (itm_t)

(*
* If key is already in the map, then the associated item is returned.
*)
fun {key_t,itm_t:t@ype} 
  mylinmap_insert (map: mylinmap (key_t, itm_t), key: key_t, itm: itm_t): Option (itm_t)

fun {key_t,itm_t:t@ype} 
  mylinmap_remove (map: mylinmap (key_t, itm_t), key: key_t): bool



