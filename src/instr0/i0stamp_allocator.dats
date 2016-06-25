
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"


staload "./instr0.sats"
staload "./../postiats/postiats.sats"

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

//
implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

implement $HT.hash_key<symbol> (x) = hash_symbol (x)

implement
$HT.equal_key_key<symbol> (k1, k2) = eq_symbol_symbol (k1, k2)

in (* in of [local] *)

assume stamp_allocator = '{
  stamp_allocator_d2varmap = $HT.hashtbl (stamp, stamp)  // (oldstamp, newstamp)
  , stamp_allocator_d2cstmap = $HT.hashtbl(stamp, stamp)
  , stamp_allocator_d2conmap = $HT.hashtbl(stamp, stamp)
  , stamp_allocator_d2symmap = $HT.hashtbl(symbol, stamp)
  , stamp_allocator_counter = ref int
}

implement stamp_allocator_create () = let
  val d2varmap = $HT.hashtbl_make_nil<stamp, stamp> (i2sz (2048))
  val d2cstmap = $HT.hashtbl_make_nil<stamp, stamp> (i2sz (2048))
  val d2conmap = $HT.hashtbl_make_nil<stamp, stamp> (i2sz (2048))
  val d2symmap = $HT.hashtbl_make_nil<symbol, stamp> (i2sz (2048))
  val counter = ref<int> (0)
in
  '{ stamp_allocator_d2varmap = d2varmap
   , stamp_allocator_d2cstmap = d2cstmap
   , stamp_allocator_d2conmap = d2conmap
   , stamp_allocator_d2symmap = d2symmap
   , stamp_allocator_counter = counter
   }
end

implement stamp_allocate (sa) = let
  val c = !(sa.stamp_allocator_counter)
  val () = !(sa.stamp_allocator_counter) := c + 1
in
  stamp_make (c)
end

implement stamp_get_from_d2var (sa, d2var) = let
  val stamp = d2var_get_stamp (d2var)
  val itmopt = $HT.hashtbl_search (sa.stamp_allocator_d2varmap, stamp)
in
  case+ itmopt of
  | ~Some_vt (itm) => itm
  | ~None_vt () => let
    val c = stamp_allocate (sa)
    val () = $HT.hashtbl_insert_any (sa.stamp_allocator_d2varmap, stamp, c)
  in
    c
  end
end  // end of [stamp_get_from_d2var]

implement stamp_get_from_d2cst (sa, d2cst) = let
  val stamp = d2cst_get_stamp (d2cst)
  val itmopt = $HT.hashtbl_search (sa.stamp_allocator_d2cstmap, stamp)
in
  case+ itmopt of
  | ~Some_vt (itm) => itm
  | ~None_vt () => let
    val c = stamp_allocate (sa)
    val () = $HT.hashtbl_insert_any (sa.stamp_allocator_d2cstmap, stamp, c)
  in
    c
  end
end  // end of [stamp_get_from_d2cst]


implement stamp_get_from_d2con (sa, d2con) = let
  val stamp = d2con_get_stamp (d2con)
  val itmopt = $HT.hashtbl_search (sa.stamp_allocator_d2conmap, stamp)
in
  case+ itmopt of
  | ~Some_vt (itm) => itm
  | ~None_vt () => let
    val c = stamp_allocate (sa)
    val () = $HT.hashtbl_insert_any (sa.stamp_allocator_d2conmap, stamp, c)
  in
    c
  end
end  // end of [stamp_get_from_d2con]

// implement stamp_get_from_d2sym (sa, d2sym) = let
//   val symbol = d2sym_get_name (d2sym)
//   val itmopt = $HT.hashtbl_search (sa.stamp_allocator_d2symmap, symbol)
// in
//   case+ itmopt of
//   | ~Some_vt (itm) => itm
//   | ~None_vt () => let
//     val c = stamp_allocate (sa)
//     val () = $HT.hashtbl_insert_any (sa.stamp_allocator_d2symmap, symbol, c)
//   in
//     c
//   end
// end  // end of [stamp_get_from_d2sym]



// absvt@ype myvtype = int
// extern fun myvtype_create (): myvtype
// extern fun myvtype_use (ref myvtype): void
// extern fun myvtype_delete (!myvtype >> myvtype?): void
// 
// fun foo (): void = let
//   var v = myvtype_create ()
//   val refv = ref_make_viewptr (view@v | addr@v)
//   val () = myvtype_use (refv)
//   // todo
// 
//   val () = myvtype_delete (v)
// in
// end


end  // end of [local]















