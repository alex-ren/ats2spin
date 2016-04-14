

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload UN = $UNSAFE

staload "{$PCRE}/SATS/pcre_ML.sats"

fun {} string_startwith (self: string, prfx: string): bool = 
  string_is_prefix (prfx, self)

extern fun {} string_get_suffix {n:int}{i:nat| i <= n} (
   self: string n, st: int i): string (n - i) 

overload .startWith with string_startwith

fun {} string_remove_prefix (
  self: string, prfx: string): Option string =
if self.startWith (prfx) then let
  val len = length (prfx)
  val ptr = ptr_add<char> (string2ptr (self), len)
  val str = $UN.cast{string} (ptr)
  val str = string_copy (str)
in
  Some (str)
end else None

overload .removePrefix with string_remove_prefix


exception not_supported of string


macdef exitlocmsg(m) = exit_errmsg (1, ,(m) + "\n" + $mylocation)

// fun {a:t@ype} fprint_list0: (fileref, list0 a) -> void
// fun {} fprint_list0_lpara: (fileref) -> void
// fun {} fprint_list0_rpara: (fileref) -> void
// fun {} fprint_list0_sep: (fileref) -> void
// fun {a:t@ype} fprint_list0_carg: (fileref, a) -> void

