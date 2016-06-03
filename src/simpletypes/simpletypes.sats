(* ****** ****** *)

(*
** Author: Zhiqiang Ren
*)

staload "libats/ML/SATS/basis.sats"

staload "./../postiats/postiats.sats"

datatype s0srt =
| S0SRTtype
| S0SRTt0ype
| S0RTprop
| S0SRTview
| S0SRTviewtype
| S0SRTviewt0ype

datatype s0tkind =
| S0TKINDflat | S0TKINDboxed

datatype s0type_node =
| S0TYPEref of ref (s0type_node)
| S0TYPEelement of (symbol)
| S0TYPErecord of (s0tkind, int (*npf*), s0labeltypelst)
| S0TYPEprop
| S0TYPEcon of (s2cst, s0typelst)
| S0TYPEfun of (int (*npf*), s0typelst (*args*)
                , s0type (*res*), bool (*effect*))
| S0TYPEvar of s2var
| S0TYPEPoly of (s2varlst, s0type)

where
s0type = '{
S0TYPEnode = s0type_node
, S0TYPEsrt = s0srt
}

and s0typelst = list0 s0type

and s0labeltype = '{
s0labeltype_label = label
, s0labeltype_type = s0type
}

and s0labeltypelst = list0 s0labeltype


fun s0labeltype_make (label, s0type): s0labeltype

(* ************* ************* *)

abstype s0typemap_type
typedef s0typemap = s0typemap_type

fun s0typemap_create (): s0typemap
fun s0typemap_get_type (d2cst): s0type
fun s0typemap_get_type (d2var): s0type
fun s0typemap_get_type (d2sym): s0typelst

fun s0typemap_set_type (d2cst, s0type): void
fun s0typemap_set_type (d2var, s0type): void

(* ************* ************* *)

fun s0typecheck_d2eclist (tmap: s0typemap, d2ecs: d2eclist): void



