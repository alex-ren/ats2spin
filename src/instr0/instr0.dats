
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"


staload "./../postiats/postiats.sats"
staload "./../simpletypes/simpletypes.sats"
staload "./../utils/emiter.sats"
staload "./instr0.sats"

#include "./../postiats/postiats_codegen2.hats"

#include "./instr0_codegen2.hats"

#define :: list0_cons
#define nil list0_nil

(* ************** ************* *)

implement fprint_val<i0fundef> = fprint_i0fundef

implement fprint_val<i0gvar> = fprint_i0gvar

implement fprint_val<i0id> = fprint_i0id

(* ************** ************* *)

implement myfprint_i0decl (out, i0decl) = fprint_i0decl<> (out, i0decl)

implement fprint_i0gvar (out, i0gvar) = let
  val () = fprint (out, "global ")
  val () = fprint (out, i0gvar.0)
in
  case+ i0gvar.1 of
  | Some i0exp => let
    val () = fprint (out, " = ")
    val () = myfprint_i0exp (out, i0exp)
  in end
  | None () => ()
end

implement fprint_i0prog (out, i0prog) = let
  // val funcs = i0funmap_listize1 (i0prog.i0prog_i0funmap)
  val declst = i0prog.i0prog_i0declst

  implement 
  fprint_val<i0decl> (out, decl) = myfprint_i0decl (out, decl)
  val () = fprint_list0_sep<i0decl> (out, i0prog.i0prog_i0declst, "\n\n")
  val () = fprint (out, "\n\n")
in
end

(* ********** ************ *)

implement i0gbranch_make (i0exp, i0inslst) =
'{ i0gbranch_guard = i0exp
 , i0gbranch_inss = i0inslst
}

(* ********** ************ *)

implement i0transform_d2eclst_global (sa, d2ecs, tmap) = let
  // val () = print ("======== i0transform_d2eclst_global\n")
  fun loop (
    d2ecs: d2eclist
    , tmap: s3typemap
    , fmap: i0funmap
    , res: i0declst
    ): i0declst =
    case+ d2ecs of
    | list_cons (d2ec, d2ecs) => let
        val i0decl = i0transform_d2ecl_global (sa, d2ec, tmap, fmap)
        val  res = list0_append (i0decl, res)
    in loop (d2ecs, tmap, fmap, res) end
    | list_nil () => res
 
  val fmap = i0funmap_create (i2sz(2048))

  val i0declst = loop (d2ecs, tmap, fmap, nil0)
  val i0declst = list0_reverse (i0declst)

  val prog = '{i0prog_i0funmap = fmap
              , i0prog_i0declst = i0declst
              }
in
  prog
end

implement i0transform_d2ecl_global (sa, d2ec, tmap, fmap) = let
  // val () = print ("======== i0transform_d2ecl_global\n")
  val node = d2ec.d2ecl_node
in
  case+ node of
  | D2Cimpdec (knd, i2mpdec) => exitlocmsg (datcon_d2ecl_node (node))
  | D2Cfundecs (knd, f2undeclst) => 
      i0transform_D2Cfundecs (sa, f2undeclst, tmap, fmap)

  | D2Cvaldecs (valkind, v2aldeclst) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Cvardecs (v2aldeclst) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Cdcstdecs (knd, d2cst) => nil0
  | D2Clocal (d2eclist(*head*), d2eclist(*body*)) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Cextcode (code) => list0_sing (DEC0extcode (code))
  | D2Cignored () => nil0
//   | _ => exitlocmsg (datcon_d2ecl_node (node) + " not supported")
end

(*
* p2atlst: parameters
* d2exp: body
*)
extern fun d2exp_node_get_lambda (d2exp_node): (p2atlst, d2exp)
implement d2exp_node_get_lambda (node) =
case+ node of
| D2Elam_dyn (npf, p2atlst, d2exp) => (p2atlst, d2exp)
| D2Elam_sta (_, _, d2exp) => d2exp_node_get_lambda (d2exp.d2exp_node)
| D2Eann_type (d2exp, s2exp) => d2exp_node_get_lambda (d2exp.d2exp_node)
| _ => exitlocmsg ("This should not happen.")

