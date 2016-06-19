(* ****** ****** *)

(*
** Author: Zhiqiang Ren
*)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "./../utils/emiter.sats"


(* ****** ****** *)
//
typedef
fprint_type
  (a:t@ype) = (FILEref, a) -> void
//
(* ****** ****** *)

(* ********** Common Elements ********** *)

abst0ype
stamp_t0ype = int
typedef stamp = stamp_t0ype

(* ****** ****** *)

fun
fprint_stamp: fprint_type (stamp)
overload fprint with fprint_stamp

(* ****** ****** *)

fun
emit_stamp: emit_type (stamp)

(* ****** ****** *)

fun stamp_make (int): stamp

(* ****** ****** *)

fun stamp_get_value (stamp): int

(* ****** ****** *)

//
fun
compare_stamp_stamp
  : (stamp, stamp) -<fun0> int
overload compare with compare_stamp_stamp

fun
eq_stamp_stamp : (stamp, stamp) -<fun0> bool
fun
neq_stamp_stamp : (stamp, stamp) -<fun0> bool
fun
compare_stamp_stamp : (stamp, stamp) -<fun0> int
//
overload = with eq_stamp_stamp
overload != with neq_stamp_stamp
//
(* ****** ****** *)
//
fun
hash_stamp (s: stamp):<> ulint

(* ****** ****** *)
fun
tostring_stamp (s: stamp):<> string

symintr .stamp

//
(* ****** ****** *)

abstype symbol_type = ptr
typedef symbol = symbol_type

(* ****** ****** *)

// postiats/postiats_symbol.dats
fun the_symbol_mgr_initialize (): void

fun
fprint_symbol: fprint_type(symbol)
overload fprint with fprint_symbol

(* ****** ****** *)

fun symbol_make (string): symbol

(* ****** ****** *)

fun
eq_symbol_symbol : (symbol, symbol) -<fun0> bool

fun
hash_symbol (s: symbol):<> ulint

(* ****** ****** *)

fun tostring_symbol (symbol): string
overload .tostring with tostring_symbol

(* ****** ****** *)
// The symbols to be compared needs to be created 
// by the same symbol manager.
fun
compare_symbol_symbol
  (x1: symbol, x2: symbol):<> int
//
overload compare with compare_symbol_symbol
//

symintr .name

(* ****** ****** *)
//
datatype label =
  | LABint of int | LABsym of symbol
//
(* ****** ****** *)

fun
fprint_label: fprint_type (label)
overload fprint with fprint_label

fun
emit_label: emit_type (label)

fun tostring_label (label): string
overload .tostring with tostring_label

(* ****** ****** *)
//
fun eq_label_label : (label, label) -<fun0> bool
fun neq_label_label : (label, label) -<fun0> bool
fun compare_label_label : (label, label) -<fun0> int
//
overload = with eq_label_label
overload != with neq_label_label
overload compare with compare_label_label
//
(* ****** ****** *)

abstype location_type = ptr
typedef loc_t = location_type

(* ****** ****** *)

fun
fprint_location: fprint_type (loc_t)
overload fprint with fprint_location

(* ****** ****** *)

fun location_make (rep: string): loc_t

fun location_tostring (loc: loc_t): string
overload .tostring with location_tostring

(* ********** end of Common Elements ********** *)

(* ********** Statics Related Elements ********** *)

#define SORT_TYPE      "type"
#define SORT_T0YPE     "t0ype"
#define SORT_T_AT_YPE     "t@ype"
#define SORT_VIEWTYPE  "viewtype"
#define SORT_VIEWT0YPE "viewt0ype"
#define SORT_VIEWT_AT_YPE "viewt@ype"
#define SORT_PROP      "prop"
#define SORT_VIEW      "view"


datatype s2rt =
| S2RTbas of symbol
| S2RTfun of (s2rtlst, s2rt)
| S2RTtup of (s2rtlst)
where
s2rtlst = list0 s2rt

