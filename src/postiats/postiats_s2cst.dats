
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"

staload "./../utils/utils.dats"

(* ************ ************* *)

//
(* ****** ****** *)

staload "./postiats.sats"

(* ****** ****** *)
//
implement
eq_s2cst_s2cst
  (d2c1, d2c2) = compare (d2c1, d2c2) = 0
implement
neq_s2cst_s2cst
  (d2c1, d2c2) = compare (d2c1, d2c2) != 0
//
(* ****** ****** *)

typedef
s2cst_struct = @{
  s2cst_name= symbol
, s2cst_stamp= stamp
, s2cst_sort = s2rt
, s2cst_dconlst = dconlst
} (* end of [s2cst_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume s2cst_type = ref (s2cst_struct)
//
in (* in of [local] *)


implement
s2cst_make
  (name, stamp, s2rt, dconlst) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<s2cst_struct> ()
//
val () = p->s2cst_name := name
val () = p->s2cst_stamp := stamp
val () = p->s2cst_sort := s2rt
val () = p->s2cst_dconlst := dconlst
//
in
  $UN.castvwtp0{s2cst}((pfat, pfgc | p))
end // end of [s2cst_make]

implement
s2cst_get_name
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->s2cst_name
end // end of [let]
) (* end of [s2cst_get_name] *)

implement s2cst_get_sort 
(s2cst) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2cst)
in
  p->s2cst_sort
end // end of [let]
) (* end of [s2cst_get_name] *)



implement
s2cst_get_stamp
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->s2cst_stamp
end // end of [let]
) (* end of [s2cst_get_stamp] *)


implement
s2cst_get_dconlst
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->s2cst_dconlst
end // end of [let]
) (* end of [s2cst_get_dconlst] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_s2cst
  (out, s2cst) =
(
  fprint! (out, s2cst.name(), "(", s2cst.stamp(), ")")
) (* end of [fprint_s2cst] *)

(* ****** ****** *)

implement
compare_s2cst_s2cst
  (s2cst1, s2cst2) = compare (s2cst1.stamp(), s2cst2.stamp())
// end of [compare_s2cst_s2cst]

(* ****** ****** *)

implement tostring_s2cst (s2cst) = let
  val s = s2cst.name ()
in s.tostring () end


(* end of [postiats_s2cst.dats] *)








