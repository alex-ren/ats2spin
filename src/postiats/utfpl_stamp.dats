(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./utfpl.sats"
staload "./../utils/emiter.sats"


staload HF = "libats/SATS/hashfun.sats"
staload "libats/ML/SATS/hashtblref.sats"

staload _ = "libats/DATS/hashfun.dats"

(* ****** ****** *)

assume stamp_t0ype = int

(* ****** ****** *)

implement stamp_make (x) = x

(* ****** ****** *)

implement
fprint_stamp
  (out, stamp) = fprint_int (out, stamp)
// end of [fprint_stamp]

implement
emit_stamp (stamp) = EUint (stamp)

(* ****** ****** *)

implement
compare_stamp_stamp (s1, s2) = g0int_compare (s1, s2)

implement
hash_stamp (s) = 
$UNSAFE.cast{ulint}
  ($HF.inthash_jenkins($UNSAFE.cast{uint32}(s)))

implement
eq_stamp_stamp (s1, s2) = g0int_eq (s1, s2)

implement
neq_stamp_stamp (s1, s2) = g0int_neq (s1, s2)

(* ****** ****** *)

(* end of [utfpl_stamp.dats] *)