fun s2rt_is_type (s2rt): bool

fun myfprint_s2rt: fprint_type (s2rt)

fun{} datcon_s2rt (s2rt): string
fun{} fprint_s2rt: fprint_type (s2rt)

(* ****** ****** *)

abstype s2cst_type = ptr
typedef s2cst = s2cst_type
typedef s2cstlst = list0 (s2cst)
typedef s2cstopt = option0 (s2cst)
vtypedef s2cstopt_vt = Option_vt (s2cst)

typedef dconlst = list0 stamp

(* ****** ****** *)

fun
fprint_s2cst: fprint_type (s2cst)
overload fprint with fprint_s2cst

(* ****** ****** *)

fun s2cst_make (name: symbol
  , stamp: stamp
  , s2rt: s2rt
  , dconlst: dconlst): s2cst

(* ****** ****** *)
//
fun s2cst_get_name (s2cst):<> symbol
fun s2cst_get_stamp (s2cst):<> stamp
fun s2cst_get_sort (s2cst):<> s2rt
fun s2cst_get_dconlst (s2cst):<> dconlst
//
(* ****** ****** *)
//
fun eq_s2cst_s2cst : (s2cst, s2cst) -<> bool
fun neq_s2cst_s2cst : (s2cst, s2cst) -<> bool
fun compare_s2cst_s2cst : (s2cst, s2cst) -<> int
//
overload = with eq_s2cst_s2cst
overload != with neq_s2cst_s2cst
overload compare with compare_s2cst_s2cst

//
(* ****** ****** *)
//

abstype s2var_type = ptr
typedef s2var = s2var_type
typedef s2varlst = list0 (s2var)
typedef s2varopt = option0 (s2var)
vtypedef s2varopt_vt = Option_vt (s2var)

fun fprint_s2varlst: fprint_type (s2varlst)

(* ****** ****** *)

fun
fprint_s2var: fprint_type (s2var)
overload fprint with fprint_s2var

(* ****** ****** *)

fun s2var_make (symbol, stamp, s2rt): s2var

(* ****** ****** *)
//
fun s2var_get_name (s2var):<> symbol
fun s2var_get_stamp (s2var):<> stamp
fun s2var_get_sort (s2var):<> s2rt
//
(* ****** ****** *)
//
fun eq_s2var_s2var : (s2var, s2var) -<> bool
fun neq_s2var_s2var : (s2var, s2var) -<> bool
fun compare_s2var_s2var : (s2var, s2var) -<> int
//
overload = with eq_s2var_s2var
overload != with eq_s2var_s2var
overload compare with compare_s2var_s2var
//
overload .name with s2cst_get_name
overload .name with s2var_get_name
//
//
overload .stamp with s2cst_get_stamp
overload .stamp with s2var_get_stamp

fun tostring_s2cst (s2cst): string
overload .tostring with tostring_s2cst

(* *************** *************** *)

datatype s2exp_node =
| S2Ecst of s2cst
| S2Evar of s2var
| S2Eextkind of symbol
| S2Eapp of (s2exp, s2explst)
| S2Eeqeq of (s2exp, s2exp)
| S2Eexi of (s2varlst, s2explst (*predicates*), s2exp (*body*))
| S2Euni of (s2varlst, s2explst (*predicates*), s2exp (*body*))
| S2Efun of (int (*npf*), s2explst (*args*), s2exp (*res*))
| S2Eint of int
(* The literal "4" in the following example is of S2Eintinf.
 * prfun qq2 {x:int} .<>.(x: propy (4)): int = 3
 *)
| S2Eintinf of string
| S2Einvar of s2exp
| S2Esizeof of s2exp
| S2Etyrec of (int (*knd: 0:flat, 1: boxed*), int (*npf*), labs2explst)
(* This is for the return type of a function whose parameters use
* reference type.
*)
| S2Ewthtype of (s2exp (*, todo: WTHS2EXPLST*)) // e.g. x: char? >> char 
| S2Etop of (s2exp)  // used for uninitialized type, e.g. char?
| S2Erefarg of (s2exp)
| S2Eignored
| S2Eerr

