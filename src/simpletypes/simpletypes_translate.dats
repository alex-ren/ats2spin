

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

#include "./../postiats/postiats_codegen2.hats"
#include "./simpletypes_codegen2.hats"

(* ************ ************* *)

implement s3type_translate (s2exp) = let
val srt = s2exp.s2exp_sort
in
if ~s2rt_is_type (srt) then None0 ()
else let
val node = s2exp.s2exp_node
in
case+ node of
| S2Ecst (s2cst) => exitlocmsg ("todo\n")
| S2Evar (s2var) =>
  if s2var_is_type (s2var) then Some0 (S3TYPEvar (s2var))
  else None0 ()
| S2Eextkind (symbol) => exitlocmsg ("S3Eextkind should not be seen.")
| S2Eapp (s2exp1, s2explst) => let
  val- S2Ecst (s2cst_con) = s2exp1.s2exp_node
  val srt_con = s2cst_get_sort (s2cst_con)




| S2Eeqeq of (s2exp, s2exp)
| S2Eexi of (s2varlst, s2explst (*predicates*), s2exp (*body*))
| S2Euni of (s2varlst, s2explst (*predicates*), s2exp (*body*))
| S2Efun of (int (*npf*), s2explst (*args*), s2exp (*res*))
| S2Eint of int
| S2Eintinf of int
| S2Einvar of s2exp
| S2Esizeof of s2exp
| S2Etyrec of ((*knd, *) int (*npf*), labs2explst)
(* This is for the return type of a function whose parameters use
* reference type.
*)
| S2Ewthtype of (s2exp (*, todo: WTHS2EXPLST*))
| S2Etop of (s2exp)
| S2Erefarg of (s2exp)
| S2Eignored
| S2Eerr
