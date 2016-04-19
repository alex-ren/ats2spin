


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"



staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"
staload "./../utils/emiter.sats"
staload "./../instr0/instr0.sats"


#define :: list0_cons
#define nil list0_nil

#define EUs EUstring

extern fun pml_emit_i0fundef (i0fundef): eu
extern fun pml_emit_para (i0id): eu

implement pml_emit_para (i0id) = let
  val eu_type = EUs ("int ")
  // val eu_name = i0id_e
in
  eu_type
end

implement pml_emit_i0prog (i0prog) = let
  val func_pairs = i0funmap_listize1 (i0prog.i0prog_i0funmap)
  val eus = list0_foldright<@(i0id, i0fundef)><eulist> (
    func_pairs, fopr, nil) where {
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
    val eus = EUlist (EUs ("proctype") :: EUs " " :: fname :: nil0)

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

  in
    eus
  end
  | None () => emit_i0id (fname)
end



