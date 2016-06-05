(* ****** ****** *)

(*
** Author: Zhiqiang Ren
*)

staload "libats/ML/SATS/basis.sats"

staload "./../postiats/postiats.sats"
staload HT = "libats/ML/SATS/hashtblref.sats"

datatype s3srt =
| S3SRTtype
| S3SRTt0ype
| S3RTprop
| S3SRTview
| S3SRTviewtype
| S3SRTviewt0ype

(* tkind: type kind*)
datatype s3tkind =
| S3TKINDflat | S3TKINDboxed

datatype s3type_node =
| S3TYPEref of ref (s3type_node)
| S3TYPEelement of (symbol)
| S3TYPErecord of (s3tkind, int (*npf*), s3labeltypelst)
| S3TYPEprop
| S3TYPEcon of (s2cst, s3typelst)
| S3TYPEfun of (int (*npf*)
                , s3typelst (*args*)
                , s3type (*res*)
                , bool (*effect*))
| S3TYPEvar of s2var
| S3TYPEpoly of (s2varlst, s3type)

where
s3type = '{
s3type_node = s3type_node
, s3type_srt = s3srt
}

and s3typelst = list0 s3type

and s3labeltype = '{
s3labeltype_label = label
, s3labeltype_type = s3type
}

and s3labeltypelst = list0 s3labeltype

fun s3labeltype_make (label, s3type): s3labeltype

(* ************* ************* *)

typedef s3type_map = $HT.hashtbl (stamp, s3type)

(* ************* ************* *)

typedef s3typemap = $HT.hashtbl (stamp, s3type)

typedef s3typelst = List0 (s3type)
typedef s3typeopt = Option (s3type)
vtypedef s3typeopt_vt = Option_vt (s3type)

fun s3typemap_create (): s3typemap
fun s3typemap_get_type (d2cst): s3type
fun s3typemap_get_type (d2var): s3type
fun s3typemap_get_type (d2sym): s3typelst

fun s3typemap_set_type (d2cst, s3type): void
fun s3typemap_set_type (d2var, s3type): void

(* ************* ************* *)

// s3type is S3TYPEfun or S3TYPEpoly
fun s3type_get_funtype (s3type): s3type

// s3type is S3TYPEfun
fun s3type_get_rettype (s3type): s3type

(* ************* ************* *)

fun s3typecheck_d2eclist (d2ecs: d2eclist, tmap: s3typemap): void
fun s3typecheck_d2ecl (d2ecl: d2ecl, tmap: s3typemap): void

fun s3typecheck_f2undec_body (f2undec, s3typemap): void

fun s3typecheck_v2aldec (v2aldec, s3typemap): void
fun s3typecheck_v2ardec (v2ardec, s3typemap): void

fun s3typecheck_d2exp (d2exp, s3type, s3typemap): void

(* ************* ************* *)

symintr .oftype
fun oftype_d2exp (d2exp: d2exp, tmap: s3typemap): s3type
fun oftype_d2var (d2var: d2var, tmap: s3typemap): s3type

fun oftype_f2undec_head (f2undec, s3typemap): s3type

overload .oftype with oftype_d2exp
overload .oftype with oftype_d2var

(* ************* ************* *)

// type checking result
typedef tcresult = option0 string

fun type_match (s3typemap, s3type, s3type): tcresult

(* ************* ************* *)






