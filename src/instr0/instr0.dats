
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./../postiats/utfpl.sats"
staload "./../utils/utils.sats"
staload "./instr0.sats"

#include "./../postiats/postiats_codegen2.hats"

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

(* for qstruct_insert *)
staload _(*anon*) = "libats/DATS/qlist.dats"
staload _(*anon*) = "libats/ML/DATS/list0.dats"

(* ************** ************* *)
implement fprint_i0name (out, i0name) = let
  val () = fprint (out, i0name_get_symbol (i0name))
in
end

implement i0id_copy (i0id, sa) = let
  val name = i0id.i0id_name
  val stamp = stamp_allocate (sa)
in
  '{i0id_name = name
   ,i0id_stamp = stamp
  }
end

implement fprint_i0id (out, i0id) = let
  val () = fprint! (out, i0id.i0id_name, "_", i0id.i0id_stamp)
in
end

implement fprint_i0prog (out, i0prog) = let
  val () = fprint (out, "======== functions ========\n")
  
  val funcs = i0funmap_listize1 (i0prog.i0prog_i0funmap)
  implement 
  fprint_val<@(i0id, i0fundef)> (out, tup) = fprint (out, tup.1)

  val () = fprint_list0_sep<@(i0id, i0fundef)> (out, funcs, "\n\n")
  val () = fprint (out, "\n\n")
in
end

(* ********** ************ *)

implement i0transform_d2eclst_global (sa, d2ecs) = let
  val () = print ("======== i0transform_d2eclst_global\n")
  fun loop (
    d2ecs: d2eclist
    , fmap: i0funmap
    , gvs: &i0gvarlst
    ): void =
    case+ d2ecs of
    | list_cons (d2ec, d2ecs) => let
        val () = i0transform_d2ecl_global (sa, d2ec, fmap, gvs)
    in loop (d2ecs, fmap, gvs) end
    | list_nil () => ()
 
  val fmap = i0funmap_create (i2sz(2048))
  var gvs = list0_nil ()

  val () = loop (d2ecs, fmap, gvs)

  val prog = '{i0prog_i0funmap = fmap
              , i0prog_i0gvarlst = gvs
              }
in
  prog
end

implement i0transform_d2ecl_global (sa, d2ec, fmap, gvs) = let
  val () = print ("======== i0transform_d2ecl_global\n")
  val node = d2ec.d2ecl_node
in
  case+ node of
  | D2Cimpdec (knd, i2mpdec) => exitlocmsg (datcon_d2ecl_node (node))
  | D2Cfundecs (knd, f2undeclst) => 
      i0transform_D2Cfundecs (sa, f2undeclst, fmap, gvs)

  | D2Cvaldecs (valkind, v2aldeclst) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Clocal (d2eclist(*head*), d2eclist(*body*)) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Cignored () => ()
//   | _ => exitlocmsg (datcon_d2ecl_node (node) + " not supported")
end

fun f2undec_is_recursive (f: f2undec): bool = let
  val fvar = f.f2undec_var
  val- D2Elam (_, fbody) = f.f2undec_def.d2exp_node

  fun d2exp_is_fun (fexp: d2exp, fvar: d2var): bool =
    case+ fexp.d2exp_node of
    | D2Evar (name) => fvar = name
    | _ => false

  (* Desc:
  *    e: Body of a function.
  *)
  fun d2exp_has_tailcall (e: d2exp, fvar: d2var): bool =
    case+ e.d2exp_node of
    | D2Eexp (e1) => d2exp_has_tailcall (e1, fvar)
    | D2Elet (_, e1) => d2exp_has_tailcall (e1, fvar)
    | D2Eapplst (fexp, _) => d2exp_is_fun (fexp, fvar)
    | D2Eifopt (_, e1, e2opt) =>
        if (d2exp_has_tailcall (e1, fvar)) then true
        else (case+ e2opt of
             | Some (e2) => d2exp_has_tailcall (e2, fvar)
             | None () => false
             )
    | D2Esing (e1) => exitlocmsg ("D2Esing hit")
    | _ => false
