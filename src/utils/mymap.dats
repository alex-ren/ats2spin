

staload "./mymap.sats"


staload FM =
"libats/SATS/funmap_avltree.sats"

staload LM = 
"libats/ML/SATS/hashtblref.sats"

assume myfunmap (key_t: t0p, itm_t: t0p) = $FM.map (key_t, itm_t)

// Implement the stub in FM.
implement {key_t} $FM.compare_key_key (k1, k2) = myfunmap_compare_key_key<key_t> (k1, k2)

implement {} myfunmap_create () = $FM.funmap_nil ()

implement {key_t,itm_t} myfunmap_haskey (map, key) = let
  val opt_itm = $FM.funmap_search_opt<key_t, itm_t> (map, key)
in
  case+ opt_itm of
  | ~Some_vt (itm) => true
  | ~ None_vt () => false
end

implement {key_t,itm_t} 
  myfunmap_find (map, key) = let
  val opt_itm = $FM.funmap_search_opt<key_t, itm_t> (map, key)
in
  case+ opt_itm of
  | ~Some_vt (itm) => Some (itm)
  | ~ None_vt () => None
end

implement {key_t,itm_t}
  myfunmap_insert (map, key, itm) = let
  val opt_itm = $FM.funmap_insert_opt (map, key, itm)
in
  case+ opt_itm of
  | ~Some_vt (itm) => Some (itm)
  | ~ None_vt () => None
end

implement {key_t,itm_t} 
  myfunmap_remove (map, key) = $FM.funmap_remove (map, key)

(* ************** *************** *)

assume mylinmap (key_t: t0p, itm_t: t0p) = $LM.hashtbl (key_t, itm_t)

// Implement the stub in LM.
implement {key_t} $LM.hash_key (k) = mylinmap_hash_key<key_t> (k)
implement {key_t} $LM.equal_key_key (k1, k2) = 
  mylinmap_equal_key_key<key_t> (k1, k2)

implement {} mylinmap_create {key_t, itm_t} () =
  $LM.hashtbl_make_nil<key_t, itm_t> (i2sz(2014))

implement {key_t, itm_t} mylinmap_haskey (map, key) = let
  val opt = $LM.hashtbl_search (map, key)
in
  case+ opt of
  | ~Some_vt (itm) => true
  | ~None_vt () => false
end

implement {key_t, itm_t} mylinmap_find (map, key) = let
  val opt = $LM.hashtbl_search (map, key)
in
  case+ opt of
  | ~Some_vt (itm) => Some (itm)
  | ~None_vt () => None ()
end

implement {key_t, itm_t} mylinmap_insert (map, key, itm) = let
  val opt = $LM.hashtbl_insert (map, key, itm)
in
  case+ opt of
  | ~Some_vt (itm) => Some (itm)
  | ~None_vt () => None ()
end

implement {key_t, itm_t} mylinmap_remove (map, key) = 
  $LM.hashtbl_remove (map, key)



