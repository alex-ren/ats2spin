

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./promela.sats"

staload "./../postiats/utfpl.sats"

assume pml_name = '{
  pml_name_name = string
  , pml_name_stamp = stamp
  , pml_name_type = pml_type
}

implement pml_name_get_name (pml_name) = pml_name.pml_name_name

implement pml_name_make (name, stamp, pml_type) = 
'{ pml_name_name = name
 , pml_name_stamp = stamp
 , pml_name_type = pml_type
}

implement pml_name_get_type (pml_name) = pml_name.pml_name_type

implement fprint_pml_name (out, pml_name) = let
  val stamp_str = tostring_stamp (pml_name.pml_name_stamp)
  val name = pml_name.pml_name_name + "_" + stamp_str
in
  fprint (out, name)
end

implement fprint_val<pml_name> = fprint_pml_name

