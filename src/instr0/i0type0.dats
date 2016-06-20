

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./../simpletypes/simpletypes.sats"
staload "./instr0.sats"

#include "./../instr0/instr0_codegen2.hats"


(* ************ ************* *)
implement fprint_val<type0> = myfprint_type0
implement fprint_val<s2cst> = fprint_s2cst
implement fprint_val<symbol> = fprint_symbol
implement fprint_val<type0ctor> (out, tc) = let
  val () = fprint_symbol (out, tc.0)
  val () = fprint_val (out, tc.1)
in
end

implement myfprint_type0 (out, type0) = fprint_type0<> (out, type0)

(* ************ ************* *)

implement type0_translate (s3type) = let
val s3type = s3type_normalize (s3type)
in
case+ s3type of
| S3TYPEref (s3typeopt_ref) =>
  (
  case+ !s3typeopt_ref of
  | Some0 s3type => type0_translate (s3type)
  | None0 () => exitlocmsg ("This shall not happen.\n")
  )
//
| S3TYPErefarg (s3type) => let
  val type0 = type0_translate (s3type)
in
  TYPE0ref (type0)
end
//
| S3TYPEelement (s3element) =>
  (
  case+ s3element of
  | S3ELEMENTint () => TYPE0int
  | S3ELEMENTchar () => TYPE0char
  | S3ELEMENTbool () => TYPE0bool
  | S3ELEMENTstring () => exitlocmsg ("String is not supported.\n")
  | S3ELEMENTunit () => TYPE0unit
  )
//
| S3TYPErecord (s3tkindref, npf, s3labeltypelst) => 
  exitlocmsg ("S3TYPErecord not supported.\n")
//
| S3TYPEprop () =>
  exitlocmsg ("S3TYPEprop not supported.\n")
//
| S3TYPEcon (s2cst, s3typelst) => TYPE0symbol (s2cst_get_name (s2cst))
| S3TYPEfun (npfref
             , s3typelst (*args*)
             , s3type (*res*)
             , effect (*effect: -1: ignored, 0: false, 1: true*)) => let
  val type0lst = type0_translate_s3typelst (s3typelst)
  val type0 = type0_translate (s3type)
in
  TYPE0fun (type0lst, type0)
end
| S3TYPEvar s2var => exitlocmsg ("This should not happen.\n")
| S3TYPEpoly (s2varlst, s3type) => TYPE0ignored ()
| S3TYPEignored () => exitlocmsg ("Check this.\n")
end

implement type0_translate_s3typelst (s3typelst) = let
  val res = list0_foldright<s3type><type0lst> (s3typelst, fopr, nil0) where {
  fun fopr (s3type: s3type, res: type0lst):<cloref1> type0lst = let
    val type0 = type0_translate (s3type)
  in
    cons0 (type0, res)
  end
  }
in
  res
end

implement type0_is_ref (type0) =
case+ type0 of
| TYPE0ref (type0) => true
| _ => false

