
// #include "share/atspre_staload.hats"
// #include "share/atspre_define.hats"

staload "libats/ML/SATS/basis.sats"

fun mystring_append (s1: string, s2: string): string
overload + with mystring_append

exception not_supported of string


macdef exitlocmsg(m) = exit_errmsg (1, ,(m) + "\n" + $mylocation)

// fun {a:t@ype} fprint_list0: (fileref, list0 a) -> void
// fun {} fprint_list0_lpara: (fileref) -> void
// fun {} fprint_list0_rpara: (fileref) -> void
// fun {} fprint_list0_sep: (fileref) -> void
// fun {a:t@ype} fprint_list0_carg: (fileref, a) -> void


