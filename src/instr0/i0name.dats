

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "./instr0.sats"
staload "./../utils/emiter.sats"

staload UTFPL = "./../postiats/utfpl.sats"

assume i0name = $UTFPL.symbol

implement i0name_make (s) = s

implement i0name_get_symbol (name) = name

implement tostring_i0name (name) = $UTFPL.tostring_symbol (name)

implement emit_i0name (name) = EUstring ($UTFPL.tostring_symbol (name))

implement fprint_i0name (out, i0name) = let
  val () = $UTFPL.fprint_symbol (out, i0name)
in
end


