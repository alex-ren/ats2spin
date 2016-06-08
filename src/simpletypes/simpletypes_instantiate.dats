

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"


staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"

#include "./../postiats/postiats_codegen2.hats"
#include "./simpletypes_codegen2.hats"

implement s3type_instantiate (s3type, map) =
case+ s3type of
| S3TYPEref (s3typeopt_ref) =>
(
case+ !s3typeopt_ref of
| None0 () => s3type
| Some0 (ty) => let
  val ty1 = s3type_instantiate (ty, map)
  val () = !s3typeopt_ref := Some0 ty1
in
  s3type
end
)
//
| S3TYPErefarg (s3type) => let
  val ty = s3type_instantiate (s3type, map)
in
  S3TYPErefarg (ty)
end
| S3TYPEelement (s3element) => s3type
| S3TYPErecord (s3tkindref, npf, s3labeltypelst) => let
  val s3labeltypelst1 = list0_foldright (s3labeltypelst, fopr, nil0) where {
  fun fopr (s3labeltype: s3labeltype
            , res: s3labeltypelst):<cloref1> s3labeltypelst = let
    val lab = s3labeltype.s3labeltype_label
    val type0 = s3labeltype.s3labeltype_type
    val type1 = s3type_instantiate (type0, map)
    val labtype = s3labeltype_make (lab, type1)
  in
    cons0 (labtype, res)
  end
  }
in
  S3TYPErecord (s3tkindref, npf, s3labeltypelst1)
end
| S3TYPEprop () => s3type

| S3TYPEcon (s2cst, s3typelst) => let
  val s3typelst1 = s3type_instantiate_typelst (s3typelst, map)
in
  S3TYPEcon (s2cst, s3typelst1)
end
| S3TYPEfun (npfref, args, res, eff) => let
  val args1 = s3type_instantiate_typelst (args, map)
  val res1 = s3type_instantiate (res, map)
in
  S3TYPEfun (npfref, args1, res1, eff)
end
| S3TYPEvar s2var => let
  val s3typeopt = s3poly_para_map_find (map, s2var)
in
  case+ s3typeopt of
  | Some0 s3type1 => s3type1
  | None0 () => s3type
end
| S3TYPEpoly (s2varlst, s3type) => let
  // assert that no para is in the map
  fun assert (s2varlst: s2varlst): void =
  case+ s2varlst of
  | cons0 (s2var1, s2varlst1) =>
    if s3poly_para_map_haskey (map, s2var1) then exitlocmsg ("This should not happen")
    else assert (s2varlst1)
  | nil0 () => ()

  val () = assert (s2varlst)

  val ty = s3type_instantiate (s3type, map)
in
  S3TYPEpoly (s2varlst, ty)
end

| S3TYPEignored () => s3type
// end of [s3type_instantiate]

implement s3type_instantiate_typelst (s3typelst, map) = let
  val s3typelst1 = list0_foldright (s3typelst, fopr, nil0) where {
  fun fopr (type0: s3type
            , res: s3typelst):<cloref1> s3typelst = let
    val type1 = s3type_instantiate (type0, map)
  in
    cons0 (type1, res)
  end
  }
in
  s3typelst1
end


