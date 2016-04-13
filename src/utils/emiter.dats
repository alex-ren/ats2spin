(* ****** ******* *)
// fineprinter.dats
// Start: 2016/03/18
// Zhiqiang Ren
// aren@bu.edu
(* ****** ******* *)

#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

staload "./emiter.sats"

staload "libats/ML/SATS/basis.sats"

#define :: list0_cons
#define nil list0_nil

implement emit_text (text) = EUstring text
implement emit_int (n) = EUint n

implement emit_newline () = EUnewline

implement emit_indent () = EUindent
implement emit_unindent () = EUunindent
implement emit_lwrapper () = EUlwrapper
implement emit_rwrapper () = EUrwrapper

fun fprint_indent (out: FILEref, level: int): void =
if level > 0 then let
  val () = fprint (out, "  ")
in
  fprint_indent (out, level - 1)
end

implement fprint_emit_unit_list (out, eus) = let
fun aux_level (out: FILEref, eus: eulist, level: int): void =
case+ eus of
| nil () => ()
| eu :: eus =>
  case+ eu of
  | EUindent () => aux_level (out, eus, level + 1)
  | EUunindent () => aux_level (out, eus, level - 1)
  | EUlwrapper () => (fprint (out, "("); aux_level (out, eus, level))
  | EUrwrapper () => (fprint (out, ")"); aux_level (out, eus, level))
  | EUnewline () => (fprint (out, "\n");
                    fprint_indent (out, level);
                    aux_level (out, eus, level)
                    )
  | EUstring (text) => (fprint (out, text); aux_level (out, eus, level))
  | EUint (n) => (fprint (out, n); aux_level (out, eus, level))
  | EUlist (eus0) => (aux_level (out, eus0, level);
                     aux_level (out, eus, level)
                     )
in
  aux_level (out, eus, 0)
end

