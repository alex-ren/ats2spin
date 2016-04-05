

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "./instr0.sats"

staload UTFPL = "./../postiats/utfpl.sats"

assume i0name = $UTFPL.symbol

implement i0name_make (s) = s

implement i0name_get_symbol (name) = name

