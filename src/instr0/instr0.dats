
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./../postiats/utfpl.sats"
staload UTILS = "./../utils/utils.sats"
staload "./instr0.sats"

#include "./../postiats/postiats_codegen2.hats"

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"

staload HT = "libats/ML/SATS/hashtblref.sats"

(* For template *)
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"


typedef fundef_struct = '{
  is_tail_recursive = bool
  // Names for the functions in the same group,
  // including self. This is nil if the function
  // is not (mutually) tail recursive.
, func_group = list0 i0id
  // body of the function
, func_body = i0inslst
, func_paras = list0 i0id

}

// typedef i0funmap = $HT.hashtbl (i0id, i0fundef)
implement $HT.hash_key<i0id> (x) = hash_stamp (x.i0id_stamp)
 
implement
$HT.equal_key_key<i0id> (k1, k2) = eq_stamp_stamp (k1.i0id_stamp, k2.i0id_stamp)

implement $HT.hash_key<i0id> (x) = hash_stamp (x.i0id_stamp)

(* ************** ************* *)

implement i0transform_d2eclst_global (d2ecs) = let
  fun loop (
    d2ecs: d2eclist
    , fmap: i0funmap
    , gvs: &i0gvarlst
    ): void =
    case+ d2ecs of
    | list_cons (d2ec, d2ecs) => 
        i0transform_d2ecl_global (d2ec, fmap, gvs)
    | list_nil () => ()
 
  val fmap = $HT.hashtbl_make_nil<i0id, i0fundef> (i2sz(2048))
  var gvs = list0_nil ()

  val () = loop (d2ecs, fmap, gvs)

  val prog = (fmap, gvs)
in
  prog
end

implement i0transform_d2ecl_global (d2ec, fmap, gvs) = let
  val node = d2ec.d2ecl_node
in
  case+ node of
  | D2Cimpdec (knd, i2mpdec) => $UTILS.exitlocmsg (datcon_d2ecl_node (node))
  | D2Cfundecs (knd, f2undeclst) => 
      i0transform_D2Cfundecs (f2undeclst, fmap, gvs)
  | _ => $UTILS.exitlocmsg (datcon_d2ecl_node (node))
end

fun f2undec_is_recursive (f: f2undec): bool = let
  val fvar = f.f2undec_var
  val- D2Elam (_, fbody) = f.f2undec_def.d2exp_node

  fun d2exp_is_fun (fexp: d2exp, fvar: d2var): bool =
    case+ fexp.d2exp_node of
    | D2Evar (name) => fvar = name
    | _ => false

  fun d2exp_has_tailcall (e: d2exp, fvar: d2var): bool =
    case+ e.d2exp_node of
    | D2Eexp (e1) => $UTILS.exitlocmsg ("D2Eexp hit")
    | D2Elet (_, e1) => d2exp_has_tailcall (e1, fvar)
    | D2Eapplst (fexp, _) => d2exp_is_fun (fexp, fvar)
    | D2Eifopt (_, e1, e2opt) =>
        if (d2exp_has_tailcall (e1, fvar)) then true
        else (case+ e2opt of
             | Some (e2) => d2exp_has_tailcall (e2, fvar)
             | None () => false
             )
    | D2Esing (e1) => $UTILS.exitlocmsg ("D2Esing hit")
    | _ => false
in
  d2exp_has_tailcall (fbody, fvar)
end

implement 
i0transform_D2Cfundecs (f2undeclst, fmap, gvs) = let
  val len = list_length (f2undeclst)
  val is_recursive = (if (len > 1) then true
      else if (len = 1) then let
        val f = f2undeclst.head ()
      in
        f2undec_is_recursive (f)
      end else $UTILS.exitlocmsg ("This is impossible.")
  ): bool

  val fnames = if is_recursive then
      f2undeclst_collect_names (f2undeclst) where {
      fun f2undeclst_collect_names (f2uns: f2undeclst): i0idlst =
        case+ f2uns of
        | list_cons (f2un, f2uns1) => let
          val fname: i0id = i0transform_d2var (f2un.f2undec_var) 
          val fnames = f2undeclst_collect_names (f2uns1)
        in
          list0_cons (fname, fnames)
        end
        | list_nil () => list0_nil ()
      }
    else list0_nil ()   // end of [val fnames]

  val () = // transform each member of the list
in
end

////
  //
case+ f2undeclst of
| list_cons (f2undec, f2undeclst) => let
  val fundef = transform_f2undec_nonrecurive (f2undec, fmap, gvs)
  // todo add fundef into fmap
in transform_D2Cfundecs (f2undeclst, fmap, gvs) end
| list_nil () => ()

implement 
transform_f2undec_nonrecurive (f2undec, fmap, gvs) = let
  val funname = // todo get function name
  val f2unbody: d2exp = f2undec.f2undec_def
  val f2unbody_node = f2unbody.d2exp_node
  val- D2Elam (p2atlst, d2exp) = f2unbody_node
  





