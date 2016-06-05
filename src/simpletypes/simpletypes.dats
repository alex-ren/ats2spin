

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

(* ************ ************* *)
implement s3type_get_funtype (s3type) =
case+ s3type.s3type_node of
| S3TYPEfun (_, _, _, _) => s3type
| S3TYPEpoly (_, s3type') => s3type_get_funtype (s3type')
| _ => exitlocmsg ("This is not allowed.\n")


implement s3type_get_rettype (s3type) =
case+ s3type.s3type_node of
| S3TYPEfun (_, _, ret, _) => ret
| _ => exitlocmsg ("This is not allowed.\n")

(* ************ ************* *)

implement s3typecheck_d2eclist (d2ecs, tmap) = let
  implement list_foldleft$fopr<s3typemap><d2ecl> (acc, x) = let
    val () = s3typecheck_d2ecl (x, acc)
  in
    acc
  end

  val tmap = list_foldleft<s3typemap><d2ecl> (d2ecs, tmap)
in end

extern fun s3typecheck_D2Cimpdec (s3typemap, d2ecl): void
extern fun s3typecheck_D2Cfundecs (s3typemap, d2ecl): void
extern fun s3typecheck_D2Cvaldecs (s3typemap, d2ecl): void
extern fun s3typecheck_D2Cvardecs (s3typemap, d2ecl): void
extern fun s3typecheck_D2Cdcstdecs (s3typemap, d2ecl): void
extern fun s3typecheck_D2Clocal (s3typemap, d2ecl): void
extern fun s3typecheck_D2Cextcode (s3typemap, d2ecl): void
extern fun s3typecheck_D2Cignored (s3typemap, d2ecl): void

implement s3typecheck_d2ecl (d2ecl, tmap) = let
  val d2ecl_node = d2ecl.d2ecl_node
in
  case+ d2ecl_node of
  | D2Cimpdec (knd, i2mpdec) => 
      s3typecheck_D2Cimpdec (tmap, d2ecl)
  | D2Cfundecs (funkind, f2undeclst) => 
      s3typecheck_D2Cfundecs (tmap, d2ecl)
  | D2Cvaldecs (valkind, v2aldeclst) => 
      s3typecheck_D2Cvaldecs (tmap, d2ecl)
  | D2Cvardecs (v2ardeclst) => 
      s3typecheck_D2Cvardecs (tmap, d2ecl)
  | D2Cdcstdecs (n, d2cst) => 
      s3typecheck_D2Cdcstdecs (tmap, d2ecl)
  | D2Clocal (head, body) => 
      s3typecheck_D2Clocal (tmap, d2ecl)
  | D2Cextcode (code) => ()
  | D2Cignored ((*void*)) => let
    val () = fprint! ("D2Cignored encountered in type checking.\n")
  in end
end

//
implement s3typecheck_D2Cimpdec (tmap, d2ecl) = let
  val- D2Cimpdec (knd, i2mpdec) = d2ecl.d2ecl_node
  val s3type_d2exp = i2mpdec.i2mpdec_def.oftype (tmap)
  val () = case+ s3type_d2exp.s3type_node of
           | S3TYPEfun (_, _, _, _) => ()
           | S3TYPEpoly (_, _) => ()
           | _ => () (* Check this *)
in end

//
implement s3typecheck_D2Cfundecs (tmap, d2ecl) = let
  val- D2Cfundecs (funknd, f2undeclst) = d2ecl.d2ecl_node
  // clooect type information from function headers
  implement list_foldleft$fopr<s3typemap><f2undec> (acc, x) = let
    val _ = oftype_f2undec_head (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><f2undec> (f2undeclst, tmap)

  // type checking function body
  implement list_foldleft$fopr<s3typemap><f2undec> (acc, x) = let
    val () = s3typecheck_f2undec_body (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><f2undec> (f2undeclst, tmap)
in end

//
implement s3typecheck_D2Cvaldecs (tmap, d2ecl) = let
  val- D2Cvaldecs (valkind, v2aldeclst) = d2ecl.d2ecl_node

  implement list_foldleft$fopr<s3typemap><v2aldec> (acc, x) = let
    val () = s3typecheck_v2aldec (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><v2aldec> (v2aldeclst, tmap)
in end

//
implement s3typecheck_D2Cvardecs (tmap, d2ecl) = let
  val- D2Cvardecs (v2ardeclst) = d2ecl.d2ecl_node

  implement list_foldleft$fopr<s3typemap><v2ardec> (acc, x) = let
    val () = s3typecheck_v2ardec (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><v2ardec> (v2ardeclst, tmap)
in end

//
implement s3typecheck_D2Cdcstdecs (tmap, d2ecl) = let
  val- D2Cdcstdecs (n, d2cst) = d2ecl.d2ecl_node
in exitlocmsg ("todo\n") end

//
implement s3typecheck_D2Clocal (tmap, d2ecl) = let
  val- D2Clocal (head, body) = d2ecl.d2ecl_node

  implement list_foldleft$fopr<s3typemap><d2ecl> (acc, x) = let
    val () = s3typecheck_d2ecl (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><d2ecl> (head, tmap)

  implement list_foldleft$fopr<s3typemap><d2ecl> (acc, x) = let
    val () = s3typecheck_d2ecl (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><d2ecl> (body, tmap)
in end

//

implement s3typecheck_f2undec_body (f2undec, tmap) = let
  val s3type = f2undec.f2undec_var.oftype (tmap)
  val funtype = s3type_get_funtype (s3type)
  val rettype = s3type_get_rettype (funtype)

  val retexp = d2exp_expose_lam_dyn (f2undec.f2undec_def)
  val () = s3typecheck_d2exp (retexp, rettype, tmap)
in end

implement s3typecheck_d2exp (d2exp, s3type, tmap) = let
  val exp_type = d2exp.oftype (tmap)
  val tcres = type_match (tmap, exp_type, s3type)
in
  case+ tcres of
  | None0 () => ()
  | Some0 (msg) => 
      exitlocmsg ("Type mismatch d2exp: " + msg + "\n" +
      d2exp.d2exp_loc.tostring ())
end

(* ******************* ******************* *)

















