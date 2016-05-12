
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

staload "./instr0.sats"
staload "./../postiats/utfpl.sats"
staload "./../utils/emiter.sats"

datatype i0id_t =
| ID0sym of (i0name, stamp)  // , type0)
| ID0cst of (i0name, stamp, option0 string (*extdef*))  // , type0)
| ID0var of (i0name, stamp)  // , type0)

assume i0id = i0id_t

implement i0id_make_sym (i0name, stamp) =
  ID0sym (i0name, stamp)

implement i0id_is_sym (i0id) =
case+ i0id of
| ID0sym _ => true
| ID0cst _ => false
| ID0var _ => false

implement i0id_is_cst (i0id) =
case+ i0id of
| ID0sym _ => false
| ID0cst _ => true
| ID0var _ => false

implement i0id_is_var (i0id) =
case+ i0id of
| ID0sym _ => false
| ID0cst _ => false
| ID0var _ => true

implement i0id_make_cst (i0name, stamp, extdef_opt) =
  ID0cst (i0name, stamp, extdef_opt)

implement i0id_make_var (i0name, stamp) =
  ID0var (i0name, stamp)

implement i0id_get_name (i0id) = 
case+ i0id of
| ID0sym (i0name, stamp) => i0name
| ID0cst (i0name, stamp, _) => i0name
| ID0var (i0name, stamp) => i0name

implement i0id_get_stamp (i0id) = 
case+ i0id of
| ID0sym (i0name, stamp) => stamp
| ID0cst (i0name, stamp, _) => stamp
| ID0var (i0name, stamp) => stamp

implement i0id_get_extdef (i0id) =
case+ i0id of
| ID0cst (i0name, stamp, extdef_opt) => extdef_opt
| _ => None0


implement i0id_copy (i0id, sa) = let
  val- ID0var (name, stamp) = i0id
  val stamp = stamp_allocate (sa)
in
  ID0var (name, stamp)  // , type0)
end

implement fprint_i0id (out, i0id) = 
case+ i0id of
| ID0sym (i0name, stamp) => fprint (out, i0name)
| ID0cst (i0name, stamp, _) => fprint (out, i0name)
| ID0var (i0name, stamp) => let
  val () = fprint! (out, i0name, "_", stamp)
in
end

implement eq_i0id_i0id (x, y) = 
case+ (x, y) of
| (ID0sym (name1, stamp1), ID0sym (name2, stamp2)) =>
    stamp1 = stamp2
    // eq_i0name_i0name (name1, name2)
| (ID0cst (name1, stamp1, _), ID0cst (name2, stamp2, _)) =>
    stamp1 = stamp2
    // eq_i0name_i0name (name1, name2)
| (ID0var (name1, stamp1), ID0var (name2, stamp2)) =>
    stamp1 = stamp2
| (_, _) => false

implement emit_i0id (id) = let
  val unique_name = tostring_i0id (id)
in
  EUstring (unique_name)
end

implement tostring_i0id (id) = 
case+ id of
| ID0sym (i0name, _) => tostring_i0name (i0name)
| ID0cst (i0name, stamp, _) => tostring_i0name (i0name)
| ID0var (i0name, stamp) => let
  val name = tostring_i0name (i0name)
  val stamp = tostring_stamp (stamp)
in
  name + "_" + stamp
end

implement tostring_i0id_name (id) = 
case+ id of
| ID0sym (i0name, _) => tostring_i0name (i0name)
| ID0cst (i0name, stamp, _) => tostring_i0name (i0name)
| ID0var (i0name, stamp) => tostring_i0name (i0name)




