(* ****** ******* *)
// fineprinter.dats
// Start: 2016/03/18
// Zhiqiang Ren
// aren@bu.edu
(* ****** ******* *)
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

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

implement fprint_emit_unit (out, eu) = 
  fprint_emit_unit_list (out, eu :: nil)

implement fprint_emit_unit_list (out, eus) = let
fun aux_level (out: FILEref, eus: eulist, level: int): int =
case+ eus of
| nil () => level
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
  | EUlist (eus0) => let
    val level0 = aux_level (out, eus0, level)
  in
    aux_level (out, eus, level0)
  end
  val level0 = aux_level (out, eus, 0)
in end


implement emit_unit_list_process (eus, sep, lwrapper, rwrapper) = let
  fun loop_tail (eus: eulist, res: eulist) =
  case+ eus of
  | cons0 (eu, eus1) => let
    val res = eu :: EUstring (sep) :: res
  in
    loop_tail (eus1, res)
  end
  | nil0 () => list0_reverse (EUstring (rwrapper) :: res)
in
  case+ eus of
  | cons0 (eu, eus1) => loop_tail (eus1, eu :: EUstring (lwrapper) :: nil0)
  | nil0 () => EUstring (lwrapper) :: EUstring (rwrapper) :: nil0
end

implement emit_list {a} (xs, sep, lwrapper, rwrapper, fopr) = let
  fun loop_tail (xs: list0 a, res: eulist) =
  case+ xs of
  | cons0 (x, xs1) => let
    val res = fopr (x) :: sep :: res
  in
    loop_tail (xs1, res)
  end
  | nil0 () => list0_reverse (rwrapper :: res)
in
  case+ xs of
  | cons0 (x, xs1) => loop_tail (xs1, fopr (x) :: lwrapper :: nil0)
  | nil0 () => lwrapper :: rwrapper :: nil0
end



