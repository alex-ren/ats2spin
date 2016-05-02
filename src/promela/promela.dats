


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

implement pmltransform_i0prog (i0prog) = let
  val funmap = i0prog.i0prog_i0funmap
  val funcs = i0funmap_listize1 (funmap): list0 @(i0id, i0fundef)


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



