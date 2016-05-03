


#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./promela.sats"

implement pml_decl_make (visible, type, ivarlst) =
'{ pml_decl_visible = visible
 , pml_decl_type = type
 , pml_decl_ivarlst = ivarlst
}

