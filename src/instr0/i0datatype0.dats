

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
implement fprint_val<stamp> = fprint_stamp
implement fprint_val<type0> = myfprint_type0


// typedef datatype0info = 
// '{ datatype0info_name = s2cst
//  , datatype0info_marshall = type0lst
//  , datatype0info_ctors = type0ctorlst
// }
implement fprint_val<datatype0info> (out, dtinfo) = let
  val () = fprint_s2cst (out, dtinfo.datatype0info_name)
  val () = fprint (out, "(")
  val () = fprint (out, dtinfo.datatype0info_marshall)
  val () = fprint (out, ")")
in end

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


implement fprint_datatype0map (out, dtmap) =
$HT.fprint_hashtbl (out, dtmap)

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
  val opt = $HT.hashtbl_insert (dtmap, s2cst_get_stamp (s2cst), info)
  val () = option_vt_free (opt)
in end

(* ****************** ****************** *)

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
  val opt = $HT.hashtbl_insert (map, type0, info)
  val () = option_vt_free (opt)
in end

fun type0_int_map_add (map: type0_int_map, type0: type0): void = let
  val itmopt = type0_int_map_find0 (map, type0)
  // val () = fprintln! (stderr_ref, "type0_int_map_add")
in
  case+ itmopt of
  | Some0 (itm) => type0_int_map_insert0 (map, type0, itm + 1)
  | None0 () => type0_int_map_insert0 (map, type0, 1)
end

// map0: be updated
fun type0_int_map_merge0 (
  map0: type0_int_map, map1: type0_int_map): void = let
  val () = $HT.hashtbl_foreach_cloref<type0, int> (map1, fopr) where {
  fun fopr (key: type0, v: &int >> _):<cloref1> void = let
    val itmopt = type0_int_map_find0 (map0, key)
  in
    case+ itmopt of
    | Some0 (itm) =>
      if (itm >= v) then let
        // val () = fprintln! (stderr_ref, "itm is ", itm, " v is ", v)
      in end
      else let
        val () = type0_int_map_insert0 (map0, key, v)
      in end
    | None0 () =>let
      val () = type0_int_map_insert0 (map0, key, v)
    in  end
  end
  }
in end  // end of [type0_int_map_merge0]

fun type0_int_map_foreach (
  map: type0_int_map
  , fopr: (type0, &int >> _)-<cloref1> void): void =
  $HT.hashtbl_foreach_cloref (map, fopr)

fun type0_int_map_clone (map: type0_int_map): type0_int_map = let
  val ret = $HT.hashtbl_make_nil<type0, int> (i2sz (2048))
  val () = $HT.hashtbl_foreach_cloref (map, fopr) where {
  fun fopr (key: type0, itm: &int >> _):<cloref1> void = let
    val () = $HT.hashtbl_insert_any (ret, key, itm)
  in end
  }
in
  ret
end

end  // end of [local]

(* ****************** ****************** *)

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

    // handle all construtors, round 1
    // merge all the type list from constructors
    val type0_int_map = type0_int_map_create0 ()
    val type0_int_map =
      list0_foldleft<s3ctor><type0_int_map> (
      s3datatype_ctorlst, type0_int_map, fopr2) where {
    fun fopr2 (map: type0_int_map, s3ctor: s3ctor):<cloref1> type0_int_map = let

      // val () = fprint! (stderr_ref, "hanlde constructor ")
      // val () = fprint_d2con (stderr_ref, s3ctor.s3ctor_ctor)
      // val () = fprintln! (stderr_ref)

      // Put all the types in one constructor into a map.
      val map_ctor = type0_int_map_create0 ()
      val map_ctor = list0_foldleft<s3type><type0_int_map> (
        s3ctor.s3ctor_s3typelst, map_ctor, fopr3) where {
      fun fopr3 (map: type0_int_map, s3type: s3type):<cloref1> type0_int_map = let
        val type0 = type0_translate (s3type)
        val () = type0_int_map_add (map, type0)
      in
        map
      end
      }
      // update map
      val () = type0_int_map_merge0 (map, map_ctor)
    in
      map
    end
    }  // end of [handing all constructor, round 1]

    // Summary information for types and set positions for them.
    val ref_tylst: ref (type0lst) = ref (nil0 ())
    val timap = type0_int_map_create0 ()
    val ref_count: ref (int) = ref (0)
    val () = type0_int_map_foreach (type0_int_map, fopr) where {
    fun fopr (type0: type0, num: &int >> _):<cloref1> void = let
      fun add_num (type0lst: type0lst, n: int, type0: type0): type0lst =
      if n > 0 then add_num (cons0 (type0, type0lst), n - 1, type0)
      else type0lst

      val type0lst = add_num (!ref_tylst, num, type0)
      val () = !ref_tylst := type0lst

      val () = type0_int_map_insert0 (timap, type0, !ref_count)
      val () = !ref_count := !ref_count + num
    in end
    }
    val marshall = list0_reverse (!ref_tylst)

    // handle all construtors, round 2
    // merge all the type list from constructors
    val ctors =
      list0_foldright<s3ctor><type0ctorlst> (
      s3datatype_ctorlst, fopr, nil0 ()) where {
    fun fopr (s3ctor: s3ctor, res: type0ctorlst):<cloref1> type0ctorlst = let
      val timap1 = type0_int_map_clone (timap)
      // Assign position to each type in the constructor.

      typedef typoslst = list0 '(int, type0)
      val typoslst = list0_foldright<s3type><typoslst> (
        s3ctor.s3ctor_s3typelst, fopr, nil0 ()) where {
      fun fopr (s3type: s3type, res: typoslst):<cloref1> typoslst = let
        val type0 = type0_translate (s3type)
        val- Some0 (pos) = type0_int_map_find0 (timap1, type0)
        val typos = '(pos, type0)
        val res = cons0 (typos, res)
        val () = type0_int_map_insert0 (timap1, type0, pos + 1)
      in res end
      }

      val type0ctor = '(s3ctor.s3ctor_ctor, typoslst)
      val res = cons0 (type0ctor, res)
    in
      res
    end
    }  // end of [handle all constructors, round 2]

    val datatype0info = '{
      datatype0info_name = s3datatype.s3datatype_s2cst
      , datatype0info_marshall = marshall
      , datatype0info_ctors = ctors
    }

    val () = datatype0map_insert0 (dtmap, s3datatype.s3datatype_s2cst, datatype0info)

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

// typedef s3ctor =
// '{
//   s3ctor_ctor = d2con
//   , s3ctor_s3typelst = s3typelst
// }

// type0ctor = '(d2con (*constructor*), list0 ('(int (*mapped position*), type0)))

  in
    dtmap
  end
  }
in dtmap end



