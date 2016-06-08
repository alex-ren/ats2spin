
staload "./postiats.sats"


#codegen2("datcon", s2rt)

#codegen2("fprint", s2rt, fprint_s2rt)
#codegen2("fprint", s2exp_node, fprint_s2exp_node)

(* **************** **************** *)

#codegen2("datcon", d2ecl_node)
#codegen2("datcon", d2exp_node)
#codegen2("datcon", p2at_node)
#codegen2("datcon", funkind)
#codegen2("datcon", valkind)
#codegen2("datcon", casekind)

#codegen2("fprint", d2exp_node, fprint_d2exp_node)
#codegen2("fprint", d2ecl_node, fprint_d2ecl_node)
#codegen2("fprint", p2at_node, fprint_p2at_node)


