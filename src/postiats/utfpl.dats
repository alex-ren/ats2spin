
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./utfpl.sats"

#include "./postiats_codegen2.hats"


implement the_utfpl_mgr_initialize () = let
  val () = the_symbol_mgr_initialize ()
in
end


implement fprint_funkind (out, k) = fprint (out, datcon_funkind<> (k))
implement fprint_valkind (out, k) = fprint (out, datcon_valkind<> (k))
implement fprint_casekind (out, k) = fprint (out, datcon_casekind<> (k))