where
s2exp = '{
  s2exp_sort = s2rt, s2exp_node = s2exp_node
} (* end of [s2exp] *)

and labs2exp = '{
labs2exp_label = label
, labs2exp_nameopt = option0 string
, labs2exp_s2exp = s2exp
}
and labs2explst = list0 labs2exp

and s2explst = list0 (s2exp)
and s2expopt = option0 (s2exp)
and s2expopt_vt = Option_vt (s2exp)

fun s2exp_make_node
  (srt: s2rt, node: s2exp_node): s2exp

fun fprint_s2exp: fprint_type (s2exp)
overload fprint with fprint_s2exp

fun fprint_s2explst: fprint_type (s2explst)
overload fprint with fprint_s2explst

fun myfprint_s2exp_node: fprint_type (s2exp_node)
fun{} fprint_s2exp_node: fprint_type (s2exp_node)

fun fprint_labs2exp: fprint_type (labs2exp)

(* ********** end Statics Related Elements ********** *)


(* ********** Dynamics Related Elements ********** *)

datatype
funkind =
//
  | FK_fn // nonrec fun
  | FK_fnx // tailrec fun
  | FK_fun // recursive fun
//
  | FK_ignored // error-handling
// end of [funkind]

fun{} datcon_funkind : (funkind) -> string
fun fprint_funkind: fprint_type (funkind)

(* ****** ****** *)

datatype
valkind =
//
  | VK_val // val
  | VK_val_pos // val+
  | VK_val_neg // val-
//
  | VK_ignored // error-handling
// end of [valkind]

fun{} datcon_valkind : (valkind) -> string
fun fprint_valkind: fprint_type (valkind)

(* ****** ****** *)
datatype
casekind =
| CK_case_pos 
| CK_case_minus 
| CK_case_none

fun{} datcon_casekind : (casekind) -> string
fun fprint_casekind: fprint_type (casekind)

(* ****** ****** *)

abstype d2cst_type = ptr
typedef d2cst = d2cst_type
typedef d2cstlst = List0 (d2cst)
typedef d2cstopt = Option (d2cst)
vtypedef d2cstopt_vt = Option_vt (d2cst)

(* ****** ****** *)

fun
fprint_d2cst: fprint_type (d2cst)
overload fprint with fprint_d2cst

fun
emit_d2cst: emit_type (d2cst)

(* ****** ****** *)

fun d2cst_make (symbol, stamp, s2exp, Option string): d2cst

(* ****** ****** *)
//
fun d2cst_get_name (d2cst):<> symbol
fun d2cst_get_stamp (d2cst):<> stamp
fun d2cst_get_type (d2cst):<> s2exp
fun d2cst_get_extdef_opt (d2cst):<> Option string
//
(* ****** ****** *)
//
fun eq_d2cst_d2cst : (d2cst, d2cst) -<> bool
fun neq_d2cst_d2cst : (d2cst, d2cst) -<> bool
fun compare_d2cst_d2cst : (d2cst, d2cst) -<> int
//
overload = with eq_d2cst_d2cst
overload != with eq_d2cst_d2cst
overload compare with compare_d2cst_d2cst
//
(* ****** ****** *)

abstype d2var_type = ptr
typedef d2var = d2var_type
typedef d2varlst = List0 (d2var)
typedef d2varopt = Option (d2var)
vtypedef d2varopt_vt = Option_vt (d2var)

(* ****** ****** *)

fun
fprint_d2var: fprint_type (d2var)
overload fprint with fprint_d2var

fun
emit_d2var: emit_type (d2var)

(* ****** ****** *)

fun d2var_make (symbol, stamp): d2var

