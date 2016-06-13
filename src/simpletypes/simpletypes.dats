

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

#include "./../postiats/postiats_codegen2.hats"
#include "./simpletypes_codegen2.hats"

(* ************ ************* *)

implement is_debug_typechecking = ref false

(* ************ ************* *)
implement myfprint_s3tkind (out, s3tkind) = fprint_s3tkind<> (out, s3tkind)

implement fprint_val<s2cst> = fprint_s2cst
implement fprint_val<s2var> = fprint_s2var
implement fprint_val<s3tkind> = myfprint_s3tkind

implement fprint_val<s3element> = fprint_s3element
implement fprint_val<s3type> = myfprint_s3type

implement{}
fprint_s3type$S3TYPEref$arg1(out, arg0) = let 
  val-S3TYPEref(arg1) = arg0 
  val tyopt = !arg1
in 
  fprint_s3type$carg<option0 s3type>(out, tyopt) 
end

implement{}
fprint_s3type$S3TYPErecord$arg1(out, arg0) = let 
  val-S3TYPErecord(arg1, _, _) = arg0 
  val kind = !arg1
in 
  fprint_s3type$carg<s3tkind>(out, kind) 
end


implement{}
fprint_s3type$S3TYPEfun$arg1(out, arg0) = let 
  val-S3TYPEfun(arg1, _, _, _) = arg0 
  val npf = !arg1
in 
  fprint_s3type$carg<int>(out, npf) 
end

implement fprint_val<s3labeltype> = fprint_s3labeltype

implement myfprint_s3type (out, s3type) = fprint_s3type<> (out, s3type)

implement fprint_s3labeltype (out, labtype) = let
  val lab = labtype.s3labeltype_label
  val ty = labtype.s3labeltype_type
  val () = fprint (out, "{label: ")
  val () = fprint_label (out, lab)
  val () = fprint (out, ", ty: ")
  val () = myfprint_s3type (out, ty)
  val () = fprint (out, "}")
in end

(* ************ ************* *)

implement s3type_int () = S3TYPEelement (S3ELEMENTint)
implement s3type_char () = S3TYPEelement (S3ELEMENTchar)
implement s3type_bool () = S3TYPEelement (S3ELEMENTbool)
implement s3type_string () = S3TYPEelement (S3ELEMENTstring)
implement s3type_unit () = S3TYPEelement (S3ELEMENTunit)
implement s3type_ref () = S3TYPEref (ref<option0 s3type> (None0 ()))
implement s3type_fun (npf, ty_args, ty_res, effect) = 
 S3TYPEfun (ref npf, ty_args, ty_res, effect)

implement s3tkind_make (kind) = 
case+ kind of
| 0 => S3TKINDflat
| 1 => S3TKINDboxed
| _ => S3TKINDignored

implement s3labeltype_make (label, s3type) = 
'{ s3labeltype_label = label
, s3labeltype_type = s3type
}

(* ************ ************* *)
implement s3type_get_funtype (s3type) =
case+ s3type of
| S3TYPEfun (_, _, _, _) => s3type
| S3TYPEpoly (_, s3type') => s3type_get_funtype (s3type')
| S3TYPEref (tyopt_ref) =>
  (
  case+ !tyopt_ref of
  | Some0 ty => s3type_get_funtype (ty)
  | None0 () => exitlocmsg ("This is not allowed.\n")
  )
| _ => exitlocmsg ((datcon_s3type s3type) + " is not allowed.\n")


implement s3type_get_rettype (s3type) =
case+ s3type of
| S3TYPEfun (_, _, ret, _) => ret
| S3TYPEref (tyopt_ref) =>
  (
  case+ !tyopt_ref of
  | Some0 ty => s3type_get_rettype (ty)
  | None0 () => exitlocmsg ("This is not allowed.\n")
  )
| _ => exitlocmsg ((datcon_s3type s3type) + " is not allowed.\n")

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


extern fun instantiate_one (s2varlst, s3type): s3type
// instantiate all para type by S3TYPEref
extern fun instantiate_all (s3type: s3type): s3type

