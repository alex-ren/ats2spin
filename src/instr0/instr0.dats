

staload "./../postiats/utfpl.sats"
staload "./../utils/mymap.sats"
staload "./../utils/utils.sats"

staload "./instr0.sats"

#include "./../postiats/postiats_codegen2.hats"


implement transform_d2eclst (d2ecs) = let
  fun loop (
    d2ecs: d2eclist
    , fmap: mylinmap (i0id, fundef)
    , gvs: & List0 i0gvar >> _
    ): void =
    case+ d2ecs of
    | list_cons (d2ec, d2ecs) => 
        transform_d2ecl (d2ec, fmap, gvs)
    | list_nil () => ()

  val fmap = mylinmap_create ()
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
  | D2Cimpdec (knd, i2mpdec) => $raise not_supported (datcon_d2ecl_node (node))
  | _ => $raise not_supported (datcon_d2ecl_node (node))
end


