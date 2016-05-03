


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"



staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"
staload "./../utils/emiter.sats"
staload "./../instr0/instr0.sats"

#include "./../instr0/instr0_codegen2.hats"

#define :: list0_cons

#define EUs EUstring

(* ************ ************* *)

fun pml_name_make_startwith_prefix (i0id: i0id, pre: string): 
  Option (pml_name) = let
  val fullname_str = tostring_i0id (i0id)
  val opt = fullname_str.removePrefix (pre)
  val stamp = i0id.i0id_stamp
in
  case+ opt of
  | Some (name_str) => let
    val pml_name = pml_name_make (name_str, stamp, PMLTYPE_todo)
  in
    Some (pml_name)
  end
  | None () => None ()
end

fun pml_name_make_inline (i0id: i0id): Option (pml_name) = 
  pml_name_make_startwith_prefix (i0id, INLINE)

fun pml_name_make_proctype (i0id: i0id): Option (pml_name) =
  pml_name_make_startwith_prefix (i0id, PROCTYPE)

(* ************ ************* *)

implement pmltransform_i0prog (i0prog) = let
  val funmap = i0prog.i0prog_i0funmap
  val funcs = i0funmap_listize1 (funmap): list0 @(i0id, i0fundef)
  val modules = list0_foldright (funcs, fopr, nil0) where {
    fun fopr (x: @(i0id, i0fundef), res: pml_modulelst):<cloref1> pml_modulelst = let
      val pml_module = pmltransform_i0fundef (x.1)
    in
      pml_module :: res
    end
  }
in
  modules
end

implement pmltransform_i0fundef (i0fundef) = let
  val i0id = i0fundef_get_id (i0fundef)
  val pml_name_opt = pml_name_make_proctype (i0id)
in
  case+ pml_name_opt of
  | Some (pml_name) => pmltransform_proctype (pml_name, i0fundef)
  | None () => let
  val pml_name_opt = pml_name_make_inline (i0id)
in
  case+ pml_name_opt of
  | Some (pml_name) => pmltransform_inline (pml_name, i0fundef)
  | None () => exitlocmsg ("Not supported.")
end
end

implement pmltransform_inline (pml_namee, i0fundef) = exitlocmsg ("todo")

implement pmltransform_proctype (pml_name, i0fundef) = let
  // paralst
  val i0idlst = i0fundef_get_paralst (i0fundef)
  val pml_declst = list0_foldright (i0idlst, fopr, nil0) where {
    fun fopr (i0id: i0id, res: pml_declst):<cloref1> pml_declst = let
      val pml_name = pmltransform_i0id (i0id)
      val pml_ivar = PMLIVAR_name pml_name
      val pml_ivarlst = pml_ivar :: nil0

      val pml_type = pml_name_get_type (pml_name)

      val pml_decl = pml_decl_make (false, pml_type, pml_ivarlst)
    in
      pml_decl :: res
    end
  }

  val inss = i0fundef_get_instructions (i0fundef)
  val pml_steplst = pmltransform_i0inslst (inss)

  val proctype = pml_proctype_make (pml_name, pml_declst, pml_steplst)
in
  PMLMODULE_proctype (proctype)
end


implement pmltransform_i0id (i0id) = let
  val name = tostring_i0id (i0id)
  val stamp = i0id.i0id_stamp
  val type = pmltransform_i0type ()
in
  pml_name_make (name, stamp, type)
end


