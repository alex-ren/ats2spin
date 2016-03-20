
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "./utils/mymap.sats"
staload _ = "./utils/mymap.dats"


dynload "./postiats/utfpl_dynloadall.dats"
dynload "./parsing/dynloadall.dats"

implement compare_key_key<string> (k1, k2) = compare_string_string (k1, k2)
 
fun test_mymap_insert () = let
  var map = mymap_create<>()
  // val haskey = mymap_haskey<string, int> (map, "hello")
  // val () = assertloc (~haskey)
in
end

implement main0 () = ()


