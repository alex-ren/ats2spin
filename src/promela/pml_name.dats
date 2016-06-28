

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./promela.sats"

staload "./../postiats/postiats.sats"

assume pml_name = '{
  pml_name_name = string
  , pml_name_stamp = stamp
  , pml_name_type = pml_type
  , pml_name_extdef = option0 string
}

implement pml_name_get_name (pml_name) = pml_name.pml_name_name

implement pml_name_get_stamp (pml_name) = pml_name.pml_name_stamp

implement pml_name_make (name, stamp, pml_type, extdef) = 
'{ pml_name_name = name
 , pml_name_stamp = stamp
 , pml_name_type = pml_type
 , pml_name_extdef = extdef
}

implement pml_name_tag = pml_name_make (
  PML_NAME_FOR_CTOR, stamp_make (0), PMLTYPE_ignore, Some0 PML_NAME_FOR_CTOR)

implement pml_name_get_type (pml_name) = pml_name.pml_name_type

implement tostring_pml_name (pml_name) = 
case+ pml_name.pml_name_extdef of
| Some0 (extdef) => extdef
| None0 () => let
  val stamp_str = tostring_stamp (pml_name.pml_name_stamp)
  val name = pml_name.pml_name_name  + "_" + stamp_str
in
  name
end

implement fprint_pml_name (out, pml_name) = let
  val name = tostring_pml_name (pml_name)
in
  fprint (out, name)
end

implement fprint_val<pml_name> = fprint_pml_name

