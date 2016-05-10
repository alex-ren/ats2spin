(* ****** ******* *)
// Zhiqiang Ren
// aren@bu.edu
(* ****** ******* *)

staload "libats/ML/SATS/basis.sats"


(* ****** ****** *)

datatype 
emit_unit =
| EUindent of ()
| EUunindent of ()
| EUlwrapper of ()
| EUrwrapper of ()
| EUnewline of ()
| EUstring of string
| EUint of int
| EUbool of bool
| EUchar of char
| EUlist of eulst
where
eu = emit_unit
and
eulst = list0 (emit_unit)

(* ****** ****** *)

typedef
emit_type
  (a:t@ype) = (a) -> eu

typedef
emit_type_list
  (a:t@ype) = (a) -> eulst

(* ****** ****** *)
//



fun emit_text : emit_type (string)
fun emit_int : emit_type (int)
fun emit_bool : emit_type (bool)
fun emit_char : emit_type (char)
fun emit_newline (): eu
fun emit_indent (): eu
fun emit_unindent (): eu
fun emit_lwrapper (): eu
fun emit_rwrapper (): eu

overload emit with emit_text
overload emit with emit_int
overload emit with emit_bool
overload emit with emit_char

fun {a:t@ype} emit_list0 (xs: list0 a, sep: emit_unit): eulst
overload emit with emit_list0

//
(*
* Desc: Add left, right wrapper and seperator into
* the list.
*)
fun emit_unit_list_process (
  eus: eulst
  , sep: string
  , lwrapper: string
  , rwrapper: string): eulst

fun emit_list {a:type} (
  xs: list0 a
  , sep: eu
  , lwrapper: eu
  , rwrapper: eu
  , fopr: a -<cloref1> eu): eulst
  

fun fprint_emit_unit (out: FILEref, eu: eu): void
fun fprint_emit_unit_list (out: FILEref, eus: eulst): void

fun {a:t@ype} emit_val (x: a): eu