in
  d2exp_has_tailcall (fbody, fvar)
end

implement 
i0transform_D2Cfundecs (sa, f2undeclst, fmap, gvs) = let
  val () = print ("======== i0transform_D2Cfundecs\n")
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
          val fname: i0id = i0transform_d2var (sa, f2un.f2undec_var) 
          val fnames = f2undeclst_collect_names (f2uns1)
        in
          list0_cons (fname, fnames)
        end
        | list_nil () => list0_nil ()
      }
    else list0_nil ()  // end of [val fnames]

  val () = loop (sa, fnames, f2undeclst, fmap, gvs) where {
    fun loop (
      sa: stamp_allocator
      , group: i0idlst
      , f2undeclst: f2undeclst
      , fmap: i0funmap
      , gvs: &i0gvarlst): void =
      case+ f2undeclst of
      | list_cons (f2undec, f2undeclst1) => let
        val () = i0transform_fundec (sa, fnames, f2undec, fmap, gvs)
      in
        loop (sa, group, f2undeclst1, fmap, gvs)
      end
      | list_nil () => ()
  }
in
end

implement i0transform_d2var (sa, d2var) = let
  val stamp = stamp_get_from_d2var (sa, d2var)
  val name = d2var_get_name (d2var)
  val i0name = i0name_make (name)
in
  '{i0id_name = i0name
  , i0id_stamp = stamp
  }
end

implement i0transform_d2cst (sa, d2cst) = let
  val stamp = stamp_get_from_d2cst (sa, d2cst)
  val name = d2cst_get_name (d2cst)
  val i0name = i0name_make (name)
in
  '{i0id_name = i0name
  , i0id_stamp = stamp
  }
end

implement i0transform_d2sym (sa, d2sym) = let
  val stamp = stamp_get_from_d2sym (sa, d2sym)
  val name = d2sym_get_name (d2sym)
  val i0name = i0name_make (name)
in
  '{i0id_name = i0name
  , i0id_stamp = stamp
  }
end


implement i0transform_fundec (sa, group, f2undec, fmap, gvs) = let
  val () = fprint! (stdout_ref, 
    "======== i0transform_fundec: ", f2undec.f2undec_var, "\n")

  val name = i0transform_d2var (sa, f2undec.f2undec_var)
  val- D2Elam (p2atlst, body) = f2undec.f2undec_def.d2exp_node
  val paralst = i0transform_p2atlst2paralst (sa, p2atlst)
  val inss = i0transform_d2exp_fbody (sa, body, fmap, gvs)

  val fundef = i0fundef_create (name, paralst, inss, group)
  val () = i0funmap_insert_any (fmap, name, fundef)
in end

implement i0transform_p2atlst2paralst (sa, p2atlst) = let
  val paralst = loop (p2atlst) where {
    fun loop (p2atlst: p2atlst): i0idlst =
    case+ p2atlst of
    | list_cons (p2at, p2atlst2) => let
      val para = i0transform_p2at2para (sa, p2at)
    in
      list0_cons (para, loop (p2atlst2))
    end
    | list_nil () => list0_nil ()
  }
in
  paralst
end

implement i0transform_p2at2para (sa, p2at) = let
  val () = fprint! (stdout_ref, 
    "======== i0transform_p2at2para: ", p2at.p2at_loc, "\n")
in
case+ p2at.p2at_node of
| P2Tany () => exitlocmsg ("Shall not happen")
| P2Tvar (d2var) => i0transform_d2var (sa, d2var)
| P2Tempty () => exitlocmsg ("Shall not happen")
| P2Tpat (p2at) => i0transform_p2at2para (sa, p2at)
| P2Trec (labp2atlst) => exitlocmsg ("Shall not happen")
| P2Tignored () => exitlocmsg ("Shall not happen")
end

implement i0transform_p2at2holder (sa, p2at) = let
  val () = fprint! (stdout_ref, 
    "======== i0transform_p2at2holder: ", p2at.p2at_loc, "\n")