fun f2undec_is_recursive (f: f2undec): bool = let
  val fvar = f.f2undec_var
  // val () = fprint (stdout_ref, "xxx fvar is ")
  // val () = fprint (stdout_ref, fvar)
  // val () = fprint (stdout_ref, "\n")
  // val () = fprint (stdout_ref, "xxx " + datcon_d2exp_node f.f2undec_def.d2exp_node + "\n")
  val (_, fbody) = d2exp_node_get_lambda (f.f2undec_def.d2exp_node)

  // check whether fexp is a function name represented by fvar
  fun d2exp_is_fun (fexp: d2exp, fvar: d2var): bool =
    case+ fexp.d2exp_node of
    | D2Evar (name) => fvar = name
    | _ => false

  (* Desc:
  *    e: Body of a function.
  *    fvar: d2var
  *)
  fun d2exp_has_tailcall (e: d2exp, fvar: d2var): bool = let
    val node = e.d2exp_node
  in
    case+ e.d2exp_node of
    | D2Elet (_, e1) => d2exp_has_tailcall (e1, fvar)
    | D2Eapplst (fexp, _) => d2exp_is_fun (fexp, fvar)
    | D2Eifopt (_, e1, e2opt) =>
        if (d2exp_has_tailcall (e1, fvar)) then true
        else (case+ e2opt of
             | Some (e2) => d2exp_has_tailcall (e2, fvar)
             | None () => false
             )
    | D2Esing (e1) => exitlocmsg ("D2Esing hit")
    | D2Ecase (knd, d2exp, c2laulst) => let
       fun loop (c2laulst: c2laulst): bool =
       case+ c2laulst of
       | list_cons (c2lau, c2laulst1) =>
         if d2exp_has_tailcall (c2lau.c2lau_body, fvar) then true
         else loop (c2laulst1)
       | list_nil () => false
     in
       loop (c2laulst)
     end
    | D2Eempty () => false
    | D2Eann_seff (d2exp) => d2exp_has_tailcall (d2exp, fvar)
    | D2Eann_type (d2exp, s2exp) => d2exp_has_tailcall (d2exp, fvar)
    | D2Evar (d2var) => false
    | _ => exitlocmsg (datcon_d2exp_node node + " is not supported")
  end
in
  d2exp_has_tailcall (fbody, fvar)
end

implement
i0transform_D2Cfundecs (sa, f2undeclst, tmap, fmap) = let
  // val () = print ("======== i0transform_D2Cfundecs\n")
  val len = list_length (f2undeclst)
  val is_recursive = (if (len > 1) then true
      else if (len = 1) then let
        val f = f2undeclst.head ()
      in
        f2undec_is_recursive (f)
      end else exitlocmsg ("This is impossible.")
  ): bool

  val fnames = if is_recursive then
      f2undeclst_collect_names (f2undeclst) where {
      fun f2undeclst_collect_names (f2uns: f2undeclst): i0idlst =
        case+ f2uns of
        | list_cons (f2un, f2uns1) => let
          val fname: i0id = i0transform_d2var (sa, tmap, f2un.f2undec_var) 
          val fnames = f2undeclst_collect_names (f2uns1)
        in
          list0_cons (fname, fnames)
        end
        | list_nil () => list0_nil ()
      }
    else list0_nil ()  // end of [val fnames]

  val ret = loop (sa, fnames, f2undeclst, fmap, nil0) where {
    fun loop (
      sa: stamp_allocator
      , group: i0idlst
      , f2undeclst: f2undeclst
      , fmap: i0funmap
      , res: i0declst): i0declst =
      case+ f2undeclst of
      | list_cons (f2undec, f2undeclst1) => let
        val i0declst = i0transform_fundec (sa, fnames, f2undec, tmap, fmap)
        val res = list0_append (list0_reverse i0declst, res)
      in
        loop (sa, group, f2undeclst1, fmap, res)
      end
      | list_nil () => res
  }
  val ret = list0_reverse (ret)
in
  ret
end

