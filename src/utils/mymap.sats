
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

abstype mymap (key_t: t@ype, itm_t: t@ype) = ptr

fun {key_t:t@ype} 
  compare_key_key (k1: key_t, k2: key_t):<> int

fun {} 
  mymap_create {key_t,itm_t:t@ype} (): mymap (key_t, itm_t)

fun {key_t,itm_t:t@ype} 
  mymap_haskey (map: mymap (key_t, itm_t), key: key_t): bool

fun {key_t,itm_t:t@ype} 
  mymap_find (map: mymap (key_t, itm_t), key: key_t): Option (itm_t)

(*
* If key is already in the map, then the associated item is returned.
*)
fun {key_t,itm_t:t@ype} 
  mymap_insert (map: &mymap (key_t, itm_t) >> _, key: key_t, itm: itm_t): Option (itm_t)

fun {key_t,itm_t:t@ype} 
  mymap_remove (map: &mymap (key_t, itm_t) >> _, key: key_t): bool



