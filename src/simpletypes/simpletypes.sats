(* ****** ****** *)

(*
** Author: Zhiqiang Ren
*)

staload "libats/ML/SATS/basis.sats"

staload "./../postiats/postiats.sats"
staload HT = "libats/ML/SATS/hashtblref.sats"

val is_debug_typechecking: ref bool

#define isdebug (!is_debug_typechecking)

(* ************* ************* *)

datatype s3rt =
| S3SRTtype
| S3SRTt0ype
| S3RTprop
| S3SRTview
| S3SRTviewtype
| S3SRTviewt0ype

(* tkind: type kind*)
datatype s3tkind =
| S3TKINDflat 
| S3TKINDboxed
| S3TKINDignored

fun s3tkind_make (int): s3tkind

fun{} fprint_s3tkind: fprint_type (s3tkind)
fun myfprint_s3tkind: fprint_type (s3tkind)

datatype s3element =
| S3ELEMENTint
| S3ELEMENTchar
| S3ELEMENTbool
| S3ELEMENTstring
| S3ELEMENTunit

fun{} fprint_s3element: fprint_type (s3element)

datatype s3type =
| S3TYPEref of ref (s3typeopt)
| S3TYPErefarg of (s3type)
| S3TYPEelement of (s3element)
| S3TYPErecord of (ref s3tkind, int (*npf*), s3labeltypelst)
| S3TYPEprop
| S3TYPEcon of (s2cst, s3typelst)
| S3TYPEfun of (ref int (*npf*)
                , s3typelst (*args*)
                , s3type (*res*)
                , int (*effect: -1: ignored, 0: false, 1: true*))
| S3TYPEvar of s2var
| S3TYPEpoly of (s2varlst, s3type)
| S3TYPEignored

where
s3typelst = list0 s3type

and s3typeopt = option0 s3type

and s3labeltype = '{
s3labeltype_label = label
, s3labeltype_type = s3type
}

and s3labeltypelst = list0 s3labeltype

fun s3labeltype_make (label, s3type): s3labeltype

fun fprint_s3labeltype: fprint_type (s3labeltype)

(* ************* ************* *)
fun myfprint_s3type : fprint_type (s3type)

fun{} datcon_s3type : (s3type) -> string
fun{} fprint_s3type : fprint_type (s3type)

(* ************* ************* *)

fun s3type_int (): s3type
fun s3type_char (): s3type
fun s3type_bool (): s3type
fun s3type_string (): s3type
fun s3type_unit (): s3type
fun s3type_ref (): s3type
fun s3type_fun (npf: int, ty_args: s3typelst, ty_res: s3type, effect: int): s3type

fun s3labeltype_make (label, s3type): s3labeltype

(* ************* ************* *)

abstype s3typemap = ptr

(* ************* ************* *)


typedef s3typelst = list0 (s3type)
typedef s3typeopt = option0 (s3type)

fun s3typemap_create (base: int): s3typemap
fun s3typemap_find_d2cst (s3typemap, d2cst): s3typeopt
fun s3typemap_find_d2var (s3typemap, d2var): s3typeopt
fun s3typemap_find_d2sym (s3typemap, d2sym): s3typeopt

fun s3typemap_update_d2cst (
  s3typemap: s3typemap, d2cst: d2cst, s3type: s3type): void
fun s3typemap_update_d2var (
  s3typemap: s3typemap, loc: location_type, d2var: d2var, s3type: s3type): void

// Create a new map, which has no S3TYPEref for d2cst and d2var.
fun s3typemap_normalize (tmap: s3typemap): s3typemap

// fun s3typemap_insert_d2sym (
//   s3typemap: s3typemap, d2sym: d2sym, s3type: s3type): void

fun fprint_s3typemap: fprint_type (s3typemap)
overload fprint with fprint_s3typemap
  

(* ************* ************* *)

// s3type is S3TYPEfun or S3TYPEpoly
fun s3type_get_funtype (s3type): s3type

// s3type is S3TYPEfun
fun s3type_get_rettype (s3type): s3type

(* ************* ************* *)

fun s3type_translate (s2exp): s3typeopt

// The output may contain less elements than the input
// due to the fact that some elements in the input
// are not "types".
fun s3type_translate_s2explst (s2explst): s3typelst


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
fun oftype_d2explst (d2explst: d2explst, tmap: s3typemap): s3typelst

fun oftype_p2at (p2at: p2at, tmap: s3typemap): s3type

fun oftype_d2cst (d2cst: d2cst, tmap: s3typemap, loc: location_type): s3type
fun oftype_d2var (d2var: d2var, tmap: s3typemap, loc: location_type): s3type
fun oftype_d2sym (d2sym: d2sym, tmap: s3typemap, loc: location_type): s3type





fun oftype_funhead_f2undec (f2undec, s3typemap): s3type
fun oftype_funhead_d2exp (d2exp, s3typemap): s3type

overload .oftype with oftype_d2exp
overload .oftype with oftype_d2var

(* ************* ************* *)

// type checking result
typedef tcresult = option0 string

fun s3type_match (s3typemap, s3type, s3type): tcresult
fun s3type_match_typelst (s3typemap, s3typelst, s3typelst): tcresult
fun s3type_match_labeltype (s3typemap, s3labeltype, s3labeltype): tcresult

(* ************* ************* *)

(*
* Erase unnecessary S3TYPEref.
*)
fun s3type_normalize (s3type): s3type
fun s3type_normalize_typelst (s3typelst): s3typelst

abstype s3poly_para_map = ptr
fun s3poly_para_map_create (): s3poly_para_map
fun s3poly_para_map_insert (s3poly_para_map, s2var, s3type): void
fun s3poly_para_map_find (s3poly_para_map, s2var): s3typeopt
fun s3poly_para_map_haskey (s3poly_para_map, s2var): bool

fun s3type_instantiate (s3type, s3poly_para_map): s3type
fun s3type_instantiate_typelst (s3typelst, s3poly_para_map): s3typelst

(* ************* ************* *)

fun s3type_export (max: int, prog: d2eclist): '(d2eclist, s3typemap)

(* ************* ************* *)

fun s3type_translate_S3Eapp_con (s2cst): s3typeopt

(* ************* ************* *)



