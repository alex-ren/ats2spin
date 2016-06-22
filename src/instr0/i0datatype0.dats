

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./../simpletypes/simpletypes.sats"
staload "./instr0.sats"

#include "./../instr0/instr0_codegen2.hats"

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

(* ************* ************* *)
//
implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

(* ************* ************* *)

implement $HT.hash_key<symbol> (x) = hash_symbol (x)

implement
$HT.equal_key_key<symbol> (k1, k2) = eq_symbol_symbol (k1, k2)

(* ************* ************* *)

implement $HT.hash_key<type0> (x) = hash_type0 (x)

implement
$HT.equal_key_key<type0> (k1, k2) = eq_type0_type0 (k1, k2)

in (* in of [local] *)

assume datatype0map = $HT.hashtbl (stamp, datatype0info)

fun datatype0map_create0 (): datatype0map = let
  val dtmap = $HT.hashtbl_make_nil<stamp, datatype0info> (i2sz (2048))
in
  dtmap
end

fun datatype0map_find0 (
  dtmap: datatype0map, s2cst: s2cst): option0 datatype0info = let
  val itmopt = $HT.hashtbl_search (dtmap, s2cst_get_stamp (s2cst))
in
  case+ itmopt of
  | ~Some_vt (itm) => Some0 itm
  | ~None_vt () => None0 ()
end

fun datatype0map_insert0 (
  dtmap: datatype0map, s2cst: s2cst, info: datatype0info): void = let
  val () = $HT.hashtbl_insert_any (dtmap, s2cst_get_stamp (s2cst), info)
in end

typedef type0_int_map = $HT.hashtbl (type0, int)
typedef type0_intlst_map = $HT.hashtbl (type0, list0 int)

fun type0_int_map_create0 (): type0_int_map = let
  val map = $HT.hashtbl_make_nil<type0, int> (i2sz (2048))
in
  map
end

fun type0_int_map_find0 (
  map: type0_int_map, type0: type0): option0 int = let
  val itmopt = $HT.hashtbl_search (map, type0)
in
  case+ itmopt of
  | ~Some_vt (itm) => Some0 itm
  | ~None_vt () => None0 ()
end

fun type0_int_map_insert0 (
  map: type0_int_map, type0: type0, info: int): void = let
  val () = $HT.hashtbl_insert_any (map, type0, info)
in end

fun type0_int_map_add (map: type0_int_map, type0: type0): void = let
  val itmopt = type0_int_map_find0 (map, type0)
in
  case+ itmopt of
  | Some0 (itm) => type0_int_map_insert0 (map, type0, itm + 1)
  | None0 () => type0_int_map_insert0 (map, type0, 1)
end


end  // end of [local]

implement datatype0map_find (datatype0map, s2cst) =
  datatype0map_find0 (datatype0map, s2cst)

implement datatype0map_insert (datatype0map, s2cst, datatype0info) =
  datatype0map_insert (datatype0map, s2cst, datatype0info)

implement datatype0map_translate (s3datatypelst) = let
  val dtmap = datatype0map_create0 ()

  // handle all datatypes
  val dtmap = list0_foldright<s3datatype><datatype0map> (
    s3datatypelst, fopr, dtmap) where {
  fun fopr (
    s3datatype: s3datatype, dtmap: datatype0map):<cloref1> datatype0map = let
    val s3datatype_ctorlst = s3datatype.s3datatype_ctorlst

    val type0_int_map = type0_int_map_create0 ()

    // handle all construtors
    val type0_int_map =
      list0_fold_left (s3datatype_ctorlst, fopr2, type0_int_map) where {
    fun fopr2 (s3ctor: s3ctor, map: type0_int_map): type0_int_map = let
      val map_ctor = type0_int_map_create0 ()
      val map_ctor = list0_foldleft<s3type><type0_int_map> (
        s3ctor.s3ctor_s3typelst, fopr3, map_ctor) where {
      fun fopr3 
      }
      val 


    // todo
// typedef s3datatype =
// '{
//   s3datatype_s2cst = s2cst
//   // type variables, e.g.
//   // mylist0 (a:t@ype, b:t@ype)
//   , s3datatype_s2varlst = s2varlst
//   , s3datatype_ctorlst = s3ctorlst
// }

// typedef datatype0info = 
// '{ datatype0info_name = s2cst
//  , datatype0info_marshall = type0lst
//  , datatype0info_ctors = type0ctorlst
// }

  in
    dtmap
  end
  }
in dtmap end


