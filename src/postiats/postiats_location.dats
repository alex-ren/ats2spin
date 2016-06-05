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

staload "./postiats.sats"

(* ****** ****** *)

assume location_type = string

(* ****** ****** *)

implement
location_make (rep) = rep

(* ****** ****** *)

implement
fprint_location
  (out, loc) = fprint_string (out, loc)
// end of [fprint_location]

implement
location_tostring (loc) = loc

(* ****** ****** *)

(* end of [postiats_location.dats] *)
