

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

#include "./simpletypes_codegen2.hats"

(* ************ ************* *)

implement s3type_int () = S3TYPEelement (S3ELEMENTint)
implement s3type_char () = S3TYPEelement (S3ELEMENTchar)
implement s3type_bool () = S3TYPEelement (S3ELEMENTbool)
implement s3type_string () = S3TYPEelement (S3ELEMENTstring)
implement s3type_unit () = S3TYPEelement (S3ELEMENTunit)

implement s3type_ref () = S3TYPEref (ref<option0 s3type> (None0 ()))

(* ************ ************* *)
implement s3type_get_funtype (s3type) =
case+ s3type of
| S3TYPEfun (_, _, _, _) => s3type
| S3TYPEpoly (_, s3type') => s3type_get_funtype (s3type')
| _ => exitlocmsg ("This is not allowed.\n")


implement s3type_get_rettype (s3type) =
case+ s3type of
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
  val () = case+ s3type_d2exp of
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
  val loc = f2undec.f2undec_loc
  val s3type = f2undec.f2undec_var.oftype (tmap, loc)
  val funtype = s3type_get_funtype (s3type)
  val rettype = s3type_get_rettype (funtype)

  val retexp = d2exp_expose_lam_dyn (f2undec.f2undec_def)
  val () = s3typecheck_d2exp (retexp, rettype, tmap)
in end

implement s3typecheck_d2exp (d2exp, s3type, tmap) = let
  val exp_type = d2exp.oftype (tmap)
  val tcres = s3type_match (tmap, exp_type, s3type)
in
  case+ tcres of
  | None0 () => ()
  | Some0 (msg) => 
      exitlocmsg ("Type mismatch d2exp: " + msg + "\n" +
      d2exp.d2exp_loc.tostring ())
end

(* ******************* ******************* *)

implement oftype_d2cst (d2cst, tmap, loc) = let
  val s3typeopt = s3typemap_find_d2cst (tmap, d2cst)
in
  case+ s3typeopt of
  | None0 () => let
    val s2exp = d2cst_get_type (d2cst)
    val s3type = s3type_translate (s2exp)
    val () = s3typemap_update_d2cst (tmap, d2cst, s3type)
  in
    s3type
  end
  | Some0 (s3type) => s3type
end

implement oftype_d2var (d2var, tmap, loc) = let
  val vartype = s3type_ref ()
  val () = s3typemap_update_d2var (tmap, d2var, vartype)
in
  vartype
end

implement oftype_d2sym (d2sym, tmap, loc) = let
  val s3typeopt = s3typemap_find_d2sym (tmap, d2sym)
in
  case+ s3typeopt of
  | None0 () => let
    val vartype = s3type_ref ()
    val () = s3typemap_update_d2sym (tmap, d2sym, vartype)
  in
    vartype
  end
  | Some0 (s3type) => s3type
end