implement i0transform_d2var (sa, tmap, d2var) = let
  val stamp = stamp_get_from_d2var (sa, d2var)
  val name = d2var_get_name (d2var)
  val i0name = i0name_make (name)

  val- Some0 s3type = s3typemap_find_d2var (tmap, d2var)

  // val () = fprint (stderr_ref, "d2var is ")
  // val () = fprint_d2var (stderr_ref, d2var)
  // val () = fprint (stderr_ref, "\n")

  val type0 = type0_translate (s3type)
in
  i0id_make_var (i0name, stamp, type0)
end

implement i0transform_d2cst (sa, tmap, d2cst) = let
  val stamp = stamp_get_from_d2cst (sa, d2cst)
  val name = d2cst_get_name (d2cst)
  val extdef_opt = (case+ d2cst_get_extdef_opt (d2cst) of
            | Some (v) => Some0 v
            | None () => None0
            ): option0 string
  val i0name = i0name_make (name)
  // val () = fprint (stderr_ref, "d2cst is ")
  // val () = fprint_d2cst (stderr_ref, d2cst)
  // val () = fprint (stderr_ref, "\n")
  val- Some0 s3type = s3typemap_find_d2cst (tmap, d2cst)
  val type0 = type0_translate (s3type)
in
  i0id_make_cst (i0name, stamp, extdef_opt, type0)
end

implement i0transform_d2sym (sa, d2sym) = let
  // val stamp = stamp_get_from_d2sym (sa, d2sym)
  val name = d2sym_get_name (d2sym)
  val i0name = i0name_make (name)
in
  i0id_make_sym (i0name)
end


implement i0transform_fundec (sa, group, f2undec, tmap, fmap) = let
  // val () = fprint! (stdout_ref, 
  //   "======== i0transform_fundec: ", f2undec.f2undec_var, "\n")

  val name = i0transform_d2var (sa, tmap, f2undec.f2undec_var)
  val (p2atlst, body) = d2exp_node_get_lambda (f2undec.f2undec_def.d2exp_node)
  val paralst = i0transform_p2atlst2paralst (sa, tmap, p2atlst)
  val (i0declst, inss) = i0transform_d2exp_fbody (sa, body, tmap, fmap)

  val fundef = i0fundef_create (name, paralst, inss, group)
  val () = i0funmap_insert_any (fmap, name, fundef)
  val i0decl = DEC0fun (fundef)
in 
  i0decl :: i0declst
end

implement i0transform_p2atlst2paralst (sa, tmap, p2atlst) = let
  val paralst = loop (p2atlst) where {
    fun loop (p2atlst: p2atlst): i0idlst =
    case+ p2atlst of
    | list_cons (p2at, p2atlst2) => let
      val para = i0transform_p2at2para (sa, tmap, p2at)
    in
      list0_cons (para, loop (p2atlst2))
    end
    | list_nil () => list0_nil ()
  }
in
  paralst
end

implement i0transform_p2at2para (sa, tmap, p2at) = let
  // val () = fprint! (stdout_ref, 
  //   "======== i0transform_p2at2para: ", p2at.p2at_loc, "\n")
in
case+ p2at.p2at_node of
| P2Tany () => exitlocmsg ("Shall not happen")
| P2Tvar (d2var) => i0transform_d2var (sa, tmap, d2var)
| P2Tempty () => exitlocmsg ("Shall not happen")
| P2Tann (p2at, s2exp) => i0transform_p2at2para (sa, tmap, p2at)
| P2Trec (kind, npf, labp2atlst) => exitlocmsg ("Shall not happen")
| P2Tcon (d2con, npf, p2atlst) => exitlocmsg ("Not supported.\n")
| P2Ti0nt (intrep) => exitlocmsg ("Shall not happen")
| P2Tignored () => exitlocmsg ("Shall not happen")
end

implement i0transform_p2at2holder (sa, tmap, p2at) = let
  // val () = fprint! (stdout_ref, 
  //   "======== i0transform_p2at2holder: ", p2at.p2at_loc, "\n")
