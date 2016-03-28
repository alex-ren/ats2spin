
#define ATS_DYNLOADFLAG 0

#include "share/atspre_staload.hats"

staload "./utils.sats"

implement mystring_append (s1, s2) = let
  val strptr = string0_append (s1, s2)
in
  strptr2string (strptr)
end


