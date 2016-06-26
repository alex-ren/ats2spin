
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

staload "./instr0.sats"
staload "./../postiats/postiats.sats"
staload "./../utils/emiter.sats"

datatype i0id_t =
| ID0sym of (i0name)  // , type0)
| ID0cst of (i0name, stamp, option0 string (*extdef*), type0)
| ID0con of (i0name, stamp, type0)
| ID0var of (i0name, stamp, type0)

assume i0id = i0id_t

implement i0id_make_sym (i0name) =
  ID0sym (i0name)

implement i0id_is_sym (i0id) =
case+ i0id of
| ID0sym _ => true
| ID0cst _ => false
| ID0con _ => false
| ID0var _ => false

implement i0id_is_cst (i0id) =
case+ i0id of
| ID0sym _ => false
| ID0cst _ => true
| ID0con _ => false
| ID0var _ => false

implement i0id_is_var (i0id) =
case+ i0id of
| ID0sym _ => false
| ID0cst _ => false
| ID0con _ => false
| ID0var _ => true

implement i0id_make_cst (i0name, stamp, extdef_opt, type0) =
  ID0cst (i0name, stamp, extdef_opt, type0)


implement i0id_make_con (i0name, stamp, type0) =
  ID0con (i0name, stamp, type0)

implement i0id_make_var (i0name, stamp, type0) =
  ID0var (i0name, stamp, type0)

implement i0id_get_name (i0id) = 
case+ i0id of
| ID0sym (i0name) => i0name
| ID0cst (i0name, stamp, _, _) => i0name
| ID0con (i0name, stamp, _) => i0name
| ID0var (i0name, stamp, _) => i0name

implement i0id_get_stamp (i0id) = 
case+ i0id of
| ID0sym (i0name) => $effmask_all (exitlocmsg ("Symbol has no stamp.\n"))
| ID0cst (i0name, stamp, _, _) => stamp
| ID0con (i0name, stamp, _) => stamp
| ID0var (i0name, stamp, _) => stamp

implement i0id_get_type (i0id) = 
case+ i0id of
| ID0sym (i0name) => $effmask_all (exitlocmsg ("Symbol has no type.\n"))
| ID0cst (i0name, stamp, _, ty) => ty
| ID0con (i0name, stamp, ty) => ty
| ID0var (i0name, stamp, ty) => ty

implement i0id_get_extdef (i0id) =
case+ i0id of
| ID0cst (i0name, stamp, extdef_opt, _) => extdef_opt
| _ => None0


implement i0id_copy (i0id, sa) = let
  val- ID0var (name, stamp, type0) = i0id
  val stamp = stamp_allocate (sa)
in
  ID0var (name, stamp, type0)
end

fun i0name_copy_remove_prefix_inline (
  i0name: i0name) = let
  val str = tostring_i0name i0name
  val nstr_opt = str.removePrefix (PML_INLINE)
in
  case+ nstr_opt of
  | Some nstr => let
    val symbol = symbol_make (nstr)
    val ni0name = i0name_make (symbol)
  in
    ni0name
  end
  | None () => i0name
end

implement i0id_copy_remove_prefix_inline (i0id, sa) =
case+ i0id of
| ID0sym (i0name) => let
  val ni0name = i0name_copy_remove_prefix_inline (i0name)
  // val nstamp = stamp_allocate (sa)
in
  ID0sym (ni0name)
end
| ID0cst (i0name, _, extdef_opt, type0) => let
  val ni0name = i0name_copy_remove_prefix_inline (i0name)
  val nstamp = stamp_allocate (sa)
in
  ID0cst (ni0name, nstamp, extdef_opt, type0)
end
| ID0con (i0name, _, type0) => exitlocmsg ("Check this.\n")
| ID0var (i0name, _, type0) => let
  val ni0name = i0name_copy_remove_prefix_inline (i0name)
  val nstamp = stamp_allocate (sa)
in
  ID0var (ni0name, nstamp, type0)
end

implement fprint_i0id (out, i0id) = 
case+ i0id of
| ID0sym (i0name) => fprint (out, i0name)
| ID0cst (i0name, stamp, _, type0) => let
  val () = fprint (out, "(")
  val () = fprint (out, i0name)
  val () = fprint (out, ": ")
  val () = fprint (out, type0)
  val () = fprint (out, ")")
in end
| ID0con (i0name, stamp, type0) => let
  val () = fprint! (out, i0name, "_", stamp)
in end
| ID0var (i0name, stamp, type0) => let
  val () = fprint (out, "(")
  val () = fprint! (out, i0name, "_", stamp)
  val () = fprint (out, ": ")
  val () = fprint (out, type0)
  val () = fprint (out, ")")
in end

implement eq_i0id_i0id (x, y) = 
case+ (x, y) of
| (ID0sym (name1), ID0sym (name2)) =>
    name1 = name2
    // eq_i0name_i0name (name1, name2)
| (ID0cst (name1, stamp1, _, _), ID0cst (name2, stamp2, _, _)) =>
    stamp1 = stamp2
    // eq_i0name_i0name (name1, name2)
| (ID0con (name1, stamp1, _), ID0con (name2, stamp2, _)) =>
    stamp1 = stamp2
| (ID0var (name1, stamp1, _), ID0var (name2, stamp2, _)) =>
    stamp1 = stamp2
| (_, _) => false

implement emit_i0id (id) = let
  val unique_name = tostring_i0id (id)
in
  EUstring (unique_name)
end

implement tostring_i0id (id) = 
case+ id of
| ID0sym (i0name) => tostring_i0name (i0name)
| ID0cst (i0name, stamp, extdef_opt, _) =>
  (
  case+ extdef_opt of
  | Some0 extname => extname
  | None0 () => tostring_i0name (i0name)
  )
| ID0con (i0name, stamp, _) => let
  val name = tostring_i0name (i0name)
  val stamp = tostring_stamp (stamp)
in
  name + "_" + stamp
end
| ID0var (i0name, stamp, _) => let
  val name = tostring_i0name (i0name)
  val stamp = tostring_stamp (stamp)
in
  name + "_" + stamp
end

implement tostring_i0id_name (id) = 
case+ id of
| ID0sym (i0name) => tostring_i0name (i0name)
| ID0cst (i0name, stamp, _, _) => tostring_i0name (i0name)
| ID0con (i0name, stamp, _) => tostring_i0name (i0name)
| ID0var (i0name, stamp, _) => tostring_i0name (i0name)




