

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

#include "./../postiats/postiats_codegen2.hats"
#include "./simpletypes_codegen2.hats"

(* ************ ************* *)

implement s3type_translate_S3Eapp_con (s2cst) = let
  val name = (s2cst_get_name (s2cst)).tostring ()
in
  case+ name of
  | "g0int_t0ype" => Some0 (s3type_int ())
  | "g1int_int_t0ype" => Some0 (s3type_int ())
  | "bool_bool_t0ype" => Some0 (s3type_bool ())
  | "int" => Some0 (s3type_int ())
  | "bool" => Some0 (s3type_bool ())
  // todo add more type constructors here if needed
  | str => let
    // val () = if isdebug then let
    //   val () = fprint (stderr_ref, str + " is encountered. This is " + $mylocation + "\n")
    // in end
  in
    None0 ()
  end
end


implement s3type_translate (s2exp) = let
val srt = s2exp.s2exp_sort
in
if ~s2rt_is_type (srt) then None0 ()
else let
val node = s2exp.s2exp_node
in
case+ node of
| S2Ecst (s2cst) => let
  // val () = fprint (stderr_ref, "s2cst is ")
  // val () = fprint_s2cst (stderr_ref, s2cst)
  // val () = fprint (stderr_ref, "\n")
  val name = (s2cst_get_name (s2cst)).tostring ()
in
  case+ name of
  | "int" => Some0 (s3type_int ())
  //
  | "bool_t0ype" => Some0 (s3type_bool ())
  | "bool" => Some0 (s3type_bool ())
  //
  | "void" => Some0 (s3type_unit ())
  | "atsvoid_t0ype" => Some0 (s3type_unit ())
  //
  | "char" => Some0 (s3type_char ())
  | "char_t0ype" => Some0 (s3type_char ())
  //
  | _ => Some0 (S3TYPEcon (s2cst, nil0 ()))
end
//
| S2Evar (s2var) => Some0 (S3TYPEvar (s2var))
//
| S2Eextkind (symbol) => exitlocmsg ("S2Eextkind should not be seen.")
//
| S2Eapp (s2exp1, s2explst) => let
  val- S2Ecst (s2cst_con) = s2exp1.s2exp_node

  val tyopt = s3type_translate_S3Eapp_con (s2cst_con)
in
  case+ tyopt of
  | Some0 ty => tyopt
  | None0 () => let
    val args = s3type_translate_s2explst (s2explst)
  in
    Some0 (S3TYPEcon (s2cst_con, args))
  end
end
//
| S2Eeqeq (s2exp1, s2exp2) => exitlocmsg ("This shall not happen.")
//
| S2Eexi (s2varlst, s2explst (*predicates*), s2exp (*body*)) =>
    s3type_translate (s2exp)  // todo: Is this the correct way?
//
| S2Euni (s2varlst, s2explst (*predicates*), s2exp (*body*)) => let
  val s2varlst = list0_foldright<s2var><s2varlst> (s2varlst, fopr, nil0) where {
  fun fopr (s2var: s2var, res: s2varlst):<cloref1> s2varlst = let
    val srt = s2var_get_sort (s2var)
  in
    if s2rt_is_type (srt) then cons0 (s2var, res)
    else res
  end
  }

  val- Some0 (s3type) = s3type_translate (s2exp)
in
  if length (s2varlst) > 0 then Some0 (S3TYPEpoly (s2varlst, s3type))
  else Some0 s3type
end
| S2Efun (npf, s2explst (*args*), s2exp (*res*)) => let
  val ty_args = s3type_translate_s2explst (s2explst)
  val- Some0 (ty_ret) = s3type_translate (s2exp)

  val ty_fun = S3TYPEfun (ref npf, ty_args, ty_ret, ~1)
in
  Some0 ty_fun
end
//
| S2Eint n => exitlocmsg ("This shall not happen.")
//
| S2Eintinf n => exitlocmsg ("This shall not happen.")
//
| S2Einvar (s2exp) => exitlocmsg ("Check this.\n")
//
| S2Esizeof s2exp => exitlocmsg ("This shall not happen.")
//
| S2Etyrec (knd, npf, labs2explst) => let
  val labeltypelst = list0_foldright<labs2exp><s3labeltypelst> (
    labs2explst, fopr, nil0 ()) where {
  fun fopr (labs2exp: labs2exp
    , res: s3labeltypelst):<cloref1> s3labeltypelst = let
    val label = labs2exp.labs2exp_label
    val s2exp = labs2exp.labs2exp_s2exp
    val- Some0 (s3type) = s3type_translate (s2exp)
    val labeltype = s3labeltype_make (label, s3type)
  in
    cons0 (labeltype, res)
  end
  }

  val ty = S3TYPErecord (ref (s3tkind_make (knd)), npf, labeltypelst)
in
  Some0 ty
end
//
(* This is for the return type of a function whose parameters use
* reference type.
*)
| S2Ewthtype (s2exp, wths2explst) => let
  val s3typeopt = s3type_translate (s2exp)
  // val wths3typelst = s3type_translate_wths2explst (wths2explst)
in
  case+ s3typeopt of
  | Some0 (s3type) => None0 () // todo Some0 (S3TYPEwthtype (s3type, wths3typelst))
  | None0 () => s3typeopt
end
| S2Etop (s2exp) => s3type_translate (s2exp)
| S2Erefarg (s2exp) => let
  val- Some0 (s3type) = s3type_translate (s2exp)
in
  Some0 (S3TYPErefarg s3type)
end
| S2Eignored () => None0 ()
| S2Eerr () => None0 ()
end
end  // end of [s3type_translate]


implement s3type_translate_s2explst (s2explst) = let
  val res = list0_foldright<s2exp><s3typelst> (s2explst, fopr, nil0) where {
  fun fopr (s2exp: s2exp, res: s3typelst):<cloref1> s3typelst = let
    val s3typeopt = s3type_translate (s2exp)
  in
    case+ s3typeopt of
    | Some0 s3type => cons0 (s3type, res)
    | None0 () => res
  end
  }
in
  res
end
