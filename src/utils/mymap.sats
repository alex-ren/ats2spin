
// #include "share/atspre_define.hats"
// #include "share/atspre_staload.hats"

abstype mymap (key_t: t@ype, val_t: t@ype) = ptr

fun {key_t:t@ype} compare_key_key (k1: key_t, k2: key_t):<> int

fun {} mymap_create {key_t,val_t:t@ype} (): mymap (key_t, val_t)
fun {key_t,val_t:t@ype} mymap_haskey (key: key_t): bool
fun {key_t,val_t:t@ype} mymap_find (key: key_t): Option (val_t)
fun {key_t,val_t:t@ype} mymap_insert (key: key_t, v: val_t): Option (val_t)
fun {key_t,val_t:t@ype} mymap_remove (key: key_t): Option (val_t)



