
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "./utils/mymap.sats"
staload _ = "./utils/mymap.dats"

staload _(*FM*) =
"libats/DATS/funmap_avltree.dats"
//


dynload "./postiats/utfpl_dynloadall.dats"
dynload "./parsing/dynloadall.dats"

// The following is by default.
// implement compare_key_key<string> (k1, k2) = 
//   compare_string_string (k1, k2)
 
fun test_myfunmap (): void = let
  var map = myfunmap_create<>()
  val haskey = myfunmap_haskey<string, int> (map, "hello")
  val () = assertloc (~haskey)

  val _ = myfunmap_insert (map, "aa", 1)
  val haskey = myfunmap_haskey<string, int> (map, "aa")
  val () = assertloc (haskey)

  val opt = myfunmap_find (map, "aa")
  val- Some (itm) = opt
  val () = assertloc (itm = 1)

  val _ = myfunmap_remove (map, "aa")
  val haskey = myfunmap_haskey<string, int> (map, "aa")
  val () = assertloc (~haskey)

in
end

implement main0 () = let
  val () = test_myfunmap ()
in end