in
case+ p2at.p2at_node of
| P2Tany () => None0 ()
| P2Tvar (d2var) => Some0 (i0transform_d2var (sa, tmap, d2var))
| P2Tempty () => None0 ()
| P2Tann (p2at, s2exp) => i0transform_p2at2holder (sa, tmap, p2at)
| P2Trec (kind, npf, labp2atlst) => exitlocmsg ("P2Trec is not supported yet.")
| P2Tcon (d2con, npf, p2atlst) => exitlocmsg ("todo")
| P2Ti0nt (intrep) => exitlocmsg ("Shall not happen")
| P2Tignored () => exitlocmsg ("Shall not happen")
end


implement i0transform_d2exp_fbody (sa, body, tmap, fmap) = let
  val node = body.d2exp_node
  // val () = fprint! (stdout_ref, 
  //   "======== i0transform_d2exp_fbody: ", body.d2exp_loc, "\n")
in
case+ node of
| D2Ecst (d2cst) => let
  val i0id = i0transform_d2cst (sa, tmap, d2cst)
  val i0exp = EXP0var (i0id)
  val inss = list0_sing (INS0return (Some0 i0exp))
in
  (nil0, inss)
end
| D2Evar (d2var) => let
  val i0id = i0transform_d2var (sa, tmap, d2var)
  val i0exp = EXP0var (i0id)
  val inss = list0_sing (INS0return (Some0 i0exp))
in
  (nil0, inss)
end

//   | D2Esym of (d2sym)
// //
//   | D2Eint of (int)
//   | D2Eintrep of (string)
//   | D2Echar of (char)
//   | D2Efloat of (double)
//   | D2Estring of (string)
// //
| D2Ei0nt (str) => let
  val inss = list0_sing (INS0return (Some0 (EXP0i0nt (str))))
in
  (nil0, inss)
end
//   | D2Ec0har of (char)
//   | D2Ef0loat of (string)
//   | D2Es0tring of (string)
// //
| D2Eempty ((*void*)) => (nil0, list0_cons (INS0return (None0 ()), list0_nil ()))
// //
// | D2Eexp (d2exp) => i0transform_d2exp_fbody (sa, d2exp, fmap)
// //
| D2Elet (d2eclist, d2exp) => let
  val (i0declst1, inss1) = i0transform_d2eclist (sa, d2eclist, tmap, fmap)
  val (i0declst2, inss2) = i0transform_d2exp_fbody (sa, d2exp, tmap, fmap)
  val i0declst = list0_append (i0declst1, i0declst2)
  val inss = list0_append (inss1, inss2)
in
  (i0declst, inss)
end
| D2Eapplst (d2exp, d2exparglst) => let
    val i0id = i0transform_d2exp_fname (sa, tmap, d2exp)
    val i0explst = i0transform_d2exparglst (sa, tmap, d2exparglst)
    val app = EXP0app (i0id, i0explst)
  in
    (nil0, list0_sing (INS0return (Some0 app)))
  end
// //
| D2Eifopt (
    d2exp1(*test*), d2exp2(*then*), d2expopt(*else*)
  ) => let
  val i0exp = i0transform_d2exp_expvalue (sa, tmap, d2exp1)
  val (i0declst1, inss1) = i0transform_d2exp_fbody (sa, d2exp2, tmap, fmap)
  val (i0declst2, inss2) = (case+ d2expopt of
               | Some (d2exp) => 
                   i0transform_d2exp_fbody (sa, d2exp, tmap, fmap)
               | None () => (nil0, list0_sing (INS0return (None0)))
  ): (i0declst, i0inslst)
in
  (list0_append (i0declst1, i0declst2)
  , list0_sing (INS0ifbranch (i0exp, inss1, inss2)))