(* ****** ****** *)
//
fun d2var_get_name (d2var):<> symbol
fun d2var_get_stamp (d2var):<> stamp
//
(* ****** ****** *)
//
fun eq_d2var_d2var : (d2var, d2var) -<> bool
fun neq_d2var_d2var : (d2var, d2var) -<> bool
fun compare_d2var_d2var : (d2var, d2var) -<> int
//
overload = with eq_d2var_d2var
overload != with eq_d2var_d2var
overload compare with compare_d2var_d2var
//
(* ****** ****** *)

abstype d2sym_type = ptr
typedef d2sym = d2sym_type

(* ****** ****** *)

fun
fprint_d2sym: fprint_type (d2sym)
overload fprint with fprint_d2sym

fun
emit_d2sym: emit_type (d2sym)

(* ****** ****** *)

fun d2sym_make (sym: symbol): d2sym

(* ****** ****** *)

fun d2sym_get_name (d2sym):<> symbol

(* ****** ****** *)
abstype d2con_type = ptr
typedef d2con = d2con_type
typedef d2conlst = List0 (d2con)
typedef d2conopt = Option (d2con)
vtypedef d2conopt_vt = Option_vt (d2con)

(* ****** ****** *)

fun
fprint_d2con: fprint_type (d2con)
overload fprint with fprint_d2con

(* ****** ****** *)

fun d2con_make (symbol, s2exp, stamp): d2con

(* ****** ****** *)
//
fun d2con_get_name (d2con):<> symbol
fun d2con_get_type (d2con):<> s2exp
fun d2con_get_stamp (d2con):<> stamp
//
(* ****** ****** *)
//
fun eq_d2con_d2con : (d2con, d2con) -<> bool
fun neq_d2con_d2con : (d2con, d2con) -<> bool
fun compare_d2con_d2con : (d2con, d2con) -<> int
//
overload = with eq_d2con_d2con
overload != with eq_d2con_d2con
overload compare with compare_d2con_d2con
//
(* ****** ****** *)

datatype
p2at_node =
//
  | P2Tany of ()
  | P2Tvar of (d2var)
//
  | P2Tempty of ()
//
  | P2Tann of (p2at, s2exp)
//
  | P2Trec of (int (*kind*), int (*npf*), labp2atlst)
  | P2Tcon of (d2con, int (*npf*), p2atlst)
  | P2Ti0nt of (string)
//
  | P2Tignored of ((*void*))
// end of [p2at_node]

and labp2at =
  | LABP2ATnorm of (label, p2at) | LABP2ATomit of ()
// end of [labp2at]

where
p2at = '{
  p2at_loc= loc_t, p2at_node= p2at_node
} (* end of [p2at] *)

and
p2atlst = List0 (p2at)

and
labp2atlst = List0 (labp2at)


(* ****** ****** *)
fun{} datcon_p2at_node : (p2at_node) -> string
fun{} fprint_p2at_node: (FILEref, p2at_node) -> void
//
fun myfprint_p2at_node: fprint_type(p2at_node)
fun fprint_p2at: fprint_type (p2at)
fun fprint_p2atlst: fprint_type (p2atlst)
//
overload fprint with fprint_p2at
overload fprint with fprint_p2atlst of 10

fun
emit_p2at: emit_type (p2at)

fun
emit_p2atlst: emit_type (p2atlst)
//
fun fprint_labp2at: fprint_type (labp2at)
fun fprint_labp2atlst: fprint_type (labp2atlst)
//
overload fprint with fprint_labp2at
overload fprint with fprint_labp2atlst of 10

fun
emit_labp2at: emit_type (labp2at)

fun
emit_labp2atlst: emit_type (labp2atlst)

//
(* ****** ****** *)
//
fun p2at_make_node
  (loc: loc_t, node: p2at_node): p2at
//
(* ****** ****** *)

fun p2at_var (loc: loc_t, d2v: d2var): p2at

(* ****** ****** *)