fun oftype_D2Eapplst (
  d2exp: d2exp
  , d2exparglst: d2exparglst
  , tmap: s3typemap
  , loc: location_type): s3type = let
  val s3type_fun = oftype_d2exp (d2exp, tmap)
  val s3type_fun = s3type_normalize (s3type_fun)

  fun loop_s3type (s3type: s3type
            , d2exparglst: d2exparglst
            , inner_types: s3typelst
            , loc: location_type): (s3type, s3typelst) =
  case+ s3type of
  | S3TYPEpoly (_, _) =>
    loop_poly (s3type, d2exparglst, inner_types, loc)
  | S3TYPEfun (_, _, _, _) =>
    loop_fun (s3type, d2exparglst, inner_types, loc)
  | S3TYPEref (_) =>
    loop_ref (s3type, d2exparglst, inner_types, loc)
  | _ => exitlocmsg ("typechecking " + 
                     datcon_s3type s3type + " is not supported currently.")

  and loop_poly (s3type: s3type
            , d2exparglst: d2exparglst
            , inner_types: s3typelst
            , loc: location_type): (s3type, s3typelst) = let
    fun instantiate_one (s2varlst, s3type): s3type = let
      val poly_para_map = s3poly_para_map_create ()
      val poly_para_map = 
        list0_foldleft<s2var><s3poly_para_map> (
          s2varlst, poly_para_map, fopr) where {
      fun fopr (res: s3poly_para_map, x: s2var):<cloref1> s3poly_para_map = let
        val () = s3poly_para_map_insert (res, x, s3type_ref ())
      in res end
      }

      val ret = s3type_instantiate (s3type, poly_para_map)
    in
      ret
    end
    val- list_cons (args0, d2exparglst1) = d2exparglst
  in
    case+ args0 of
    | D2EXPARGsta () => let
      // Since currently D2EXPARGsta is not ported into JSON,
      // I use S3TYPEref for all of them.
      val- S3TYPEpoly (s2varlst, s3type_body) = s3type

      val s3type_body = instantiate_one (s2varlst, s3type_body)
      val inner_types1 = cons0 (s3type_body, inner_types)
    in
      case+ d2exparglst1 of
      | list_cons (_, _) => 
          loop_s3type (s3type_body, d2exparglst1, inner_types1, loc)
      | list_nil () => (s3type_body, list0_reverse (inner_types1))
    end
    | D2EXPARGdyn (npf, loc, d2explst(*args*)) => let

      fun loop (polytype: s3type): s3type = let
        val- S3TYPEpoly (s2varlst, s3type_body) = polytype
        val s3type_body = instantiate_one (s2varlst, s3type_body)
      in
        case+ s3type_body of
        | S3TYPEfun (_, _, _, _) => s3type_body
        | S3TYPEpoly (_, _) => loop (s3type_body)
        | _ => exitlocmsg ("Check this.\n")
      end

      val s3type_body = loop (s3type)
    in
      loop_fun (s3type_body, d2exparglst, inner_types, loc)
    end
  end  // end of [loop_poly]

  and loop_fun (s3type: s3type (*funtion type*)
            , d2exparglst: d2exparglst
            , inner_types: s3typelst
            , loc: location_type): (s3type, s3typelst) = let
    val- S3TYPEfun (npf_ty, ty_args, ty_res, effect) = s3type
    val- list_cons (args0, d2exparglst1) = d2exparglst
    val- D2EXPARGdyn (npf_args, loc_args, d2expargs) = args0
  in
    if (length (ty_args) <> length (d2expargs) || npf_ty <> npf_args)
    then exitlocmsg (
      "Type mismatched: " + loc.tostring () + " different length.\n")
    else let
      val () = loop_type_checker (d2expargs, ty_args) where {
      fun loop_type_checker (
        d2explst: d2explst , s3typelst: s3typelst): void =
      case+ (d2explst, s3typelst) of
      | (list_cons (d2exp, d2explst1), cons0 (s3type, s3typelst1)) => let
        val () = s3typecheck_d2exp (d2exp, s3type, tmap)
      in
        loop_type_checker (d2explst1, s3typelst1)
      end
      | (list_nil (), nil0 ()) => ()
      | (_, _) => exitlocmsg (
      "Type mismatched: " + loc.tostring () + " different length.\n")
      }

      val inner_types1 = cons0 (ty_res, inner_types)
    in
      case+ d2exparglst1 of
      | list_cons (_, _) => 
         loop_s3type (ty_res, d2exparglst1, inner_types1, loc)
      | list_nil () => (ty_res, list0_reverse (inner_types1))
    end
  end  // end of [loop_fun]
      
  and loop_ref (s3type: s3type
            , d2exparglst: d2exparglst
            , inner_types: s3typelst
            , loc: location_type): (s3type, s3typelst) = let
  val- S3TYPEref vartype = s3type
  in
  case+ !vartype of
  | Some0 (_) => exitlocmsg ("Should be uninitialized.\n")
  | None0 () => let
    val- list_cons (args0, d2exparglst1) = d2exparglst
  in
    case+ args0 of
    // Static argument is neglected since related information is
    // not exported into JSON yet.
    // This may cause problem if it's of sort type.
    | D2EXPARGsta () => let
      val inner_types1 = cons0 (s3type, inner_types)
    in
      case+ d2exparglst1 of
      | list_cons (_, _) => 
          loop_s3type (s3type, d2exparglst1, inner_types1, loc)
      | list_nil () => (s3type, list0_reverse (inner_types1))
    end
    | D2EXPARGdyn (npf, loc, d2explst(*args*)) => let
      implement list_foldright$fopr<d2exp><s3typelst> (x, acc) = let
        val ty = oftype_d2exp (x, tmap)
        val acc1 = cons0 (ty, acc)
      in acc1 end

      val ty_args = list_foldright<d2exp><s3typelst> (d2explst, nil0)
      val ty_ret = s3type_ref ()

      val ty_fun = S3TYPEfun (npf
                              , ty_args
                              , ty_ret
                              , false (*no information, assume no effect*)
                              )
      val () = !vartype := Some0 ty_fun
      val inner_types1 = cons0 (ty_ret, inner_types)
    in
      case+ d2exparglst1 of
      | list_cons (_, _) => 
          loop_s3type (ty_ret, d2exparglst1, inner_types1, loc)
      | list_nil () => (ty_ret, list0_reverse (inner_types1))
    end
  end
  end  // end of [loop_ref]

  val (restype, inner_types) = 
    loop_s3type (s3type_fun, d2exparglst, nil0 (), loc)