end
| D2Ecase (casekind, d2explst, c2laulst) => let
val- cons(d2exp, d2explst1) = d2explst
val node = d2exp.d2exp_node
in
case+ node of
| D2Eintrep (intrep) => let
  implement 
  list_foldright$fopr<c2lau><'(i0declst, i0gbranchlst, option0 i0inslst)> (
    c2lau, res) = let
    val- list_cons (pat, list_nil ()) = c2lau.c2lau_patlst
    val d2exp = c2lau.c2lau_body
    // must be a "let" expression
    val- D2Elet (d2eclist, d2exp) = d2exp.d2exp_node
  in
    case+ pat.p2at_node of
    // else branch
    | P2Tany () => let
      val (i0declst1, inss1) = i0transform_d2eclist (sa, d2eclist, tmap, fmap)
      val (i0declst2, inss2) = i0transform_d2exp_fbody (sa, d2exp, tmap, fmap)
      val i0declst = list0_append (i0declst1, i0declst2)
      val inss = list0_append (inss1, inss2)
      val res_i0declst = list0_append (i0declst, res.0)
    in
      '(res_i0declst, res.1, Some0 inss)
    end
    | _ => let
      // The first dec must be guard
      val- cons (d2ec, d2eclst1) = d2eclist
      // turn d2ec into i0exp
      val- D2Cvaldecs (
        valkind, list_cons (v2aldec, list_nil ())) = d2ec.d2ecl_node
      val i0exp = i0transform_v2aldec2guardexp (sa, tmap, v2aldec)

      // val inss = i0transform_D2Cvaldecs (sa, v2aldeclst)


      val (i0declst1, inss1) = i0transform_d2eclist (sa, d2eclst1, tmap, fmap)
      val (i0declst2, inss2) = i0transform_d2exp_fbody (sa, d2exp, tmap, fmap)
      val i0declst = list0_append (i0declst1, i0declst2)
      val inss = list0_append (inss1, inss2)

      val res_i0declst = list0_append (i0declst, res.0)
      val gbranch = i0gbranch_make (i0exp, inss)
      val res_gbranchlst = gbranch :: res.1
    in
      '(res_i0declst, res_gbranchlst, res.2)
    end
  end
  val '(i0declst, gbranchlst, inssopt) = 
    list_foldright<c2lau><'(i0declst, i0gbranchlst, option0 i0inslst)> (
      c2laulst, '(nil0, nil0, None0))

  val ins = INS0random (gbranchlst, inssopt)
in
  (i0declst, list0_sing ins)
end  // end of [D2Eintrep]
| D2Evar (d2var) => exitlocmsg ("todo\n")
| _ => exitlocmsg (datcon_d2exp_node (node) + " is not allowed.\n")
end  // end of [D2Ecase]
| D2Eann_seff (d2exp) => i0transform_d2exp_fbody (sa, d2exp, tmap, fmap)
| D2Eann_type (d2exp, s2exp) => i0transform_d2exp_fbody (sa, d2exp, tmap, fmap)

// //
//   | D2Esing of (d2exp)
//   | D2Elist of (d2explst)
// //
//   | D2Etup of (d2explst)
// //
//   | D2Eseq of (d2explst)
// //
//   | D2Eselab of (d2exp, d2lablst)
// //
//   | D2Elam of (p2atlst, d2exp)
//   | D2Efix of (d2var, p2atlst, d2exp)
// //
//   | D2Eignored of ((*void*)) // HX: error-handling
// //
| _ => exitlocmsg (datcon_d2exp_node (node) + " todo")
end  // end of [i0transform_d2exp_fbody]

implement i0transform_d2eclist (sa, d2eclist, tmap, fmap) =
case+ d2eclist of
| list_cons (d2ecl, d2eclist1) => let
  val (i0declst1, inss1) = i0transform_d2ecl (sa, d2ecl, tmap, fmap)
  val (i0declst2, inss2) = i0transform_d2eclist (sa, d2eclist1, tmap, fmap)
  val i0declst = list0_append (i0declst1, i0declst2)
  val inss = list0_append (inss1, inss2)
in
  (i0declst, inss)
end
| list_nil () => (nil0, nil0)

implement i0transform_d2ecl (sa, d2ecl, tmap, fmap) = let
  val node = d2ecl.d2ecl_node
in
  case+ node of
  | D2Cimpdec (knd, i2mpdec) => exitlocmsg (
    datcon_d2ecl_node (node) + " not allowed")
  | D2Cfundecs (funkind, f2undeclst) => let
    val i0declst = i0transform_D2Cfundecs (sa, f2undeclst, tmap, fmap)
  in
    (i0declst, list0_nil ())
  end
  | D2Cvaldecs (valkind, v2aldeclst) => let
    val inss = i0transform_D2Cvaldecs (sa, tmap, v2aldeclst)
  in (nil0, inss) end
  | D2Cvardecs (v2ardeclst) => let
    val inss = i0transform_D2Cvardecs (sa, tmap, v2ardeclst)
  in (nil0, inss) end
  | D2Cdcstdecs (knd, d2cst) => (nil0, nil0)
  | D2Clocal (d2eclist(*head*), d2eclist(*body*)) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Cextcode (code) => exitlocmsg ("external code can only be at global level")
  | D2Cignored ((*void*)) => (nil0, nil0)