in
case+ p2at.p2at_node of
| P2Tany () => None0 ()
| P2Tvar (d2var) => Some0 (i0transform_d2var (sa, d2var))
| P2Tempty () => None0 ()
| P2Tpat (p2at) => i0transform_p2at2holder (sa, p2at)
| P2Trec (labp2atlst) => exitlocmsg ("Shall not happen")
| P2Tignored () => exitlocmsg ("Shall not happen")
end


implement i0transform_d2exp_fbody (sa, body, fmap, gvs) = let
  val node = body.d2exp_node
  val () = fprint! (stdout_ref, 
    "======== i0transform_d2exp_fbody: ", body.d2exp_loc, "\n")
in
case+ node of
| D2Ecst (d2cst) => let
  val i0id = i0transform_d2cst (sa, d2cst)
  val i0exp = EXP0var (i0id)
  val inss = list0_sing (INS0return (Some0 i0exp))
in
  inss
end
| D2Evar (d2var) => let
  val i0id = i0transform_d2var (sa, d2var)
  val i0exp = EXP0var (i0id)
  val inss = list0_sing (INS0return (Some0 i0exp))
in
  inss
end
//   | D2Esym of (d2sym)
// //
//   | D2Eint of (int)
//   | D2Eintrep of (string)
//   | D2Echar of (char)
//   | D2Efloat of (double)
//   | D2Estring of (string)
// //
//   | D2Ei0nt of (string)
//   | D2Ec0har of (char)
//   | D2Ef0loat of (string)
//   | D2Es0tring of (string)
// //
| D2Eempty ((*void*)) => list0_cons (INS0return (None0 ()), list0_nil ())
// //
| D2Eexp (d2exp) => i0transform_d2exp_fbody (sa, d2exp, fmap, gvs)
// //
| D2Elet (d2eclist, d2exp) => let
  val inss1 = i0transform_d2eclist (sa, d2eclist, fmap, gvs)
  val inss2 = i0transform_d2exp_fbody (sa, d2exp, fmap, gvs)
in
  list0_append (inss1, inss2)
end
| D2Eapplst (d2exp, d2exparglst) => let
    val i0id = i0transform_d2exp_fname (sa, d2exp)
    val i0explst = i0transform_d2exparglst (sa, d2exparglst)
    val app = EXP0app (i0id, i0explst)
  in
    list0_sing (INS0return (Some0 app))
  end
// //
   | D2Eifopt (
       d2exp1(*test*), d2exp2(*then*), d2expopt(*else*)
     ) => let
       val i0exp = i0transform_d2exp_expvalue (sa, d2exp1)
       val inss1 = i0transform_d2exp_fbody (sa, d2exp2, fmap,gvs)
       val inss2 = (case+ d2expopt of
                    | Some (d2exp) => 
                        i0transform_d2exp_fbody (sa, d2exp, fmap, gvs)
                    | None () => list0_sing (INS0return (None0))
       )
    in
      list0_sing (INS0ifbranch (i0exp, inss1, inss2))
    end
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
end

implement i0transform_d2eclist (sa, d2eclist, fmap, gvs) =
case+ d2eclist of
| list_cons (d2ecl, d2eclist1) => let
  val inss1 = i0transform_d2ecl (sa, d2ecl, fmap, gvs)
  val inss2 = i0transform_d2eclist (sa, d2eclist1, fmap, gvs)
  val inss = list0_append (inss1, inss2)
in
  inss
end
| list_nil () => list0_nil ()

implement i0transform_d2ecl (sa, d2ecl, fmap, gvs) = let
  val node = d2ecl.d2ecl_node
in
  case+ node of
  | D2Cimpdec (knd, i2mpdec) => exitlocmsg (
    datcon_d2ecl_node (node) + " not allowed")
  | D2Cfundecs (funkind, f2undeclst) => let
    val () = i0transform_D2Cfundecs (sa, f2undeclst, fmap, gvs)
  in
    list0_nil ()
  end
  | D2Cvaldecs (valkind, v2aldeclst) => let
    val inss = i0transform_D2Cvaldecs (sa, v2aldeclst)
  in inss end
  | D2Clocal (d2eclist(*head*), d2eclist(*body*)) => exitlocmsg (
          datcon_d2ecl_node (node) + " not supported")
  | D2Cignored ((*void*)) => list0_nil ()