fun p2at_rec (loc: loc_t, int (*kind*), int (*npf*), lp2ts: labp2atlst): p2at

(* ****** ****** *)

fun p2at_ignored (loc_t): p2at // error-handling

(* ****** ****** *)

datatype
d2ecl_node =
//
  | D2Cimpdec of (int(*knd*), i2mpdec)
//
  | D2Cfundecs of (funkind, f2undeclst)
  | D2Cvaldecs of (valkind, v2aldeclst)
  | D2Cvardecs of (v2ardeclst)
//
  | D2Cdcstdecs of (int, d2cst)
//
  | D2Clocal of (d2eclist(*head*), d2eclist(*body*))
  | D2Cextcode of (string (*code*))
//
  | D2Cignored of ((*void*)) // HX: error-handling
// end of [d2ecl_node]

and d2exp_node =
//
  | D2Ecst of (d2cst)
  | D2Evar of (d2var)
  | D2Esym of (d2sym)
//
  | D2Eint of (int)
  | D2Eintrep of (string)
  | D2Echar of (char)
  | D2Efloat of (double)
  | D2Estring of (string)
//
  | D2Ei0nt of (string)
  | D2Ec0har of (char)
  | D2Ef0loat of (string)
  | D2Es0tring of (string)
//
  | D2Eempty of ((*void*))
//
//  | D2Eexp of (d2exp) // dummy
  | D2Eann_type of (d2exp, s2exp)
  | D2Eann_seff of (d2exp)
  | D2Eann_funclo of (d2exp)
//
  | D2Elet of (d2eclist, d2exp)
//
  | D2Eapplst of (d2exp, d2exparglst)
//
  | D2Eifopt of (
      d2exp(*test*), d2exp(*then*), d2expopt(*else*)
    ) (* end of [D2Eifopt] *)

  | D2Ecase of (
      casekind
      , d2explst(*test*)
      , c2laulst
    ) (* end of [D2Ecase] *)
//
  | D2Esing of (d2exp)
  | D2Elist of (int (*npf*), d2explst)
//
  | D2Etup of (int (*kind*), int (*npf*), d2explst)
//
  | D2Eseq of (d2explst)
//
  | D2Eselab of (d2exp, d2lablst)
//
  | D2Elam_dyn of (int (*npf*), p2atlst, d2exp)
  | D2Elam_sta of (s2varlst (*static variables*)
                   , s2explst (*predicates in the statics*)
                   , d2exp)
  | D2Efix of (d2var, p2atlst, d2exp)
  | D2Eextfcall of (s2exp, string, d2explst)
  | D2Eassgn of (d2exp, d2exp)
//
  | D2Eignored of ((*void*)) // HX: error-handling
//
// end of [d2exp_node]

and d2exparg =
  | D2EXPARGsta of ()
  | D2EXPARGdyn of (int (*npf*), loc_t, d2explst)
// end of [d2exparg]

and d2lab =
  | D2LABlab of (label) | D2LABind of (d2explst)
// end of [d2lab]

where
d2ecl = '{
  d2ecl_loc= loc_t, d2ecl_node= d2ecl_node
} (* end of [d2ecl] *)

and d2eclist = List0 (d2ecl)

and
d2exp = '{
  d2exp_loc= loc_t, d2exp_node= d2exp_node
} (* end of [d2exp] *)

and d2explst = List0 (d2exp)
and d2expopt = Option (d2exp)

and d2exparglst = List0 (d2exparg)

and d2lablst = List0 (d2lab)

and i2mpdec = '{
  i2mpdec_loc= loc_t
, i2mpdec_locid= loc_t
, i2mpdec_cst= d2cst
, i2mpdec_def= d2exp
} (* end of [i2mpdec] *)

and f2undec = '{
  f2undec_loc= loc_t
, f2undec_var= d2var
, f2undec_def= d2exp
} (* end of [f2undec] *)

and f2undeclst = List0 (f2undec)

