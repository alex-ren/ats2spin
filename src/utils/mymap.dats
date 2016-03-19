
staload "./map.sats"


staload FM =
"libats/SATS/funmap_avltree.sats"
staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//
assume mymap (key_t: t0p, val_t: t0p) = $FM.map (key_t, val_t)

implement {} mymap_create () = $FM.funmap_nil ()

implement {key_t} $FM.compare_key_key (k1, k2) = compare_key_key<key_t> (k1, k2)

implement {key_t,val_t} mymap_haskey (key) = 
//


