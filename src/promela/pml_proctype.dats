
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./promela.sats"

implement pml_proctype_make (name, paralst, seq) = 
'{ pml_proctype_name = name
 , pml_proctype_paralst = paralst
 , pml_proctype_seq = seq
}