end


implement i0transform_D2Cvaldecs (sa, v2aldeclst) = let
in
case+ v2aldeclst of
| list_cons (v2aldec, v2aldeclst1) => let
  val ins = i0transform_v2aldec (sa, v2aldec)
  val inss1 = i0transform_D2Cvaldecs (sa, v2aldeclst1)
  val ret = list0_cons (ins, inss1)
in ret end
| list_nil () => list0_nil ()
end

implement i0transform_v2aldec (sa, v2aldec) = let
  val p2at = v2aldec.v2aldec_pat
  val d2exp = v2aldec.v2aldec_def
  val i0idopt = i0transform_p2at2holder (sa, p2at)
  val i0exp = i0transform_d2exp_expvalue (sa, d2exp)
  val ins = INS0assign (i0idopt, i0exp)

in
  ins
end

implement i0transform_d2exp_expvalue (sa, d2exp) = let
  val node = d2exp.d2exp_node
in
  case+ node of
//   | D2Ecst of (d2cst)
  | D2Evar (d2var) => let
    val i0id = i0transform_d2var (sa, d2var)
  in
    EXP0var (i0id)
  end
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
//   | D2Es0tring of (string)
// //
//   | D2Eempty of ((*void*))
// //
//   | D2Eexp of (d2exp) // dummy
// //
//   | D2Elet of (d2eclist, d2exp)
// //
  | D2Eapplst (d2exp, d2exparglst) => let
    val i0id = i0transform_d2exp_fname (sa, d2exp)
    val i0explst = i0transform_d2exparglst (sa, d2exparglst)
    val app = EXP0app (i0id, i0explst)
  in
    app
  end
// //
  | D2Eifopt (
      d2exp(*test*), d2exp(*then*), d2expopt(*else*)
    ) => exitlocmsg (
         datcon_d2exp_node (node) + " not allowed in simple expression")
// //
  | D2Esing (d2exp) => i0transform_d2exp_expvalue (sa, d2exp)
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
| _ => exitlocmsg (datcon_d2exp_node (node) + " not allowed")
// //
end  // end of [i0transform_d2exp_expvalue]


implement i0transform_d2exp_fname (sa, d2exp) = let
  val node = d2exp.d2exp_node
  val () = fprint! (stdout_ref, 
    "======== i0transform_d2exp_fname: ", d2exp.d2exp_loc, "\n")
in
  case+ node of
  | D2Evar (d2var) => i0transform_d2var (sa, d2var)
  | D2Ecst (d2cst) => i0transform_d2cst (sa, d2cst)
  | D2Esym (d2sym) => i0transform_d2sym (sa, d2sym)
  | _ => exitlocmsg (datcon_d2exp_node (node) + " not allowed")
end  // end of [i0transform_d2exp_fname]


implement i0transform_d2exparglst (sa, d2exparglst) = let
in
case+ d2exparglst of
| list_cons (d2exparg, d2exparglst1) =>
  (
  case+ d2exparg of
  | D2EXPARGsta () => i0transform_d2exparglst (sa, d2exparglst1)
  | D2EXPARGdyn (n, loc, d2explst) =>
    (
    case+ d2exparglst1 of
    | list_cons (_, _) => 
      exitlocmsg ("f (x, y) (a, b) not allowed")
    | list_nil () => i0transform_d2explst_expvalue (sa, d2explst)
    )
  )
| list_nil () => exitlocmsg ("no args, check this")
end  // end of [i0transform_d2exparglst]

implement i0transform_d2explst_expvalue (sa, d2explst) =
case+ d2explst of
| list_cons (d2exp, d2explst1) => let
  val i0exp = i0transform_d2exp_expvalue (sa, d2exp)
  val i0explst = i0transform_d2explst_expvalue (sa, d2explst1)
in
  list0_cons (i0exp, i0explst)
end
| list_nil () => list0_nil ()

  




(* ************* ************** *)

implement fprint_val<i0id> = fprint_i0id




