end


implement i0transform_D2Cvaldecs (sa, tmap, v2aldeclst) = let
in
case+ v2aldeclst of
| list_cons (v2aldec, v2aldeclst1) => let
  val ins = i0transform_v2aldec (sa, tmap, v2aldec)
  val inss1 = i0transform_D2Cvaldecs (sa, tmap, v2aldeclst1)
  val ret = list0_cons (ins, inss1)
in ret end
| list_nil () => list0_nil ()
end

implement i0transform_D2Cvardecs (sa, tmap, v2ardeclst) = let
in
case+ v2ardeclst of
| list_cons (v2ardec, v2ardeclst1) => let
  val ins = i0transform_v2ardec (sa, tmap, v2ardec)
  val inss1 = i0transform_D2Cvardecs (sa, tmap, v2ardeclst1)
  val ret = list0_cons (ins, inss1)
in ret end
| list_nil () => list0_nil ()
end

fun try_i0transform_d2exp2ins_assign (
  sa: stamp_allocator
  , tmap: s3typemap
  , d2exp: d2exp): option0 i0ins =
case+ d2exp.d2exp_node of
| D2Eassgn (exp1, exp2) => let
  val left = i0transform_d2exp_expvalue (sa, tmap, exp1)
  val right = i0transform_d2exp_expvalue (sa, tmap, exp2)
in
  Some0 (INS0assign (Some0 left, right))
end
| _ => None0 ()

implement i0transform_v2aldec (sa, tmap, v2aldec) = let
  val p2at = v2aldec.v2aldec_pat
  val d2exp = v2aldec.v2aldec_def
in
case+ try_i0transform_d2exp2ins_assign (sa, tmap, d2exp) of
| Some0 ins => ins
| None0 () => let
  val i0idopt = i0transform_p2at2holder (sa, tmap, p2at)
  val i0exp = i0transform_d2exp_expvalue (sa, tmap, d2exp)
in
  case+ i0idopt of
  | Some0 i0id => INS0decl (i0id, Some0 i0exp)
  | None0 () => INS0assign (None0, i0exp)
end
end


implement i0transform_v2aldec2guardexp (sa, tmap, v2aldec) = let
  val p2at = v2aldec.v2aldec_pat
  val d2exp = v2aldec.v2aldec_def
  val i0idopt = i0transform_p2at2holder (sa, tmap, p2at)
in
  case+ i0idopt of
  | Some0 _ => exitlocmsg ("guard with store is not supported yet.")
  | None0 () => let
    val i0exp = i0transform_d2exp_expvalue (sa, tmap, d2exp)
  in
    i0exp
  end
end


implement i0transform_v2ardec (sa, tmap, v2ardec) = let
  val name = v2ardec.v2ardec_name: d2var
  val d2expopt = v2ardec.v2ardec_init
  val i0id = i0transform_d2var (sa, tmap, name)
in
case+ d2expopt of
| Some d2exp => let
  val i0exp = i0transform_d2exp_expvalue (sa, tmap, d2exp)
in
  INS0decl (i0id, Some0 i0exp)
end
| None () => INS0decl (i0id, None0)
end

implement i0transform_d2exp_expvalue (sa, tmap, d2exp) = let
  val node = d2exp.d2exp_node
in
  case+ node of
  | D2Ecst (d2cst) => EXP0var (i0transform_d2cst (sa, tmap, d2cst))
  | D2Evar (d2var) => EXP0var (i0transform_d2var (sa, tmap, d2var))
//   | D2Esym of (d2sym)
// //
//   | D2Eint of (int)
//   | D2Eintrep of (string)
//   | D2Echar of (char)
//   | D2Efloat of (double)
//   | D2Estring of (string)
// //
  | D2Ei0nt (str) => EXP0i0nt (str)
