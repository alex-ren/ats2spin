


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

extern fun pml_emit_i0fundef (i0fundef): eu

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
  val fname_str1 = g1ofg0 fname_str
in
  // if string_start_with (fname_str1, "proctype") = 0 then let
  //   val strnptr = string_make_substring (fname_str1, i2sz 7, i2sz 1)
  //   val str = strnptr2string (strnptr)
  // in EUstring (str) end
  // else emit_i0id (fname)
  emit_i0id (fname)
end


