


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload UN = $UNSAFE

staload "./../utils/utils.dats"

(* ************ ************* *)

staload "./promela.sats"
staload "./../utils/emiter.sats"
staload "./../instr0/instr0.sats"


#define :: list0_cons
#define nil list0_nil

extern fun pml_emit_i0fundef (i0fundef): eu

local

staload _(*anon*) = "{$PCRE}/DATS/pcre_ML.dats"
staload _(*anon*) = "{$PCRE}/DATS/pcre.dats"

in

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
  | Some (proc_name) => EUstring (proc_name)
  | None () => emit_i0id (fname)
end


end  // end of local

