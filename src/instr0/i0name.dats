

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "./instr0.sats"
staload "./../utils/emiter.sats"

staload "./../postiats/postiats.sats"

assume i0name = symbol

implement i0name_make (s) = s

implement i0name_get_symbol (name) = name

implement tostring_i0name (name) = tostring_symbol (name)

implement emit_i0name (name) = EUstring (tostring_symbol (name))

implement fprint_i0name (out, i0name) = let
  val () = fprint_symbol (out, i0name)
in
end

implement eq_i0name_i0name (n1, n2) = eq_symbol_symbol (n1, n2)