in
  restype
end

implement oftype_d2exp (d2exp, tmap) = let
  val node = d2exp.d2exp_node
  val loc = d2exp.d2exp_loc
in
  case+ node of
  | D2Ecst (d2cst) => oftype_d2cst (d2cst, tmap, loc)
//
  | D2Evar (d2var) => oftype_d2var (d2var, tmap, loc)
//
  | D2Esym (d2sym) => oftype_d2sym (d2sym, tmap, loc)
//
  | D2Eint n => s3type_int ()
//
  | D2Eintrep str => s3type_int ()
//
  | D2Echar c => s3type_char ()
//
  | D2Efloat f => exitlocmsg ("Float is not supported.\n")
//
  | D2Estring str => s3type_string ()
//
  | D2Ei0nt str => s3type_int ()
//
  | D2Ec0har c => s3type_char ()
//
  | D2Ef0loat f => exitlocmsg ("Float is not supported.\n")
//
  | D2Es0tring str => s3type_string ()
//
  | D2Eempty () => s3type_unit ()
//
  | D2Eexp (d2exp) => oftype_d2exp (d2exp, tmap)
//
  | D2Eann_type (d2exp, s2exp) => let
    val s3type_d2exp = oftype_d2exp (d2exp, tmap)
    val s3type_s2exp = s3type_translate (s2exp)
    val tcres = s3type_match (tmap, s3type_d2exp, s3type_s2exp)
  in
    s3type_d2exp
  end
//
  | D2Elet (d2eclist, d2exp) => let
    val () = s3typecheck_d2eclist (d2eclist, tmap)
    val s3type = oftype_d2exp (d2exp, tmap)
  in
    s3type
  end
//
  | D2Eapplst (d2exp, d2exparglst) => 
      oftype_D2Eapplst (d2exp, d2exparglst, tmap, loc)
//
  | D2Eifopt (
    d2exp_if(*test*), d2exp_then(*then*), d2expopt_else (*else*)) => let 
      val () = s3typecheck_d2exp (d2exp_if, s3type_bool (), tmap)
      val ty_if = oftype_d2exp (d2exp_then, tmap)
    in
      case+ d2expopt_else of
      | Some d2exp_else => let
        val () = s3typecheck_d2exp (d2exp_else, ty_if, tmap)
      in ty_if end
      | None () => ty_if
    end

  end
  | D2Ecase (
      casekind
      , d2exp(*test*)
      , c2laulst
    ) => exitlocmsg ("todo\n")
//
  | D2Esing of (d2exp)
  | D2Elist of (d2explst)
//
  | D2Etup of (d2explst)
//
  | D2Eseq of (d2explst)
//
  | D2Eselab of (d2exp, d2lablst)
//
  | D2Elam_dyn of (int (*npf*), p2atlst, d2exp)
  | D2Elam_sta of (s2varlst (*static variables*)
                   , s2explst (*predicates in the statics*)
                   , d2exp)
  | D2Efix of (d2var, p2atlst, d2exp)
  | D2Eextfcall of (string, d2explst)
  | D2Eassgn of (d2exp, d2exp)
//
  | D2Eignored of ((*void*)) // HX: error-handling


