and v2aldec = '{
  v2aldec_loc= loc_t
, v2aldec_pat= p2at
, v2aldec_def= d2exp
} (* end of [v2aldec] *)

and v2ardec = '{
  v2ardec_loc= loc_t
, v2ardec_name= d2var
, v2ardec_init= d2expopt
, v2ardec_type= s2expopt
} (* end of [v2ardec] *)

and v2aldeclst = List0 (v2aldec)
and v2ardeclst = List0 (v2ardec)

and c2lau = '{
  c2lau_loc = loc_t
  , c2lau_patlst = p2atlst
  , c2lau_body = d2exp
} (* end of [c2lau] *)

and c2laulst = List0 (c2lau)

(* ****** ****** *)

fun fprint_c2laulst (FILEref, c2laulst): void

fun fprint_c2lau (FILEref, c2lau): void

(* ****** ****** *)
//

(* For code generation *)
fun{} datcon_d2exp_node : (d2exp_node) -> string
fun{} fprint_d2exp_node: (FILEref, d2exp_node) -> void
//
fun myfprint_d2exp_node: fprint_type(d2exp_node)

fun fprint_d2exp: fprint_type (d2exp)
fun fprint_d2explst: fprint_type (d2explst)
fun fprint_d2expopt: fprint_type (d2expopt)
//
overload fprint with fprint_d2exp
overload fprint with fprint_d2explst of 10
overload fprint with fprint_d2expopt of 10

//
fun emit_d2exp: emit_type (d2exp)
fun emit_d2explst: emit_type (d2explst)
//
(* ****** ****** *)
//
fun fprint_d2exparg: fprint_type (d2exparg)
fun fprint_d2exparglst: fprint_type (d2exparglst)
//
overload fprint with fprint_d2exparg
overload fprint with fprint_d2exparglst of 10

fun
emit_d2exparg: emit_type (d2exparg)

fun
emit_d2exparglst: emit_type (d2exparglst)
//
(* ****** ****** *)
//
fun fprint_d2lab: fprint_type (d2lab)
fun fprint_d2lablst: fprint_type (d2lablst)
//
overload fprint with fprint_d2lab
overload fprint with fprint_d2lablst of 10

fun
emit_d2lab: emit_type (d2lab)

fun
emit_d2lablst: emit_type (d2lablst)
//
(* ****** ****** *)
(* For code generation *)
fun{} datcon_d2ecl_node : (d2ecl_node) -> string
fun{} fprint_d2ecl_node: fprint_type (d2ecl_node)
//
fun myfprint_d2ecl_node: fprint_type (d2ecl_node)

fun fprint_d2ecl: fprint_type (d2ecl)
fun fprint_d2eclist: fprint_type (d2eclist)
//
overload fprint with fprint_d2ecl
overload fprint with fprint_d2eclist of 10

fun 
emit_d2ecl: emit_type (d2ecl)

fun 
emit_d2eclist: emit_type (d2eclist)
//
(* ****** ****** *)
//
fun d2var_get_bind (d2var):<> Ptr0
fun d2var_set_bind (d2var, d2exp): void
//
(* ****** ****** *)

fun d2exp_make_node
  (loc: loc_t, node: d2exp_node): d2exp

(* ****** ****** *)

// Expose the body of the lambda expression.
fun d2exp_expose_lam_dyn (d2exp): d2exp

(* ****** ****** *)

fun d2exp_cst (loc: loc_t, d2c: d2cst): d2exp
fun d2exp_var (loc: loc_t, d2v: d2var): d2exp
fun d2exp_sym (loc: loc_t, d2s: d2sym): d2exp

(* ****** ****** *)

fun d2exp_int (loc: loc_t, i: int): d2exp
fun d2exp_intrep (loc: loc_t, rep: string): d2exp
fun d2exp_float (loc: loc_t, f: double): d2exp
fun d2exp_string (loc: loc_t, str: string): d2exp

