

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./promela.sats"

staload "./../postiats/utfpl.sats"

assume pml_uname = symbol

implement fprint_pml_uname (out, pml_uname) = let
  val () = fprint_symbol (out, pml_uname)
in end

implement fprint_val<pml_uname> = fprint_pml_uname