implement s3typecheck_d2ecl (d2ecl, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_d2ecl =====\n")
  in end
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
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_D2Cimpdec =====\n")
  in end
  val- D2Cimpdec (knd, i2mpdec) = d2ecl.d2ecl_node
  val s3type_d2exp = i2mpdec.i2mpdec_def.oftype (tmap)
  val () = case+ s3type_d2exp of
           | S3TYPEfun (_, _, _, _) => ()
           | S3TYPEpoly (_, _) => ()
           | _ => () (* Check this *)
in end

//
implement s3typecheck_D2Cfundecs (tmap, d2ecl) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_D2Cfundecs =====\n")
  in end
  val- D2Cfundecs (funknd, f2undeclst) = d2ecl.d2ecl_node
  // collect type information from function headers
  implement list_foldleft$fopr<s3typemap><f2undec> (acc, x) = let
    val _ = oftype_funhead_f2undec (x, acc)
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
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_D2Cvaldecs =====\n")
  in end
  val- D2Cvaldecs (valkind, v2aldeclst) = d2ecl.d2ecl_node

  implement list_foldleft$fopr<s3typemap><v2aldec> (acc, x) = let
    val () = s3typecheck_v2aldec (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><v2aldec> (v2aldeclst, tmap)
in end

//
implement s3typecheck_D2Cvardecs (tmap, d2ecl) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_D2Cvardecs =====\n")
  in end
  val- D2Cvardecs (v2ardeclst) = d2ecl.d2ecl_node

  implement list_foldleft$fopr<s3typemap><v2ardec> (acc, x) = let
    val () = s3typecheck_v2ardec (x, acc)
  in acc end
  val _ = list_foldleft<s3typemap><v2ardec> (v2ardeclst, tmap)
in end

//
implement s3typecheck_D2Cdcstdecs (tmap, d2ecl) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_D2Cdcstdecs =====\n")
  in end
  val- D2Cdcstdecs (n, d2cst) = d2ecl.d2ecl_node
in
  (* do nothing *)
  // exitlocmsg ("todo\n") 
end

//
implement s3typecheck_D2Clocal (tmap, d2ecl) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_D2Clocal =====\n")
  in end
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
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_f2undec_body =====\n")
  in end
  val loc = f2undec.f2undec_loc
  val s3type = oftype_d2var (f2undec.f2undec_var, tmap, loc)
  val funtype = s3type_get_funtype (s3type)
  val rettype = s3type_get_rettype (funtype)

  val retexp = d2exp_expose_lam_dyn (f2undec.f2undec_def)
  // val () = fprint (stderr_ref, "return type is ")
  // val () = fprint_s3type (stderr_ref, rettype)
  // val () = fprint (stderr_ref, "=== \n")

  // val () = fprint (stderr_ref, "return exp is ")
  // val () = fprint_d2exp (stderr_ref, retexp)
  // val () = fprint (stderr_ref, "=== \n")

  val () = s3typecheck_d2exp (retexp, rettype, tmap)
in end

implement s3typecheck_d2exp (d2exp, s3type, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_d2exp =====\n")
  in end
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
implement s3typecheck_v2aldec (v2aldec, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_v2aldec =====\n")
  in end
  val p2at = v2aldec.v2aldec_pat
  val ty_p2at = oftype_p2at (p2at, tmap)
  val def = v2aldec.v2aldec_def
  val ty_def = oftype_d2exp (def, tmap)
  val tcres = s3type_match (tmap, ty_p2at, ty_def)
in
  case+ tcres of
  | None0 () => ()
  | Some0 (msg) => 
      exitlocmsg ("Type mismatch d2exp: " + msg + "\n" +
      v2aldec.v2aldec_loc.tostring ())
end


implement s3typecheck_v2ardec (v2ardec, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3typecheck_v2ardec =====\n")
  in end
  val ty_var = (case+ v2ardec.v2ardec_type of
               | Some0 s2exp => let
                 val s3typeopt = s3type_translate (s2exp)
               in
                 case+ s3typeopt of
                 | Some0 s3type => s3type
                 | None0 () => exitlocmsg ("Check this.\n")
               end
               | None0 () => s3type_ref ()
               ): s3type
  val () = s3typemap_update_d2var (
    tmap, v2ardec.v2ardec_loc, v2ardec.v2ardec_name, ty_var)
in
  case+ v2ardec.v2ardec_init of
  | Some d2exp => s3typecheck_d2exp (d2exp, ty_var, tmap)
  | None () => ()
end

(* ******************* ******************* *)

implement instantiate_one (s2varlst, s3type) = let
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
end  // end of [instantiate_one]

implement instantiate_all (s3type) = 
case+ s3type of
| S3TYPEfun (_, _, _, _) => s3type
| S3TYPEpoly (s2varlst, s3type1) => let
  val s3type2 = instantiate_one (s2varlst, s3type1)
in
  instantiate_all (s3type2)
end
| _ => exitlocmsg ("Check this.\n")
// end of [instantiate_all]


extern fun oftype_P2Tcon (p2at: p2at, tmap: s3typemap): s3type

// This part is similar to oftype_D2Eapplst
implement oftype_P2Tcon (p2at, tmap) = let
  val loc = p2at.p2at_loc
  val- P2Tcon (d2con, npf, p2atlst) = p2at.p2at_node
  val s2exp = d2con_get_type (d2con)
  val- Some0 s3type = s3type_translate (s2exp)
  val s3type0 = instantiate_all (s3type)
  val- S3TYPEfun (npf_ty, ty_args, ty_res, effect) = s3type0
in
  if (length (ty_args) <> length (p2atlst))
  then exitlocmsg (
    "Type mismatched: " + loc.tostring () + " different length.\n")
  else let
    val () = loop_type_checker (p2atlst, ty_args) where {
    fun loop_type_checker (
      p2atlst: p2atlst , s3typelst: s3typelst): void =
    case+ (p2atlst, s3typelst) of
    | (list_cons (p2at1, p2atlst1), cons0 (s3type1, s3typelst1)) => let
      val ty_p2at = oftype_p2at (p2at1, tmap)
      val tcres = s3type_match (tmap, ty_p2at, s3type1)
    in
      case+ tcres of
      | Some0 msg => exitlocmsg ("type mismatch: " + msg + "\n")
      | None0 () => loop_type_checker (p2atlst1, s3typelst1)
    end
    | (list_nil (), nil0 ()) => ()
    | (_, _) => exitlocmsg (
    "Type mismatched: " + loc.tostring () + " different length.\n")
    }
  in
    ty_res
  end
end  // end of [oftype_P2Tcon]

implement oftype_p2at (p2at, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== oftype_p2at =====\n")
  in end
  val loc = p2at.p2at_loc
  val node = p2at.p2at_node
in
  case+ node of
  | P2Tany () => s3type_ref ()
//
  | P2Tvar (d2var) => let
    val ty = s3type_ref ()
    val () = s3typemap_update_d2var (tmap, loc, d2var, ty)
  in ty end
//
  | P2Tempty () => s3type_unit ()
//
  | P2Tann (p2at, s2exp) => let
    val ty_pat = oftype_p2at (p2at, tmap)
    val- tyopt = s3type_translate (s2exp)
    // val () = fprintln! (stdout_ref, "=======s2exp: ", s2exp)
    val- Some0 (ty_exp) = tyopt
    val tcres = s3type_match (tmap, ty_pat, ty_exp)
    val ty = s3type_normalize (ty_pat)
  in ty end
//
  | P2Trec (kind, npf, labp2atlst) => let
    implement list_foldright$fopr<labp2at><s3labeltypelst> (labp2at, res) = let
      val- LABP2ATnorm (label, p2at) = labp2at
      val s3type = oftype_p2at (p2at, tmap)
      val s3labeltype = s3labeltype_make (label, s3type)
      val res = cons0 (s3labeltype, res)
    in res end
    val s3labeltypelst = 
      list_foldright<labp2at><s3labeltypelst> (labp2atlst, nil0 ())
    val ty = S3TYPErecord (ref (s3tkind_make (kind)), npf, s3labeltypelst)
  in
    ty
  end
  | P2Tcon (d2con, npf, p2atlst) => oftype_P2Tcon (p2at, tmap)
//
  | P2Ti0nt (rep) => s3type_int ()
//
  | P2Tignored ((*void*)) => exitlocmsg ("Check this.\n")
end
// end of [oftype_p2at]


(* ******************* ******************* *)

implement oftype_d2cst (d2cst, tmap, loc) = let
  val s3typeopt = s3typemap_find_d2cst (tmap, d2cst)
  // val () = fprint (stderr_ref, "d2cst in oftype_d2cst is ")
  // val () = fprint_d2cst (stderr_ref, d2cst)
  // val () = fprint (stderr_ref, "\n")
in
  case+ s3typeopt of
  | None0 () => let
    val s2exp = d2cst_get_type (d2cst)
    // val () = fprint (stderr_ref, "s2exp is ")
    // val () = fprint_s2exp (stderr_ref, s2exp)
    // val () = fprint (stderr_ref, "\n")
    val- Some0 (s3type) = s3type_translate (s2exp)
    val () = s3typemap_update_d2cst (tmap, d2cst, s3type)
  in
    s3type
  end
  | Some0 (s3type) => s3type
end

implement oftype_d2var (d2var, tmap, loc) = let
  val vartype = s3type_ref ()
  val () = s3typemap_update_d2var (tmap, loc, d2var, vartype)
in
  vartype
end

implement oftype_d2sym (d2sym, tmap, loc) = let
  val s3typeopt = s3typemap_find_d2sym (tmap, d2sym)
in
  case+ s3typeopt of
  | None0 () => s3type_ref ()
  | Some0 (s3type) => s3type
end

fun oftype_D2Eapplst (
  d2exp: d2exp
  , d2exparglst: d2exparglst
  , tmap: s3typemap
  , loc: location_type): s3type = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== oftype_D2Eapplst =====\n")
  in end
  val s3type_funty = oftype_d2exp (d2exp, tmap)
  val s3type_funty = s3type_normalize (s3type_funty)

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

      val s3type_body = instantiate_all (s3type)
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
    val () = !npf_ty := npf_args
  in
    if (length (ty_args) <> length (d2expargs))
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

      val ty_fun = s3type_fun (npf, ty_args, ty_ret, ~1)
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
    loop_s3type (s3type_funty, d2exparglst, nil0 (), loc)
in
  restype
end

implement oftype_d2exp (d2exp, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== oftype_d2exp =====\n")
  in end
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
//  | D2Eexp (d2exp) => oftype_d2exp (d2exp, tmap)
//
  | D2Eann_type (d2exp, s2exp) => let
    val s3type_d2exp = oftype_d2exp (d2exp, tmap)
    val- Some0 (s3type_s2exp) = s3type_translate (s2exp)
    val tcres = s3type_match (tmap, s3type_d2exp, s3type_s2exp)
  in
    s3type_d2exp
  end
  | D2Eann_seff (d2exp1) => oftype_d2exp (d2exp1, tmap)
//
  | D2Eann_funclo (d2exp1) => oftype_d2exp (d2exp1, tmap)
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
  | D2Ecase (
      casekind
      , d2explst(*tests*)
      , c2laulst
    ) => let
    val- list_cons (c2lau1, c2laulst1) = c2laulst

    // handle first clause
    val p2atlst = c2lau1.c2lau_patlst
    fun loop (d2explst: d2explst
              , p2atlst: p2atlst
              , res: s3typelst): s3typelst =
    case+ (d2explst, p2atlst) of
    | (list_cons (d2exp1, d2explst1), list_cons (p2at1, p2atlst1)) => let
      val ty_d2exp = oftype_d2exp (d2exp1, tmap)
      val ty_p2at = oftype_p2at (p2at1, tmap)

      val tcres = s3type_match (tmap, ty_d2exp, ty_p2at)
    in
      case+ tcres of
      | Some0 msg => exitlocmsg ("Type mismatch: " + msg + "\n")
      | None0 () => let
        val res = cons0 (ty_d2exp, res)
      in loop (d2explst1, p2atlst1, res) end
    end
    | (list_nil (), list_nil ()) => list0_reverse res
    | (_, _) => exitlocmsg ("Type mismatch.\n")

    
    // handle test
    val s3typelst = loop (d2explst, p2atlst, nil0 ())

    // hande body
    val body = c2lau1.c2lau_body
    val ty_body = oftype_d2exp (body, tmap)
    //
    // handle the rest of the clauses
    //
    implement list_foldright$fopr<c2lau><int> (c2lau, res) = let
      val p2atlst = c2lau.c2lau_patlst

      fun loop (s3typelst: s3typelst
                , p2atlst: p2atlst): void =
      case+ (s3typelst, p2atlst) of
      | (cons0 (s3type1, s3typelst1), list_cons (p2at1, p2atlst1)) => let
        val ty_p2at = oftype_p2at (p2at1, tmap)

        val tcres = s3type_match (tmap, s3type1, ty_p2at)
      in
        case+ tcres of
        | Some0 msg => exitlocmsg ("Type mismatch: " + msg + "\n")
        | None0 () => let
        in loop (s3typelst1, p2atlst1) end
      end
      | (nil0 (), list_nil ()) => ()
      | (_, _) => exitlocmsg ("Type mismatch.\n")
      
      // handle test
      val () = loop (s3typelst, p2atlst)

      // hande body
      val body = c2lau.c2lau_body
      val () = s3typecheck_d2exp (body, ty_body, tmap)
    in 0 end

    val _ = list_foldright<c2lau><int> (c2laulst1, 0)
  in
    ty_body
  end  // end of [D2Ecase]
  //
  | D2Esing (d2exp) => oftype_d2exp (d2exp, tmap)
  //
  | D2Elist (npf, d2explst) => let
    implement list_foldright$fopr<d2exp><'(int, s3labeltypelst)> (d2exp, res) = let
      val s3type = oftype_d2exp (d2exp, tmap)
      val index = res.0
      val label = LABint (index)
      val labeltype = s3labeltype_make (label, s3type)
      val res = '(index + 1, cons0 (labeltype, res.1))
    in
      res
    end
    val res = 
      list_foldright<d2exp><'(int, s3labeltypelst)> (d2explst, '(0, nil0 ()))

    val ty = S3TYPErecord (ref (S3TKINDignored), npf, res.1)
  in
    ty
  end
//
  | D2Etup (kind, npf, d2explst) => let
    implement list_foldright$fopr<d2exp><'(int, s3labeltypelst)> (d2exp, res) = let
      val s3type = oftype_d2exp (d2exp, tmap)
      val index = res.0
      val label = LABint (index)
      val labeltype = s3labeltype_make (label, s3type)
      val res = '(index + 1, cons0 (labeltype, res.1))
    in
      res
    end
    val res = 
      list_foldright<d2exp><'(int, s3labeltypelst)> (d2explst, '(0, nil0 ()))

    val ty = S3TYPErecord (ref (s3tkind_make (kind)), npf, res.1)
  in
    ty
  end
  | D2Eseq (d2explst) => exitlocmsg ("Not supported.\n")
//
  | D2Eselab (d2exp, d2lablst) => exitlocmsg ("Not supported.\n")
//
  | D2Elam_dyn (npf, p2atlst, d2exp) => let
    implement list_foldright$fopr<p2at><s3typelst> (p2at, res) = let
      val s3type = oftype_p2at (p2at, tmap)
    in cons0 (s3type, res) end
    val ty_args = list_foldright<p2at><s3typelst> (p2atlst, nil0 ())
    val ty_res = oftype_d2exp (d2exp, tmap)

    val ty_fun = s3type_fun (npf, ty_args, ty_res, ~1)
  in
    ty_fun
  end
  | D2Elam_sta (s2varlst (*static variables*)
               , s2explst (*predicates in the statics*)
               , d2exp) => let
    val ty = oftype_d2exp (d2exp, tmap)
    val ret = S3TYPEpoly (s2varlst, ty)
  in
    ret
  end
  | D2Efix (d2var, p2atlst, d2exp) => exitlocmsg ("Not supported.\n")
  | D2Eextfcall (s2exp, name, d2explst) => let
    val s3typeopt = s3type_translate (s2exp)
    val s3typelst = oftype_d2explst (d2explst, tmap)
  in 
    case+ s3typeopt of
    | Some0 s3type => s3type
    | None0 () => exitlocmsg ("Check this.\n")
  end
  | D2Eassgn (d2exp1, d2exp2) => let
    val ty1 = oftype_d2exp (d2exp1, tmap)
    val ty2 = oftype_d2exp (d2exp2, tmap)
    val tcres = s3type_match (tmap, ty1, ty2)
  in
    case+ tcres of
    | None0 () => s3type_unit ()
    | Some0 (msg) => 
        exitlocmsg ("Type mismatch d2exp: " + msg + "\n" +
        d2exp.d2exp_loc.tostring ())
  end
  | D2Eignored ((*void*)) => exitlocmsg ("Check this.\n")
end  // end of [oftype_d2exp]

implement oftype_d2explst (d2explst, tmap) = let
  implement list_foldright$fopr<d2exp><s3typelst> (d2exp, res) = let
    val s3type = oftype_d2exp (d2exp, tmap)
  in
    cons0 (s3type, res)
  end
in
  list_foldright<d2exp><s3typelst> (d2explst, nil0 ())
end

implement oftype_funhead_f2undec (f2undec, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== oftype_funhead_f2undec =====\n")
  in end
  val fundef = f2undec.f2undec_def
  val loc = f2undec.f2undec_loc
  val funtype = oftype_funhead_d2exp (fundef, tmap)
  // val () = fprint (stderr_ref, "funtype at " + $mylocation + " is ")
  // val () = fprint_s3type (stderr_ref, funtype)
  // val () = fprint (stderr_ref, "=== \n")

  val funvar = f2undec.f2undec_var
  val () = s3typemap_update_d2var (tmap, loc, funvar, funtype)
in
  funtype
end

implement oftype_funhead_d2exp (d2exp, tmap) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== oftype_funhead_d2exp =====\n")
  in end
  val node = d2exp.d2exp_node
in
  case+ node of
  | D2Elam_sta (s2varlst (*static variables*)
               , s2explst (*predicates in the statics*)
               , d2exp) => let
    val ty = oftype_funhead_d2exp (d2exp, tmap)
    val ret = S3TYPEpoly (s2varlst, ty)
  in
    ret
  end
  | D2Elam_dyn (npf, p2atlst, d2exp) => let
    implement list_foldright$fopr<p2at><s3typelst> (p2at, res) = let
      val s3type = oftype_p2at (p2at, tmap)
    in cons0 (s3type, res) end
    val ty_args = list_foldright<p2at><s3typelst> (p2atlst, nil0 ())

    fun get_type_lamdyn_ret (d2exp: d2exp, tmap: s3typemap): s3type =
      case+ d2exp.d2exp_node of
      | D2Eann_funclo (d2exp1) => get_type_lamdyn_ret (d2exp1, tmap)
      | D2Eann_seff (d2exp1) => get_type_lamdyn_ret (d2exp1, tmap)
      | D2Eann_type (_, s2exp) => let
        val- Some0 (ty) = s3type_translate (s2exp)
      in ty end
      | _ => s3type_ref ()

    val ty_ret = get_type_lamdyn_ret (d2exp, tmap)
    val ty_fun = s3type_fun (npf, ty_args, ty_ret, ~1)
  in
    ty_fun
  end
  | _ => exitlocmsg (datcon_d2exp_node (node) + 
                     " is encountered, which shall not happen here.\n")
end

(* ******************* ******************* *)

implement s3type_match (tmap, left, right) = let
  val () = if isdebug then let
    // val () = fprint! (stdout_ref, "===== s3type_match =====\n")
  in end
  val tyleft = s3type_normalize (left)
  val tyright = s3type_normalize (right)
in
  case+ (tyleft, tyright) of
  | (S3TYPEref (tyvar), _) =>
    (
    case+ !tyvar of
    | Some0 (_) => exitlocmsg ("This should not happen.\n")
    | None0 () => let
      val () = !tyvar := Some0 tyright
    in
      None0 ()
    end
    )
  | (_, S3TYPEref (tyvar)) =>
    (
    case+ !tyvar of
    | Some0 (_) => exitlocmsg ("This should not happen.\n")
    | None0 () => let
      val () = !tyvar := Some0 tyleft
    in
      None0 ()
    end
    )
  //
  | (S3TYPEelement (S3ELEMENTint ())
    , S3TYPEelement (S3ELEMENTint ())) => None0 ()
  | (S3TYPEelement (S3ELEMENTchar ())
    , S3TYPEelement (S3ELEMENTchar ())) => None0 ()
  | (S3TYPEelement (S3ELEMENTbool ())
    , S3TYPEelement (S3ELEMENTbool ())) => None0 ()
  | (S3TYPEelement (S3ELEMENTstring ())
    , S3TYPEelement (S3ELEMENTstring ())) => None0 ()
  | (S3TYPEelement (S3ELEMENTunit ())
    , S3TYPEelement (S3ELEMENTunit ())) => None0 ()
  //
  | (S3TYPErecord (kind1, npf1, labtypelst1)
    , S3TYPErecord (kind2, npf2, labtypelst2)) => let
    val () = (case+ !kind1 of
             | S3TKINDignored () => !kind1 := !kind2
             | _ => ()
             )
    val () = (case+ !kind2 of
             | S3TKINDignored () => !kind2 := !kind1
             | _ => ()
             )
    fun loop (labtypelst1: s3labeltypelst
      , labtypelst2: s3labeltypelst): tcresult =
    case+ (labtypelst1, labtypelst2) of
    | (cons0 (labtype1, labtypelst1'), cons0 (labtype2, labtypelst2')) => let
      val tcres = s3type_match_labeltype (tmap, labtype1, labtype2)
    in
      case+ tcres of
      | Some0 _ => tcres
      | None0 () => loop (labtypelst1', labtypelst2')
    end
    | (nil0 (), nil0 ()) => None0 ()
    | (_, _) => Some0 ("S3TYPErecord mismatch: " + $mylocation)

  in
    loop (labtypelst1, labtypelst2)
  end
  //
  | (S3TYPEprop (), S3TYPEprop ()) => None0 ()
  //
  | (S3TYPEcon (s2cst1, typelst1), S3TYPEcon (s2cst2, typelst2)) =>
    if s2cst1 != s2cst2 then 
      Some0 ("S3TYPEcon mismatch: " + 
             s2cst1.tostring () + " <> " + s2cst2.tostring ())
    else s3type_match_typelst (tmap, typelst1, typelst2)
  //
  | (S3TYPEfun (npf1, args1, res1, eff1)
    , S3TYPEfun (npf2, args2, res2, eff2)) =>
  if !npf1 <> !npf2 then Some0 ("S3TYPEfun mismatch: " + $mylocation)
  else let
    val tcres = s3type_match_typelst (tmap, args1, args2)
  in
    case+ tcres of
    | Some0 _ => tcres
    | None0 () => let
      val tcres = s3type_match (tmap, res1, res2)
    in
      tcres
    end
  end
  //
  | (S3TYPEvar (s2var1), S3TYPEvar (s2var2)) => 
    if (s2var1 != s2var2) then Some0 ("S3TYPEvar mismatch: " + $mylocation)
    else None0 ()
  | (S3TYPEpoly (s2varlst1, s3type1), S3TYPEpoly (s2varlst2, s3type2)) =>
    s3type_match (tmap, s3type1, s3type2)
  | (S3TYPErefarg (left0), right) => s3type_match (tmap, left0, right)
  | (left, S3TYPErefarg (right0)) => s3type_match (tmap, left, right0)
  | (left, right) => let
    val () = if isdebug then let
      val () = fprint (stderr_ref, "\nleft is ")
      val () = myfprint_s3type (stderr_ref, left)
      val () = fprint (stderr_ref, "\n")
      val () = fprint (stderr_ref, "right is ")
      val () = myfprint_s3type (stderr_ref, right)
      val () = fprint (stderr_ref, "\n")
    in end
  in
    Some0 ("general mismatch: " +
       datcon_s3type (left) + " <> " + 
       datcon_s3type (right) + " at " +
       $mylocation)
  end
end

implement s3type_match_typelst (tmap, typelst1, typelst2) =
case+ (typelst1, typelst2) of
| (cons0 (type1, typelst1'), cons0 (type2, typelst2')) => let
  val tcres = s3type_match (tmap, type1, type2)
in
  case+ tcres of
  | Some0 _ => tcres
  | None0 () => s3type_match_typelst (tmap, typelst1', typelst2')
end
| (nil0 (), nil0 ()) => None0 ()
| (_, _) => Some0 ("Type mismatch: " + $mylocation)

implement s3type_match_labeltype (tmap, labtype1, labtype2) = let
  val lab1 = labtype1.s3labeltype_label
  val lab2 = labtype2.s3labeltype_label
  val type1 = labtype1.s3labeltype_type
  val type2 = labtype2.s3labeltype_type
in
  if lab1 != lab2 then Some0 (lab1.tostring () + " <> " + lab2.tostring ())
  else s3type_match (tmap, type1, type2)
end

implement s3type_normalize (s3type) =
case+ s3type of
| S3TYPEref (typeopt_ref) => let
  val typeopt = !typeopt_ref
in
  case+ typeopt of
  | None0 () => s3type
  | Some0 (type0) => let
    val type1 = s3type_normalize (type0)
    val () = !typeopt_ref := Some0 type1
  in
    type1
  end
end
//
| S3TYPErefarg (ty) => let
  val ty1 = s3type_normalize (ty)
in
  S3TYPErefarg ty1
end
//
| S3TYPEelement (s3element) => s3type
//
| S3TYPErecord (tkindref, npf, s3labeltypelst) => let
  val s3labeltypelst1 = list0_foldright (s3labeltypelst, fopr, nil0) where {
  fun fopr (s3labeltype: s3labeltype
            , res: s3labeltypelst):<cloref1> s3labeltypelst = let
    val lab = s3labeltype.s3labeltype_label
    val type0 = s3labeltype.s3labeltype_type
    val type1 = s3type_normalize (type0)
    val labtype = s3labeltype_make (lab, type1)
  in
    cons0 (labtype, res)
  end
  }
in
  S3TYPErecord (tkindref, npf, s3labeltypelst1)
end
//
| S3TYPEprop () => s3type
//
| S3TYPEcon (s2cst, s3typelst) => let
  val s3typelst1 = s3type_normalize_typelst (s3typelst)
in
  S3TYPEcon (s2cst, s3typelst1)
end
//
| S3TYPEfun (npfref, args, res, eff) => let
  val args1 = s3type_normalize_typelst (args)
  val res1 = s3type_normalize (res)
in
  S3TYPEfun (npfref, args1, res1, eff)
end
//
| S3TYPEvar s2var => s3type
//
| S3TYPEpoly (s2varlst, s3type) => let
  val s3type1 = s3type_normalize (s3type)
in
  S3TYPEpoly (s2varlst, s3type1)
end
| S3TYPEignored () => S3TYPEignored () 
// end of [s3type_normalize]


implement s3type_normalize_typelst (s3typelst) = let
  val s3typelst1 = list0_foldright (s3typelst, fopr, nil0) where {
  fun fopr (type0: s3type
            , res: s3typelst):<cloref1> s3typelst = let
    val type1 = s3type_normalize (type0)
  in
    cons0 (type1, res)
  end
  }
in
  s3typelst1
end

        
        

  

















