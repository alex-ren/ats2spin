

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./utfpl.sats"

implement fprint_c2lau (out, c2lau) = let
  val () = fprint! (out, "(", c2lau.c2lau_patlst, ") => ", c2lau.c2lau_body)
in end

implement fprint_c2laulst (out, c2laulst) = let
implement
fprint_val<c2lau> = fprint_c2lau
implement
fprint_list$sep<> (out) = fprint_string (out, ",\n")
//
in
  fprint_list<c2lau> (out, c2laulst)
end // end of [fprint_c2laulst]




