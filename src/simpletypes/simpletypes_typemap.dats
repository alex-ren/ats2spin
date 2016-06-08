

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
staload "./../utils/utils.dats"

staload "./../postiats/postiats.sats"
staload "./simpletypes.sats"


// vtypedef s3typeopt_vt = Option_vt (s3type)

extern fun s3typemap_find_stamp (s3typemap, stamp): s3typeopt
extern fun s3typemap_update_stamp (
  s3typemap: s3typemap, stamp: stamp, s3type: s3type): void

(* *********** ***********) 
(* *********** ***********) 

local

staload HT = "libats/ML/SATS/hashtblref.sats"

staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
assume s3typemap = '{
  s3typemap_stampmap = $HT.hashtbl (stamp, s3type)
  , s3typemap_symbolmap = $HT.hashtbl (symbol, s3type)
  , s3typemap_counter = ref int
}

(* *********** ***********) 

fun s3type_var_create (tmap: s3typemap): s2var = let
  val counter = !(tmap.s3typemap_counter)
  val () = !(tmap.s3typemap_counter) := counter + 1
  val stamp = stamp_make (counter)
  val symbol = symbol_make ("aa")
  val sym_sort = symbol_make (SORT_T0YPE)
  val sort = S2RTbas (sym_sort)
  val s2var = s2var_make (symbol, stamp, sort)
in
  s2var
end

fun s3type_fun_type_create_1p1 (tmap: s3typemap): s3type = let
  val s2var = s3type_var_create (tmap)
  val s2varlst = cons0 (s2var, nil0 ())
  val ty_arg = S3TYPEvar (s2var)
  val ty_args = cons0 (ty_arg, cons0 (ty_arg, nil0 ()))
  val ty_ret = ty_arg

  val ty_fun = S3TYPEfun (ref (~1), ty_args, ty_ret, ~1)
  val ty_poly = S3TYPEpoly (s2varlst, ty_fun)
in
  ty_poly
end

(* *********** ***********) 

implement $HT.hash_key<stamp> (x) = hash_stamp (x)

implement
$HT.equal_key_key<stamp> (k1, k2) = eq_stamp_stamp (k1, k2)

(* *********** ***********) 

implement $HT.hash_key<symbol> (x) = hash_symbol (x)

implement
$HT.equal_key_key<symbol> (k1, k2) = eq_symbol_symbol (k1, k2)

(* *********** ***********) 
in (* in of [local] *)


implement s3typemap_create (base) = let
  val s3typemap_stampmap =  $HT.hashtbl_make_nil<stamp, s3type> (i2sz(2048))
  val s3typemap_symbolmap =  $HT.hashtbl_make_nil<symbol, s3type> (i2sz(2048))

  // add types for symbols
  val () = $HT.hashtbl_insert_any (
       s3typemap_symbolmap
       , symbol_make ("true_bool")
       , s3type_bool () )

  val () = $HT.hashtbl_insert_any (
       s3typemap_symbolmap
       , symbol_make ("false_bool")
       , s3type_bool () )



in
  '{ s3typemap_stampmap = s3typemap_stampmap
  , s3typemap_symbolmap = s3typemap_symbolmap
  , s3typemap_counter = ref base
  }
end

implement s3typemap_find_stamp (tmap, stamp) = 
case+ $HT.hashtbl_search (tmap.s3typemap_stampmap, stamp) of
| ~Some_vt (s3type) => Some0 s3type
| ~None_vt () => None0

implement
s3typemap_update_stamp
  (tmap, stamp, s3type) = 
  $HT.hashtbl_insert_any (tmap.s3typemap_stampmap, stamp, s3type)

(* ************* ************* *)

implement s3typemap_find_d2sym (tmap, d2sym) = let
  val res = $HT.hashtbl_search (
    tmap.s3typemap_symbolmap
    , d2sym_get_name (d2sym))
in
  case+ res of
  | ~Some_vt (s3type) => Some0 s3type
  | ~None_vt () => let
    val symbol = d2sym_get_name (d2sym)
    val name = symbol.tostring ()
  in
    case+ name of  // These symbols don't go into map.
    | "+" => Some0 (s3type_fun_type_create_1p1 (tmap))
    | "-" => Some0 (s3type_fun_type_create_1p1 (tmap))
    | "*" => Some0 (s3type_fun_type_create_1p1 (tmap))
    | "/" => Some0 (s3type_fun_type_create_1p1 (tmap))
    | _ => None0 ()

  end
end

// implement s3typemap_insert_d2sym (tmap, d2sym, s3type) = let
//   val () = 
//     $HT.hashtbl_insert_any (
//       tmap.s3typemap_symbolmap
//       , d2sym_get_name d2sym
//       , s3type)
// in end

end  // end of [local]

(* ************* ************* *)

implement s3typemap_find_d2cst (tmap, d2cst) =
s3typemap_find_stamp (tmap, d2cst_get_stamp (d2cst))

implement s3typemap_find_d2var (tmap, d2var) =
s3typemap_find_stamp (tmap, d2var_get_stamp (d2var))

implement
s3typemap_update_d2cst
  (tmap, d2cst, s3type) = 
  s3typemap_update_stamp (
    tmap, d2cst_get_stamp (d2cst), s3type)

implement
s3typemap_update_d2var
  (tmap, d2var, s3type) = let
  val tyopt = s3typemap_find_d2var (tmap, d2var)
in
  case+ tyopt of
  | Some0 ty => let
    val tcres = s3type_match (tmap, ty, s3type)
  in () end
  | None0 () => s3typemap_update_stamp (
    tmap, d2var_get_stamp (d2var), s3type)
end

(* ****** ****** *)