implement pmltransform_i0inslst (i0inslst) = let
fun loop (i0inslst: i0inslst, res: pml_steplst): pml_steplst =
case+ i0inslst of
| i0ins :: i0inslst => (
  case+ i0ins of
  | INS0decl (i0id) => exitlocmsg ("todo: " + datcon_i0ins i0ins)
  | INS0assign (i0id_opt, i0exp) => (
    if i0exp_is_inline_call (i0exp) then exitlocmsg ("todo")
    else case+ i0id_opt of
    | Some0 (i0id) => let
      val pml_name = pmltransform_i0id (i0id)
      val pml_type = pml_name_get_type (pml_name)
      val pml_exp = pmltransform_i0exp (i0exp)
      val pml_ivar = PMLIVAR_exp (pml_name, false, pml_exp)
      val pml_ivarlst = pml_ivar :: nil0
      val pml_decl = pml_decl_make (false (*visible*), pml_type, pml_ivarlst)
      val pml_declst = pml_decl :: nil0
      val pml_step = PMLSTEP_declst pml_declst
    in
      loop (i0inslst, pml_step :: res)
    end
    | None0 () => let 
      val pml_exp = pmltransform_i0exp (i0exp)
      val pml_stmnt = PMLSTMNT_exp (pml_exp)
      val pml_step = PMLSTEP_stmnt (pml_stmnt)
    in
      loop (i0inslst, pml_step :: res)
    end
    )  // end of [if i0exp_is_inline_call]
  | _ => exitlocmsg ("todo: " + datcon_i0ins i0ins)
)  // end of [i0ins :: i0inslst]
| nil0 () => res

in
  loop (i0inslst, nil0)
end



implement pmltransform_i0type () = PMLTYPE_todo

(* ******************  ****************** *)

extern fun pml_emit_i0fundef (i0fundef): eu
extern fun pml_emit_para (i0id): eu
extern fun pml_emit_ins (i0ins): eu

implement pml_emit_ins (i0ins) = let
  val datcon = datcon_i0ins i0ins
in
case+ i0ins of
| INS0decl (i0id) => exitlocmsg (datcon + " not suppported")
| _ => exitlocmsg (datcon + " not suppported")
end



implement pml_emit_para (i0id) = let
  val eu_type = EUs ("int ")
  val eu_name = emit_i0id (i0id)
in
  EUlist (eu_type :: eu_name :: nil0)
end

implement pml_emit_i0prog (i0prog) = let
  val func_pairs = i0funmap_listize1 (i0prog.i0prog_i0funmap)
  val eus = list0_foldright<@(i0id, i0fundef)><eulist> (
    func_pairs, fopr, nil0) where {
  fun fopr (pair: @(i0id, i0fundef), res: eulist):<cloref1> eulist = let
    val eu = pml_emit_i0fundef (pair.1)
    val res = eu :: EUnewline () :: EUnewline () :: res
  in res end
  }
in
  EUlist (eus)
end

implement pml_emit_i0fundef (i0fundef) = let
  val fname = i0fundef_get_id (i0fundef)
  val fname_str = tostring_i0id (fname)
in
  case+ fname_str.removePrefix (PROCTYPE) of
  | Some (proc_name) => let
    // proctype name
    val fname = EUstring (proc_name)

    // parameters
    val paras = i0fundef_get_paralst (i0fundef)
    val paras_eus = list0_foldright<i0id><eulist> (paras, fopr, nil0) where {
    fun fopr (para: i0id, res: eulist):<cloref1> eulist = let
      val eu = pml_emit_para (para)
      val ret = eu :: res
    in
      res
    end
    }

    val eus = EUs ("proctype") :: EUs " " :: fname :: EUlist (paras_eus) :: nil0
  in
    EUlist (eus)
  end
  | None () => let
    // inline function name
    val fname = emit_i0id (fname)

    // parameters
    val paras = i0fundef_get_paralst (i0fundef)
    val paras_eus = emit_list (paras
                             , EUstring "; "
                             , EUstring "("
                             , EUstring ")"
                             , lam x => pml_emit_para x)

    val inss = i0fundef_get_instructions (i0fundef)
    val inss_eus = emit_list (inss
                            , EUnewline
                            , EUlist (EUnewline :: EUstring "{" :: EUindent :: EUnewline :: nil0)
                            , EUlist (EUunindent :: EUnewline :: EUstring "}" :: nil0)
                            , lam x => pml_emit_ins x)

    val eus = EUs ("inline") :: EUs " " :: fname :: EUlist (paras_eus) ::
              EUlist (inss_eus) :: nil0
  in
    EUlist (eus)
  end


end



