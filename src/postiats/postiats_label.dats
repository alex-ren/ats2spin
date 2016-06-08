(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"


//
(* ****** ****** *)

staload "./postiats.sats"

(* ****** ****** *)

implement
eq_label_label (l1, l2) = compare (l1, l2) = 0
implement
neq_label_label (l1, l2) = compare (l1, l2) != 0

(* ****** ****** *)

implement
compare_label_label
  (l1, l2) = let
in
//
case+ (l1, l2) of
  | (LABint i1, LABint i2) => compare (i1, i2)
  | (LABsym s1, LABsym s2) => compare (s1, s2)
  | (LABint i1, LABsym s2) => ~1
  | (LABsym s1, LABint i2) =>  1
//
end // end of [compare_label_label]

(* ****** ****** *)

implement
fprint_label
  (out, lab) = let
in
//
case+ lab of
| LABint (n) => fprint (out, n)
| LABsym (sym) => fprint (out, sym)
//
end // end of [fprint_label]

(* ****** ****** *)

implement tostring_label (label) =
case+ label of
| LABint (n) => "lab:" + tostring_int (n)
| LABsym (sym) => tostring_symbol (sym)


(* end of [postiats_label.dats] *)