(* ****** ****** *)

fun d2exp_i0nt (loc: loc_t, rep: string): d2exp
fun d2exp_c0har (loc: loc_t, char: char): d2exp
fun d2exp_f0loat (loc: loc_t, rep: string): d2exp
fun d2exp_s0tring (loc: loc_t, rep: string): d2exp

(* ****** ****** *)

fun d2exp_empty (loc: loc_t): d2exp

(* ****** ****** *)

// fun d2exp_exp (loc: loc_t, d2e: d2exp): d2exp

(* ****** ****** *)

fun d2exp_let
  (loc: loc_t, d2cs: d2eclist, d2e: d2exp): d2exp
// end of [d2exp_let]

(* ****** ****** *)

fun d2exp_applst
  (loc: loc_t, d2e: d2exp, d2as: d2exparglst): d2exp
// end of [d2exp_applst]

(* ****** ****** *)

fun d2exp_ifopt
(
  loc: loc_t
, d2exp(*test*), d2exp(*then*), d2expopt(*else*)
) : d2exp // end of [d2exp_ifopt]

(* ****** ****** *)

fun d2exp_sing (loc: loc_t, d2e: d2exp): d2exp
fun d2exp_list (loc: loc_t, npf: int, d2es: d2explst): d2exp

(* ****** ****** *)

fun d2exp_tup (loc: loc_t, kind: int, npf: int, d2es: d2explst): d2exp

(* ****** ****** *)

fun d2exp_seq (loc: loc_t, d2es: d2explst): d2exp

(* ****** ****** *)

fun d2exp_selab
  (loc: loc_t, d2e: d2exp, d2ls: d2lablst): d2exp

(* ****** ****** *)

fun d2exp_lam_dyn
  (loc: loc_t, npf: int, p2ts: p2atlst, d2e: d2exp): d2exp
// end of [d2exp_lam_dyn]

(* ****** ****** *)

fun d2exp_fix
(
  loc: loc_t, d2v: d2var, p2ts: p2atlst, d2e: d2exp
) : d2exp // end of [d2exp_fix]

(* ****** ****** *)

fun d2exp_ignored (loc_t): d2exp // error-handling

(* ****** ****** *)

fun
i2mpdec_make
(
  loc: loc_t, locid: loc_t, d2cst, def: d2exp
) : i2mpdec // end of [i2mpdec_make]

(* ****** ****** *)

fun f2undec_make (loc_t, d2var, def: d2exp): f2undec

(* ****** ****** *)

fun v2aldec_make (loc_t, p2t0: p2at, def: d2exp): v2aldec

(* ****** ****** *)

fun v2ardec_make (loc_t, name: d2var, init: d2expopt, s2type: s2expopt): v2ardec

(* ****** ****** *)
//
fun d2ecl_make_node
  (loc: loc_t, node: d2ecl_node): d2ecl
//
(* ****** ****** *)

fun d2ecl_fundeclst
  (loc: loc_t, knd: funkind, f2ds: f2undeclst): d2ecl
fun d2ecl_valdeclst
  (loc: loc_t, knd: valkind, v2ds: v2aldeclst): d2ecl

(* ****** ****** *)

fun d2ecl_local
  (loc: loc_t, head: d2eclist, body: d2eclist): d2ecl

(* ****** ****** *)

fun d2ecl_ignored (loc_t): d2ecl // error-handling

(* ****** ****** *)
//
//
overload .name with d2cst_get_name
overload .name with d2var_get_name
overload .name with d2sym_get_name
overload .name with d2con_get_name
//
//
overload .stamp with d2cst_get_stamp
overload .stamp with d2var_get_stamp
overload .stamp with d2con_get_stamp
//
symintr .type
overload .type with d2cst_get_type
overload .type with d2con_get_type

(* ********** end of Dynamics Related Elements ********** *)

(* ****** ****** *)

(* end of [postiats.sats] *)



