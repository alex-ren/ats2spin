
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

implement s3type_export (max, d2eclist) = let
  val tmap = s3typemap_create (max)
  val () = s3typecheck_d2eclist (d2eclist, tmap)
in
  '(d2eclist, tmap)
end