//   | D2Ec0har of (char)
//   | D2Ef0loat of (string)
  | D2Es0tring (str) => EXP0string (str)
// //
//   | D2Eempty of ((*void*))
// //
//   | D2Eexp of (d2exp) // dummy
// //
//   | D2Elet of (d2eclist, d2exp)
// //
  | D2Eapplst (d2exp, d2exparglst) => let
    val i0id = i0transform_d2exp_fname (sa, tmap, d2exp)
    val i0explst = i0transform_d2exparglst (sa, tmap, d2exparglst)
    val app = EXP0app (i0id, i0explst)
  in
    app
  end
// //
  | D2Eifopt (
      d2exp(*test*), d2exp(*then*), d2expopt(*else*)
    ) => exitlocmsg (
         datcon_d2exp_node (node) + 
         " not allowed in simple expression")
// //
  | D2Esing (d2exp) => i0transform_d2exp_expvalue (sa, tmap, d2exp)
//   | D2Elist of (d2explst)
// //
//   | D2Etup of (d2explst)
// //
//   | D2Eseq of (d2explst)
// //
//   | D2Eselab of (d2exp, d2lablst)
// //
//   | D2Elam of (p2atlst, d2exp)
//   | D2Efix of (d2var, p2atlst, d2exp)
  | D2Eextfcall (s2exp, name, d2explst) => let
    val i0explst = i0transform_d2explst_expvalue (sa, tmap, d2explst)
  in
    EXP0extfcall (name, i0explst)
  end
  | D2Elam_dyn (npf, p2atlst, d2exp) => 
    if (length p2atlst > 0) then 
      exitlocmsg ("lambda with parameters is not allowed")
  else let
    val i0exp = i0transform_d2exp_expvalue (sa, tmap, d2exp)
  in
    EXP0lambody i0exp
  end
  | D2Elam_sta (_, _, d2exp) => i0transform_d2exp_expvalue (sa, tmap, d2exp)
  | D2Eassgn (_, _) => exitlocmsg (
    "This should not happen. D2Eassgn is processed elsewhere")
//   | D2Eignored of ((*void*)) // HX: error-handling
  | _ => exitlocmsg (datcon_d2exp_node (node) + " not allowed")
// //
end  // end of [i0transform_d2exp_expvalue]


implement i0transform_d2exp_fname (sa, tmap, d2exp) = let
  val node = d2exp.d2exp_node
  // val () = fprint! (stdout_ref, 
  //   "======== i0transform_d2exp_fname: ", d2exp.d2exp_loc, "\n")
in
  case+ node of
  | D2Evar (d2var) => i0transform_d2var (sa, tmap, d2var)
  | D2Ecst (d2cst) => i0transform_d2cst (sa, tmap, d2cst)
  | D2Esym (d2sym) => i0transform_d2sym (sa, d2sym)
  | _ => exitlocmsg (datcon_d2exp_node (node) + " not allowed")
end  // end of [i0transform_d2exp_fname]


implement i0transform_d2exparglst (sa, tmap, d2exparglst) = let
in
case+ d2exparglst of
| list_cons (d2exparg, d2exparglst1) =>
  (
  case+ d2exparg of
  | D2EXPARGsta () => i0transform_d2exparglst (sa, tmap, d2exparglst1)
  | D2EXPARGdyn (n, loc, d2explst) =>
    (
    case+ d2exparglst1 of
    | list_cons (_, _) => 
      exitlocmsg ("f (x, y) (a, b) not allowed")
    | list_nil () => i0transform_d2explst_expvalue (sa, tmap, d2explst)
    )
  )
| list_nil () => exitlocmsg ("no args, check this")
end  // end of [i0transform_d2exparglst]

implement i0transform_d2explst_expvalue (sa, tmap, d2explst) =
case+ d2explst of
| list_cons (d2exp, d2explst1) => let
  val i0exp = i0transform_d2exp_expvalue (sa, tmap, d2exp)
  val i0explst = i0transform_d2explst_expvalue (sa, tmap, d2explst1)
in
  list0_cons (i0exp, i0explst)
end
| list_nil () => list0_nil ()

  




(* ************* ************** *)




































