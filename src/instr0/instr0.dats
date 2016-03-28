
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./../postiats/utfpl.sats"
staload "./../utils/utils.sats"

staload "./instr0.sats"

#include "./../postiats/postiats_codegen2.hats"

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"

staload "prelude/SATS/list.sats"
staload _(*anon*) = "prelude/DATS/list.dats"


typedef i0id_struct = '{
  i0id_name = symbol
, i0id_stamp = stamp
}  // end of [i0id_struct]

assume i0id = i0id_struct


(* for typedef unmap = $HT.hashtbl (i0id, fundef) *)
 
// implement $HT.hash_key<i0id> (x) = hash_stamp (x.i0id_stamp)
//  
// implement
// $HT.equal_key_key<i0id> (k1, k2) = eq_stamp_stamp (k1, k2)

// implement $HT.hash_key<i0id> (x) = hash_stamp (x.i0id_stamp)
// 
// implement
// $HT.equal_key_key<i0id> (k1, k2) = eq_stamp_stamp (k1.i0id_stamp, k2.i0id_stamp)

(* ************** ************* *)

implement transform_d2eclst (d2ecs) = let
  fun loop (
    d2ecs: d2eclist
    , fmap: funmap
    , gvs: & List0 i0gvar >> _
    ): void =
    case+ d2ecs of
    | list_cons (d2ec, d2ecs) => 
        transform_d2ecl (d2ec, fmap, gvs)
    | list_nil () => ()
 
  val fmap = $HT.hashtbl_make_nil<i0id, fundef> (i2sz(2048))
  var gvs = list_nil ()

  val () = loop (d2ecs, fmap, gvs)

  val prog = (fmap, gvs)
in
  prog
end

implement transform_d2ecl (d2ec, fmap, gvs) = let
  val node = d2ec.d2ecl_node
in
  case+ node of
  | D2Cimpdec (knd, i2mpdec) => exitlocmsg (datcon_d2ecl_node (node))
  | D2Cfundecs (knd, f2undeclst) => 
      transform_D2Cfundecs (f2undeclst, fmap, gvs)
  | _ => exitlocmsg (datcon_d2ecl_node (node))
end

implement transform_D2Cfundecs (
  f2undeclst, fmap, gvs): void = let
    implement list_foreach$fwork<f2undec><i0gvarlst> (x, env) =
      transform_f2undec (x, fmap, env)
  in
    list_foreach_env (f2undeclst, gvs)
  end


