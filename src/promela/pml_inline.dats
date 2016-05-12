
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./promela.sats"

implement pml_inline_make (name, paralst, seq) = 
'{ pml_inline_name = name
 , pml_inline_paralst = paralst
 , pml_inline_seq = seq
}

