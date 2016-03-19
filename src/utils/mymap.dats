
staload "./mymap.sats"


staload FM =
"libats/SATS/funmap_avltree.sats"
staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//
assume mymap (key_t: t0p, itm_t: t0p) = $FM.map (key_t, itm_t)

implement {} mymap_create () = $FM.funmap_nil ()

implement {key_t} $FM.compare_key_key (k1, k2) = compare_key_key<key_t> (k1, k2)

implement {key_t,itm_t} mymap_haskey (map, key) = let
  val opt_itm = $FM.funmap_search_opt<key_t, itm_t> (map, key)
in
  case+ opt_itm of
  | ~Some_vt (itm) => true
  | ~ None_vt () => false
end

implement {key_t,itm_t} 
  mymap_find (map, key) = let
  val opt_itm = $FM.funmap_search_opt<key_t, itm_t> (map, key)
in
  case+ opt_itm of
  | ~Some_vt (itm) => Some (itm)
  | ~ None_vt () => None
end

implement {key_t,itm_t}
  mymap_insert (map, key, itm) = let
  val opt_itm = $FM.funmap_insert_opt (map, key, itm)
in
  case+ opt_itm of
  | ~Some_vt (itm) => Some (itm)
  | ~ None_vt () => None
end

implement {key_t,itm_t} 
  mymap_remove (map, key) = $FM.funmap_remove (map, key)
//


