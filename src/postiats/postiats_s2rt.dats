
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./postiats.sats"

#include "./postiats_codegen2.hats"

implement fprint_val<s2rt> = fprint_s2rt
implement fprint_val<symbol> = fprint_symbol


implement s2rt_is_type (srt) =
case+ srt of
| S2RTbas (sym) =>
  (
  case+ sym.tostring () of
  | SORT_TYPE => true
  | SORT_T0YPE => true
  | SORT_T_AT_YPE => true
  | SORT_VIEWTYPE => true
  | SORT_VIEWT0YPE => true
  | SORT_VIEWT_AT_YPE => true
  | SORT_PROP => true
  | SORT_VIEW => true  
  | _ => false
  )
| _ => false


implement myfprint_s2rt (out, s2rt) = fprint_s2rt (out, s2rt)


