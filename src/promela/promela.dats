


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./promela.sats"
staload "./../utils/emiter.sats"
staload "./../instr0/instr0.sats"

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/basis.sats"

#define :: list0_cons
#define nil list0_nil

staload _(*anon*) = "libats/ML/DATS/list0.dats"

implement pml_emit_i0prog (i0prog) = let
  val func_pairs = i0funmap_listize1 (i0prog.i0prog_i0funmap)
  val eus = list0_foldright<@(i0id, i0fundef)><eulist> (
    func_pairs, fopr, nil) where {
  fun fopr (pair: @(i0id, i0fundef), res: eulist):<cloref1> eulist = res
  }
in
  EUlist (eus)
end


