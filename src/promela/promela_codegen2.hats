(* ****** ****** *)
//
extern
fun{}
fprint_pml_type$PMLTYPE_bit: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_bool: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_byte: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_pid: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_short: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_int: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_mtype: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_chan: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_uname: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_todo: $d2ctype(fprint_pml_type<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_type
  (out, arg0) =
(
case+ arg0 of
| PMLTYPE_bit _ => fprint_pml_type$PMLTYPE_bit<>(out, arg0)
| PMLTYPE_bool _ => fprint_pml_type$PMLTYPE_bool<>(out, arg0)
| PMLTYPE_byte _ => fprint_pml_type$PMLTYPE_byte<>(out, arg0)
| PMLTYPE_pid _ => fprint_pml_type$PMLTYPE_pid<>(out, arg0)
| PMLTYPE_short _ => fprint_pml_type$PMLTYPE_short<>(out, arg0)
| PMLTYPE_int _ => fprint_pml_type$PMLTYPE_int<>(out, arg0)
| PMLTYPE_mtype _ => fprint_pml_type$PMLTYPE_mtype<>(out, arg0)
| PMLTYPE_chan _ => fprint_pml_type$PMLTYPE_chan<>(out, arg0)
| PMLTYPE_uname _ => fprint_pml_type$PMLTYPE_uname<>(out, arg0)
| PMLTYPE_todo _ => fprint_pml_type$PMLTYPE_todo<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_type$sep: (FILEref) -> void
implement{}
fprint_pml_type$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_type$lpar: (FILEref) -> void
implement{}
fprint_pml_type$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_type$rpar: (FILEref) -> void
implement{}
fprint_pml_type$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_type$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_type$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_type$PMLTYPE_bit$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_bit$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_bit$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_bit(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_bit$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_bit$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_bit$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_bit$con(out, _) = fprint(out, "PMLTYPE_bit")
implement{}
fprint_pml_type$PMLTYPE_bit$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_bit$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_bool$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_bool$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_bool$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_bool(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_bool$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_bool$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_bool$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_bool$con(out, _) = fprint(out, "PMLTYPE_bool")
implement{}
fprint_pml_type$PMLTYPE_bool$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_bool$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_byte$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_byte$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_byte$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_byte(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_byte$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_byte$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_byte$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_byte$con(out, _) = fprint(out, "PMLTYPE_byte")
implement{}
fprint_pml_type$PMLTYPE_byte$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_byte$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_pid$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_pid$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_pid$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_pid(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_pid$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_pid$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_pid$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_pid$con(out, _) = fprint(out, "PMLTYPE_pid")
implement{}
fprint_pml_type$PMLTYPE_pid$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_pid$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_short$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_short$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_short$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_short(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_short$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_short$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_short$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_short$con(out, _) = fprint(out, "PMLTYPE_short")
implement{}
fprint_pml_type$PMLTYPE_short$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_short$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_int$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_int$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_int$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_int(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_int$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_int$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_int$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_int$con(out, _) = fprint(out, "PMLTYPE_int")
implement{}
fprint_pml_type$PMLTYPE_int$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_int$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_mtype$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_mtype$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_mtype$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_mtype(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_mtype$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_mtype$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_mtype$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_mtype$con(out, _) = fprint(out, "PMLTYPE_mtype")
implement{}
fprint_pml_type$PMLTYPE_mtype$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_mtype$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_chan$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_chan$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_chan$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_chan(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_chan$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_chan$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_chan$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_chan$con(out, _) = fprint(out, "PMLTYPE_chan")
implement{}
fprint_pml_type$PMLTYPE_chan$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_chan$rpar(out, _) = fprint_pml_type$rpar(out)
//
extern
fun{}
fprint_pml_type$PMLTYPE_uname$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_uname$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_uname$rpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_uname$arg1: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_uname(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_uname$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_uname$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_uname$arg1<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_uname$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_uname$con(out, _) = fprint(out, "PMLTYPE_uname")
implement{}
fprint_pml_type$PMLTYPE_uname$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_uname$rpar(out, _) = fprint_pml_type$rpar(out)
implement{}
fprint_pml_type$PMLTYPE_uname$arg1(out, arg0) =
  let val-PMLTYPE_uname(arg1) = arg0 in fprint_pml_type$carg(out, arg1) end
//
extern
fun{}
fprint_pml_type$PMLTYPE_todo$con: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_todo$lpar: $d2ctype(fprint_pml_type<>)
extern
fun{}
fprint_pml_type$PMLTYPE_todo$rpar: $d2ctype(fprint_pml_type<>)
//
implement{}
fprint_pml_type$PMLTYPE_todo(out, arg0) = 
{
//
val () = fprint_pml_type$PMLTYPE_todo$con<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_todo$lpar<>(out, arg0)
val () = fprint_pml_type$PMLTYPE_todo$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_type$PMLTYPE_todo$con(out, _) = fprint(out, "PMLTYPE_todo")
implement{}
fprint_pml_type$PMLTYPE_todo$lpar(out, _) = fprint_pml_type$lpar(out)
implement{}
fprint_pml_type$PMLTYPE_todo$rpar(out, _) = fprint_pml_type$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_atom$PMLATOM_INT: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_BOOL: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_CHAR: $d2ctype(fprint_pml_atom<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_atom
  (out, arg0) =
(
case+ arg0 of
| PMLATOM_INT _ => fprint_pml_atom$PMLATOM_INT<>(out, arg0)
| PMLATOM_BOOL _ => fprint_pml_atom$PMLATOM_BOOL<>(out, arg0)
| PMLATOM_CHAR _ => fprint_pml_atom$PMLATOM_CHAR<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_atom$sep: (FILEref) -> void
implement{}
fprint_pml_atom$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_atom$lpar: (FILEref) -> void
implement{}
fprint_pml_atom$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_atom$rpar: (FILEref) -> void
implement{}
fprint_pml_atom$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_atom$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_atom$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_atom$PMLATOM_INT$con: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_INT$lpar: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_INT$rpar: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_INT$arg1: $d2ctype(fprint_pml_atom<>)
//
implement{}
fprint_pml_atom$PMLATOM_INT(out, arg0) = 
{
//
val () = fprint_pml_atom$PMLATOM_INT$con<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_INT$lpar<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_INT$arg1<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_INT$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_atom$PMLATOM_INT$con(out, _) = fprint(out, "PMLATOM_INT")
implement{}
fprint_pml_atom$PMLATOM_INT$lpar(out, _) = fprint_pml_atom$lpar(out)
implement{}
fprint_pml_atom$PMLATOM_INT$rpar(out, _) = fprint_pml_atom$rpar(out)
implement{}
fprint_pml_atom$PMLATOM_INT$arg1(out, arg0) =
  let val-PMLATOM_INT(arg1) = arg0 in fprint_pml_atom$carg(out, arg1) end
//
extern
fun{}
fprint_pml_atom$PMLATOM_BOOL$con: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_BOOL$lpar: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_BOOL$rpar: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_BOOL$arg1: $d2ctype(fprint_pml_atom<>)
//
implement{}
fprint_pml_atom$PMLATOM_BOOL(out, arg0) = 
{
//
val () = fprint_pml_atom$PMLATOM_BOOL$con<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_BOOL$lpar<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_BOOL$arg1<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_BOOL$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_atom$PMLATOM_BOOL$con(out, _) = fprint(out, "PMLATOM_BOOL")
implement{}
fprint_pml_atom$PMLATOM_BOOL$lpar(out, _) = fprint_pml_atom$lpar(out)
implement{}
fprint_pml_atom$PMLATOM_BOOL$rpar(out, _) = fprint_pml_atom$rpar(out)
implement{}
fprint_pml_atom$PMLATOM_BOOL$arg1(out, arg0) =
  let val-PMLATOM_BOOL(arg1) = arg0 in fprint_pml_atom$carg(out, arg1) end
//
extern
fun{}
fprint_pml_atom$PMLATOM_CHAR$con: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_CHAR$lpar: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_CHAR$rpar: $d2ctype(fprint_pml_atom<>)
extern
fun{}
fprint_pml_atom$PMLATOM_CHAR$arg1: $d2ctype(fprint_pml_atom<>)
//
implement{}
fprint_pml_atom$PMLATOM_CHAR(out, arg0) = 
{
//
val () = fprint_pml_atom$PMLATOM_CHAR$con<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_CHAR$lpar<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_CHAR$arg1<>(out, arg0)
val () = fprint_pml_atom$PMLATOM_CHAR$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_atom$PMLATOM_CHAR$con(out, _) = fprint(out, "PMLATOM_CHAR")
implement{}
fprint_pml_atom$PMLATOM_CHAR$lpar(out, _) = fprint_pml_atom$lpar(out)
implement{}
fprint_pml_atom$PMLATOM_CHAR$rpar(out, _) = fprint_pml_atom$rpar(out)
implement{}
fprint_pml_atom$PMLATOM_CHAR$arg1(out, arg0) =
  let val-PMLATOM_CHAR(arg1) = arg0 in fprint_pml_atom$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_opr$PMLOPR_plus: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_minus: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_and: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_or: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_neg: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_ban: $d2ctype(fprint_pml_opr<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_opr
  (out, arg0) =
(
case+ arg0 of
| PMLOPR_plus _ => fprint_pml_opr$PMLOPR_plus<>(out, arg0)
| PMLOPR_minus _ => fprint_pml_opr$PMLOPR_minus<>(out, arg0)
| PMLOPR_and _ => fprint_pml_opr$PMLOPR_and<>(out, arg0)
| PMLOPR_or _ => fprint_pml_opr$PMLOPR_or<>(out, arg0)
| PMLOPR_neg _ => fprint_pml_opr$PMLOPR_neg<>(out, arg0)
| PMLOPR_ban _ => fprint_pml_opr$PMLOPR_ban<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_opr$sep: (FILEref) -> void
implement{}
fprint_pml_opr$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_opr$lpar: (FILEref) -> void
implement{}
fprint_pml_opr$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_opr$rpar: (FILEref) -> void
implement{}
fprint_pml_opr$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_opr$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_opr$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_opr$PMLOPR_plus$con: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_plus$lpar: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_plus$rpar: $d2ctype(fprint_pml_opr<>)
//
implement{}
fprint_pml_opr$PMLOPR_plus(out, arg0) = 
{
//
val () = fprint_pml_opr$PMLOPR_plus$con<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_plus$lpar<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_plus$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_opr$PMLOPR_plus$con(out, _) = fprint(out, "PMLOPR_plus")
implement{}
fprint_pml_opr$PMLOPR_plus$lpar(out, _) = fprint_pml_opr$lpar(out)
implement{}
fprint_pml_opr$PMLOPR_plus$rpar(out, _) = fprint_pml_opr$rpar(out)
//
extern
fun{}
fprint_pml_opr$PMLOPR_minus$con: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_minus$lpar: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_minus$rpar: $d2ctype(fprint_pml_opr<>)
//
implement{}
fprint_pml_opr$PMLOPR_minus(out, arg0) = 
{
//
val () = fprint_pml_opr$PMLOPR_minus$con<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_minus$lpar<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_minus$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_opr$PMLOPR_minus$con(out, _) = fprint(out, "PMLOPR_minus")
implement{}
fprint_pml_opr$PMLOPR_minus$lpar(out, _) = fprint_pml_opr$lpar(out)
implement{}
fprint_pml_opr$PMLOPR_minus$rpar(out, _) = fprint_pml_opr$rpar(out)
//
extern
fun{}
fprint_pml_opr$PMLOPR_and$con: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_and$lpar: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_and$rpar: $d2ctype(fprint_pml_opr<>)
//
implement{}
fprint_pml_opr$PMLOPR_and(out, arg0) = 
{
//
val () = fprint_pml_opr$PMLOPR_and$con<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_and$lpar<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_and$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_opr$PMLOPR_and$con(out, _) = fprint(out, "PMLOPR_and")
implement{}
fprint_pml_opr$PMLOPR_and$lpar(out, _) = fprint_pml_opr$lpar(out)
implement{}
fprint_pml_opr$PMLOPR_and$rpar(out, _) = fprint_pml_opr$rpar(out)
//
extern
fun{}
fprint_pml_opr$PMLOPR_or$con: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_or$lpar: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_or$rpar: $d2ctype(fprint_pml_opr<>)
//
implement{}
fprint_pml_opr$PMLOPR_or(out, arg0) = 
{
//
val () = fprint_pml_opr$PMLOPR_or$con<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_or$lpar<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_or$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_opr$PMLOPR_or$con(out, _) = fprint(out, "PMLOPR_or")
implement{}
fprint_pml_opr$PMLOPR_or$lpar(out, _) = fprint_pml_opr$lpar(out)
implement{}
fprint_pml_opr$PMLOPR_or$rpar(out, _) = fprint_pml_opr$rpar(out)
//
extern
fun{}
fprint_pml_opr$PMLOPR_neg$con: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_neg$lpar: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_neg$rpar: $d2ctype(fprint_pml_opr<>)
//
implement{}
fprint_pml_opr$PMLOPR_neg(out, arg0) = 
{
//
val () = fprint_pml_opr$PMLOPR_neg$con<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_neg$lpar<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_neg$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_opr$PMLOPR_neg$con(out, _) = fprint(out, "PMLOPR_neg")
implement{}
fprint_pml_opr$PMLOPR_neg$lpar(out, _) = fprint_pml_opr$lpar(out)
implement{}
fprint_pml_opr$PMLOPR_neg$rpar(out, _) = fprint_pml_opr$rpar(out)
//
extern
fun{}
fprint_pml_opr$PMLOPR_ban$con: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_ban$lpar: $d2ctype(fprint_pml_opr<>)
extern
fun{}
fprint_pml_opr$PMLOPR_ban$rpar: $d2ctype(fprint_pml_opr<>)
//
implement{}
fprint_pml_opr$PMLOPR_ban(out, arg0) = 
{
//
val () = fprint_pml_opr$PMLOPR_ban$con<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_ban$lpar<>(out, arg0)
val () = fprint_pml_opr$PMLOPR_ban$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_opr$PMLOPR_ban$con(out, _) = fprint(out, "PMLOPR_ban")
implement{}
fprint_pml_opr$PMLOPR_ban$lpar(out, _) = fprint_pml_opr$lpar(out)
implement{}
fprint_pml_opr$PMLOPR_ban$rpar(out, _) = fprint_pml_opr$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_varref: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_const: $d2ctype(fprint_pml_anyexp<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_anyexp
  (out, arg0) =
(
case+ arg0 of
| PMLANYEXP_binarop _ => fprint_pml_anyexp$PMLANYEXP_binarop<>(out, arg0)
| PMLANYEXP_unarop _ => fprint_pml_anyexp$PMLANYEXP_unarop<>(out, arg0)
| PMLANYEXP_select _ => fprint_pml_anyexp$PMLANYEXP_select<>(out, arg0)
| PMLANYEXP_varref _ => fprint_pml_anyexp$PMLANYEXP_varref<>(out, arg0)
| PMLANYEXP_const _ => fprint_pml_anyexp$PMLANYEXP_const<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_anyexp$sep: (FILEref) -> void
implement{}
fprint_pml_anyexp$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_anyexp$lpar: (FILEref) -> void
implement{}
fprint_pml_anyexp$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_anyexp$rpar: (FILEref) -> void
implement{}
fprint_pml_anyexp$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_anyexp$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_anyexp$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$con: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$lpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$rpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$sep1: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$sep2: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$arg1: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$arg2: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_binarop$arg3: $d2ctype(fprint_pml_anyexp<>)
//
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop(out, arg0) = 
{
//
val () = fprint_pml_anyexp$PMLANYEXP_binarop$con<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$lpar<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$arg1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$sep1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$arg2<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$sep2<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$arg3<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_binarop$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$con(out, _) = fprint(out, "PMLANYEXP_binarop")
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$lpar(out, _) = fprint_pml_anyexp$lpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$rpar(out, _) = fprint_pml_anyexp$rpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$sep1(out, _) = fprint_pml_anyexp$sep<>(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$sep2(out, _) = fprint_pml_anyexp$sep<>(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$arg1(out, arg0) =
  let val-PMLANYEXP_binarop(arg1, _, _) = arg0 in fprint_pml_anyexp$carg(out, arg1) end
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$arg2(out, arg0) =
  let val-PMLANYEXP_binarop(_, arg2, _) = arg0 in fprint_pml_anyexp$carg(out, arg2) end
implement{}
fprint_pml_anyexp$PMLANYEXP_binarop$arg3(out, arg0) =
  let val-PMLANYEXP_binarop(_, _, arg3) = arg0 in fprint_pml_anyexp$carg(out, arg3) end
//
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop$con: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop$lpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop$rpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop$sep1: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop$arg1: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_unarop$arg2: $d2ctype(fprint_pml_anyexp<>)
//
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop(out, arg0) = 
{
//
val () = fprint_pml_anyexp$PMLANYEXP_unarop$con<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_unarop$lpar<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_unarop$arg1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_unarop$sep1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_unarop$arg2<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_unarop$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop$con(out, _) = fprint(out, "PMLANYEXP_unarop")
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop$lpar(out, _) = fprint_pml_anyexp$lpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop$rpar(out, _) = fprint_pml_anyexp$rpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop$sep1(out, _) = fprint_pml_anyexp$sep<>(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop$arg1(out, arg0) =
  let val-PMLANYEXP_unarop(arg1, _) = arg0 in fprint_pml_anyexp$carg(out, arg1) end
implement{}
fprint_pml_anyexp$PMLANYEXP_unarop$arg2(out, arg0) =
  let val-PMLANYEXP_unarop(_, arg2) = arg0 in fprint_pml_anyexp$carg(out, arg2) end
//
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$con: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$lpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$rpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$sep1: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$sep2: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$arg1: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$arg2: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_select$arg3: $d2ctype(fprint_pml_anyexp<>)
//
implement{}
fprint_pml_anyexp$PMLANYEXP_select(out, arg0) = 
{
//
val () = fprint_pml_anyexp$PMLANYEXP_select$con<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$lpar<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$arg1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$sep1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$arg2<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$sep2<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$arg3<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_select$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_anyexp$PMLANYEXP_select$con(out, _) = fprint(out, "PMLANYEXP_select")
implement{}
fprint_pml_anyexp$PMLANYEXP_select$lpar(out, _) = fprint_pml_anyexp$lpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_select$rpar(out, _) = fprint_pml_anyexp$rpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_select$sep1(out, _) = fprint_pml_anyexp$sep<>(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_select$sep2(out, _) = fprint_pml_anyexp$sep<>(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_select$arg1(out, arg0) =
  let val-PMLANYEXP_select(arg1, _, _) = arg0 in fprint_pml_anyexp$carg(out, arg1) end
implement{}
fprint_pml_anyexp$PMLANYEXP_select$arg2(out, arg0) =
  let val-PMLANYEXP_select(_, arg2, _) = arg0 in fprint_pml_anyexp$carg(out, arg2) end
implement{}
fprint_pml_anyexp$PMLANYEXP_select$arg3(out, arg0) =
  let val-PMLANYEXP_select(_, _, arg3) = arg0 in fprint_pml_anyexp$carg(out, arg3) end
//
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_varref$con: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_varref$lpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_varref$rpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_varref$arg1: $d2ctype(fprint_pml_anyexp<>)
//
implement{}
fprint_pml_anyexp$PMLANYEXP_varref(out, arg0) = 
{
//
val () = fprint_pml_anyexp$PMLANYEXP_varref$con<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_varref$lpar<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_varref$arg1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_varref$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_anyexp$PMLANYEXP_varref$con(out, _) = fprint(out, "PMLANYEXP_varref")
implement{}
fprint_pml_anyexp$PMLANYEXP_varref$lpar(out, _) = fprint_pml_anyexp$lpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_varref$rpar(out, _) = fprint_pml_anyexp$rpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_varref$arg1(out, arg0) =
  let val-PMLANYEXP_varref(arg1) = arg0 in fprint_pml_anyexp$carg(out, arg1) end
//
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_const$con: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_const$lpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_const$rpar: $d2ctype(fprint_pml_anyexp<>)
extern
fun{}
fprint_pml_anyexp$PMLANYEXP_const$arg1: $d2ctype(fprint_pml_anyexp<>)
//
implement{}
fprint_pml_anyexp$PMLANYEXP_const(out, arg0) = 
{
//
val () = fprint_pml_anyexp$PMLANYEXP_const$con<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_const$lpar<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_const$arg1<>(out, arg0)
val () = fprint_pml_anyexp$PMLANYEXP_const$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_anyexp$PMLANYEXP_const$con(out, _) = fprint(out, "PMLANYEXP_const")
implement{}
fprint_pml_anyexp$PMLANYEXP_const$lpar(out, _) = fprint_pml_anyexp$lpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_const$rpar(out, _) = fprint_pml_anyexp$rpar(out)
implement{}
fprint_pml_anyexp$PMLANYEXP_const$arg1(out, arg0) =
  let val-PMLANYEXP_const(arg1) = arg0 in fprint_pml_anyexp$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_varref$PMLVARREF: $d2ctype(fprint_pml_varref<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_varref
  (out, arg0) =
(
case+ arg0 of
| PMLVARREF _ => fprint_pml_varref$PMLVARREF<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_varref$sep: (FILEref) -> void
implement{}
fprint_pml_varref$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_varref$lpar: (FILEref) -> void
implement{}
fprint_pml_varref$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_varref$rpar: (FILEref) -> void
implement{}
fprint_pml_varref$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_varref$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_varref$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_varref$PMLVARREF$con: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$lpar: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$rpar: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$sep1: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$sep2: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$arg1: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$arg2: $d2ctype(fprint_pml_varref<>)
extern
fun{}
fprint_pml_varref$PMLVARREF$arg3: $d2ctype(fprint_pml_varref<>)
//
implement{}
fprint_pml_varref$PMLVARREF(out, arg0) = 
{
//
val () = fprint_pml_varref$PMLVARREF$con<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$lpar<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$arg1<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$sep1<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$arg2<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$sep2<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$arg3<>(out, arg0)
val () = fprint_pml_varref$PMLVARREF$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_varref$PMLVARREF$con(out, _) = fprint(out, "PMLVARREF")
implement{}
fprint_pml_varref$PMLVARREF$lpar(out, _) = fprint_pml_varref$lpar(out)
implement{}
fprint_pml_varref$PMLVARREF$rpar(out, _) = fprint_pml_varref$rpar(out)
implement{}
fprint_pml_varref$PMLVARREF$sep1(out, _) = fprint_pml_varref$sep<>(out)
implement{}
fprint_pml_varref$PMLVARREF$sep2(out, _) = fprint_pml_varref$sep<>(out)
implement{}
fprint_pml_varref$PMLVARREF$arg1(out, arg0) =
  let val-PMLVARREF(arg1, _, _) = arg0 in fprint_pml_varref$carg(out, arg1) end
implement{}
fprint_pml_varref$PMLVARREF$arg2(out, arg0) =
  let val-PMLVARREF(_, arg2, _) = arg0 in fprint_pml_varref$carg(out, arg2) end
implement{}
fprint_pml_varref$PMLVARREF$arg3(out, arg0) =
  let val-PMLVARREF(_, _, arg3) = arg0 in fprint_pml_varref$carg(out, arg3) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_exp$PMLEXP_anyexp: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_chanop: $d2ctype(fprint_pml_exp<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_exp
  (out, arg0) =
(
case+ arg0 of
| PMLEXP_anyexp _ => fprint_pml_exp$PMLEXP_anyexp<>(out, arg0)
| PMLEXP_chanop _ => fprint_pml_exp$PMLEXP_chanop<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_exp$sep: (FILEref) -> void
implement{}
fprint_pml_exp$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_exp$lpar: (FILEref) -> void
implement{}
fprint_pml_exp$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_exp$rpar: (FILEref) -> void
implement{}
fprint_pml_exp$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_exp$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_exp$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_exp$PMLEXP_anyexp$con: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_anyexp$lpar: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_anyexp$rpar: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_anyexp$arg1: $d2ctype(fprint_pml_exp<>)
//
implement{}
fprint_pml_exp$PMLEXP_anyexp(out, arg0) = 
{
//
val () = fprint_pml_exp$PMLEXP_anyexp$con<>(out, arg0)
val () = fprint_pml_exp$PMLEXP_anyexp$lpar<>(out, arg0)
val () = fprint_pml_exp$PMLEXP_anyexp$arg1<>(out, arg0)
val () = fprint_pml_exp$PMLEXP_anyexp$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_exp$PMLEXP_anyexp$con(out, _) = fprint(out, "PMLEXP_anyexp")
implement{}
fprint_pml_exp$PMLEXP_anyexp$lpar(out, _) = fprint_pml_exp$lpar(out)
implement{}
fprint_pml_exp$PMLEXP_anyexp$rpar(out, _) = fprint_pml_exp$rpar(out)
implement{}
fprint_pml_exp$PMLEXP_anyexp$arg1(out, arg0) =
  let val-PMLEXP_anyexp(arg1) = arg0 in fprint_pml_exp$carg(out, arg1) end
//
extern
fun{}
fprint_pml_exp$PMLEXP_chanop$con: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_chanop$lpar: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_chanop$rpar: $d2ctype(fprint_pml_exp<>)
extern
fun{}
fprint_pml_exp$PMLEXP_chanop$arg1: $d2ctype(fprint_pml_exp<>)
//
implement{}
fprint_pml_exp$PMLEXP_chanop(out, arg0) = 
{
//
val () = fprint_pml_exp$PMLEXP_chanop$con<>(out, arg0)
val () = fprint_pml_exp$PMLEXP_chanop$lpar<>(out, arg0)
val () = fprint_pml_exp$PMLEXP_chanop$arg1<>(out, arg0)
val () = fprint_pml_exp$PMLEXP_chanop$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_exp$PMLEXP_chanop$con(out, _) = fprint(out, "PMLEXP_chanop")
implement{}
fprint_pml_exp$PMLEXP_chanop$lpar(out, _) = fprint_pml_exp$lpar(out)
implement{}
fprint_pml_exp$PMLEXP_chanop$rpar(out, _) = fprint_pml_exp$rpar(out)
implement{}
fprint_pml_exp$PMLEXP_chanop$arg1(out, arg0) =
  let val-PMLEXP_chanop(arg1) = arg0 in fprint_pml_exp$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_name: $d2ctype(fprint_pml_ivar<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_ivar
  (out, arg0) =
(
case+ arg0 of
| PMLIVAR_exp _ => fprint_pml_ivar$PMLIVAR_exp<>(out, arg0)
| PMLIVAR_chan _ => fprint_pml_ivar$PMLIVAR_chan<>(out, arg0)
| PMLIVAR_name _ => fprint_pml_ivar$PMLIVAR_name<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_ivar$sep: (FILEref) -> void
implement{}
fprint_pml_ivar$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_ivar$lpar: (FILEref) -> void
implement{}
fprint_pml_ivar$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_ivar$rpar: (FILEref) -> void
implement{}
fprint_pml_ivar$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_ivar$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_ivar$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$con: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$lpar: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$rpar: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$sep1: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$sep2: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$arg1: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$arg2: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_exp$arg3: $d2ctype(fprint_pml_ivar<>)
//
implement{}
fprint_pml_ivar$PMLIVAR_exp(out, arg0) = 
{
//
val () = fprint_pml_ivar$PMLIVAR_exp$con<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$lpar<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$arg1<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$sep1<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$arg2<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$sep2<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$arg3<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_exp$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_ivar$PMLIVAR_exp$con(out, _) = fprint(out, "PMLIVAR_exp")
implement{}
fprint_pml_ivar$PMLIVAR_exp$lpar(out, _) = fprint_pml_ivar$lpar(out)
implement{}
fprint_pml_ivar$PMLIVAR_exp$rpar(out, _) = fprint_pml_ivar$rpar(out)
implement{}
fprint_pml_ivar$PMLIVAR_exp$sep1(out, _) = fprint_pml_ivar$sep<>(out)
implement{}
fprint_pml_ivar$PMLIVAR_exp$sep2(out, _) = fprint_pml_ivar$sep<>(out)
implement{}
fprint_pml_ivar$PMLIVAR_exp$arg1(out, arg0) =
  let val-PMLIVAR_exp(arg1, _, _) = arg0 in fprint_pml_ivar$carg(out, arg1) end
implement{}
fprint_pml_ivar$PMLIVAR_exp$arg2(out, arg0) =
  let val-PMLIVAR_exp(_, arg2, _) = arg0 in fprint_pml_ivar$carg(out, arg2) end
implement{}
fprint_pml_ivar$PMLIVAR_exp$arg3(out, arg0) =
  let val-PMLIVAR_exp(_, _, arg3) = arg0 in fprint_pml_ivar$carg(out, arg3) end
//
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$con: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$lpar: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$rpar: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$sep1: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$sep2: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$arg1: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$arg2: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_chan$arg3: $d2ctype(fprint_pml_ivar<>)
//
implement{}
fprint_pml_ivar$PMLIVAR_chan(out, arg0) = 
{
//
val () = fprint_pml_ivar$PMLIVAR_chan$con<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$lpar<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$arg1<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$sep1<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$arg2<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$sep2<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$arg3<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_chan$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_ivar$PMLIVAR_chan$con(out, _) = fprint(out, "PMLIVAR_chan")
implement{}
fprint_pml_ivar$PMLIVAR_chan$lpar(out, _) = fprint_pml_ivar$lpar(out)
implement{}
fprint_pml_ivar$PMLIVAR_chan$rpar(out, _) = fprint_pml_ivar$rpar(out)
implement{}
fprint_pml_ivar$PMLIVAR_chan$sep1(out, _) = fprint_pml_ivar$sep<>(out)
implement{}
fprint_pml_ivar$PMLIVAR_chan$sep2(out, _) = fprint_pml_ivar$sep<>(out)
implement{}
fprint_pml_ivar$PMLIVAR_chan$arg1(out, arg0) =
  let val-PMLIVAR_chan(arg1, _, _) = arg0 in fprint_pml_ivar$carg(out, arg1) end
implement{}
fprint_pml_ivar$PMLIVAR_chan$arg2(out, arg0) =
  let val-PMLIVAR_chan(_, arg2, _) = arg0 in fprint_pml_ivar$carg(out, arg2) end
implement{}
fprint_pml_ivar$PMLIVAR_chan$arg3(out, arg0) =
  let val-PMLIVAR_chan(_, _, arg3) = arg0 in fprint_pml_ivar$carg(out, arg3) end
//
extern
fun{}
fprint_pml_ivar$PMLIVAR_name$con: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_name$lpar: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_name$rpar: $d2ctype(fprint_pml_ivar<>)
extern
fun{}
fprint_pml_ivar$PMLIVAR_name$arg1: $d2ctype(fprint_pml_ivar<>)
//
implement{}
fprint_pml_ivar$PMLIVAR_name(out, arg0) = 
{
//
val () = fprint_pml_ivar$PMLIVAR_name$con<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_name$lpar<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_name$arg1<>(out, arg0)
val () = fprint_pml_ivar$PMLIVAR_name$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_ivar$PMLIVAR_name$con(out, _) = fprint(out, "PMLIVAR_name")
implement{}
fprint_pml_ivar$PMLIVAR_name$lpar(out, _) = fprint_pml_ivar$lpar(out)
implement{}
fprint_pml_ivar$PMLIVAR_name$rpar(out, _) = fprint_pml_ivar$rpar(out)
implement{}
fprint_pml_ivar$PMLIVAR_name$arg1(out, arg0) =
  let val-PMLIVAR_name(arg1) = arg0 in fprint_pml_ivar$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_step$PMLSTEP_declst: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_stmnt: $d2ctype(fprint_pml_step<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_step
  (out, arg0) =
(
case+ arg0 of
| PMLSTEP_declst _ => fprint_pml_step$PMLSTEP_declst<>(out, arg0)
| PMLSTEP_stmnt _ => fprint_pml_step$PMLSTEP_stmnt<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_step$sep: (FILEref) -> void
implement{}
fprint_pml_step$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_step$lpar: (FILEref) -> void
implement{}
fprint_pml_step$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_step$rpar: (FILEref) -> void
implement{}
fprint_pml_step$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_step$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_step$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_step$PMLSTEP_declst$con: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_declst$lpar: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_declst$rpar: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_declst$arg1: $d2ctype(fprint_pml_step<>)
//
implement{}
fprint_pml_step$PMLSTEP_declst(out, arg0) = 
{
//
val () = fprint_pml_step$PMLSTEP_declst$con<>(out, arg0)
val () = fprint_pml_step$PMLSTEP_declst$lpar<>(out, arg0)
val () = fprint_pml_step$PMLSTEP_declst$arg1<>(out, arg0)
val () = fprint_pml_step$PMLSTEP_declst$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_step$PMLSTEP_declst$con(out, _) = fprint(out, "PMLSTEP_declst")
implement{}
fprint_pml_step$PMLSTEP_declst$lpar(out, _) = fprint_pml_step$lpar(out)
implement{}
fprint_pml_step$PMLSTEP_declst$rpar(out, _) = fprint_pml_step$rpar(out)
implement{}
fprint_pml_step$PMLSTEP_declst$arg1(out, arg0) =
  let val-PMLSTEP_declst(arg1) = arg0 in fprint_pml_step$carg(out, arg1) end
//
extern
fun{}
fprint_pml_step$PMLSTEP_stmnt$con: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_stmnt$lpar: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_stmnt$rpar: $d2ctype(fprint_pml_step<>)
extern
fun{}
fprint_pml_step$PMLSTEP_stmnt$arg1: $d2ctype(fprint_pml_step<>)
//
implement{}
fprint_pml_step$PMLSTEP_stmnt(out, arg0) = 
{
//
val () = fprint_pml_step$PMLSTEP_stmnt$con<>(out, arg0)
val () = fprint_pml_step$PMLSTEP_stmnt$lpar<>(out, arg0)
val () = fprint_pml_step$PMLSTEP_stmnt$arg1<>(out, arg0)
val () = fprint_pml_step$PMLSTEP_stmnt$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_step$PMLSTEP_stmnt$con(out, _) = fprint(out, "PMLSTEP_stmnt")
implement{}
fprint_pml_step$PMLSTEP_stmnt$lpar(out, _) = fprint_pml_step$lpar(out)
implement{}
fprint_pml_step$PMLSTEP_stmnt$rpar(out, _) = fprint_pml_step$rpar(out)
implement{}
fprint_pml_step$PMLSTEP_stmnt$arg1(out, arg0) =
  let val-PMLSTEP_stmnt(arg1) = arg0 in fprint_pml_step$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_if: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_do: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_atomic: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_dstep: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_block: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assign: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_else: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_break: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_goto: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assert: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_exp: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline: $d2ctype(fprint_pml_stmnt<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_stmnt
  (out, arg0) =
(
case+ arg0 of
| PMLSTMNT_if _ => fprint_pml_stmnt$PMLSTMNT_if<>(out, arg0)
| PMLSTMNT_do _ => fprint_pml_stmnt$PMLSTMNT_do<>(out, arg0)
| PMLSTMNT_atomic _ => fprint_pml_stmnt$PMLSTMNT_atomic<>(out, arg0)
| PMLSTMNT_dstep _ => fprint_pml_stmnt$PMLSTMNT_dstep<>(out, arg0)
| PMLSTMNT_block _ => fprint_pml_stmnt$PMLSTMNT_block<>(out, arg0)
| PMLSTMNT_assign _ => fprint_pml_stmnt$PMLSTMNT_assign<>(out, arg0)
| PMLSTMNT_else _ => fprint_pml_stmnt$PMLSTMNT_else<>(out, arg0)
| PMLSTMNT_break _ => fprint_pml_stmnt$PMLSTMNT_break<>(out, arg0)
| PMLSTMNT_goto _ => fprint_pml_stmnt$PMLSTMNT_goto<>(out, arg0)
| PMLSTMNT_name _ => fprint_pml_stmnt$PMLSTMNT_name<>(out, arg0)
| PMLSTMNT_assert _ => fprint_pml_stmnt$PMLSTMNT_assert<>(out, arg0)
| PMLSTMNT_exp _ => fprint_pml_stmnt$PMLSTMNT_exp<>(out, arg0)
| PMLSTMNT_inline _ => fprint_pml_stmnt$PMLSTMNT_inline<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_stmnt$sep: (FILEref) -> void
implement{}
fprint_pml_stmnt$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_stmnt$lpar: (FILEref) -> void
implement{}
fprint_pml_stmnt$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_stmnt$rpar: (FILEref) -> void
implement{}
fprint_pml_stmnt$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_stmnt$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_stmnt$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_if$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_if$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_if$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_if$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_if(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_if$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_if$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_if$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_if$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_if$con(out, _) = fprint(out, "PMLSTMNT_if")
implement{}
fprint_pml_stmnt$PMLSTMNT_if$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_if$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_if$arg1(out, arg0) =
  let val-PMLSTMNT_if(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_do$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_do$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_do$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_do$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_do(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_do$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_do$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_do$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_do$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_do$con(out, _) = fprint(out, "PMLSTMNT_do")
implement{}
fprint_pml_stmnt$PMLSTMNT_do$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_do$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_do$arg1(out, arg0) =
  let val-PMLSTMNT_do(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_atomic$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_atomic$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_atomic$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_atomic$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_atomic(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_atomic$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_atomic$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_atomic$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_atomic$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_atomic$con(out, _) = fprint(out, "PMLSTMNT_atomic")
implement{}
fprint_pml_stmnt$PMLSTMNT_atomic$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_atomic$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_atomic$arg1(out, arg0) =
  let val-PMLSTMNT_atomic(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_dstep$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_dstep$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_dstep$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_dstep$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_dstep(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_dstep$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_dstep$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_dstep$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_dstep$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_dstep$con(out, _) = fprint(out, "PMLSTMNT_dstep")
implement{}
fprint_pml_stmnt$PMLSTMNT_dstep$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_dstep$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_dstep$arg1(out, arg0) =
  let val-PMLSTMNT_dstep(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_block$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_block$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_block$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_block$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_block(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_block$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_block$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_block$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_block$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_block$con(out, _) = fprint(out, "PMLSTMNT_block")
implement{}
fprint_pml_stmnt$PMLSTMNT_block$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_block$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_block$arg1(out, arg0) =
  let val-PMLSTMNT_block(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assign$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assign$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assign$rpar: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_assign(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_assign$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_assign$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_assign$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_assign$con(out, _) = fprint(out, "PMLSTMNT_assign")
implement{}
fprint_pml_stmnt$PMLSTMNT_assign$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_assign$rpar(out, _) = fprint_pml_stmnt$rpar(out)
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_else$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_else$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_else$rpar: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_else(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_else$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_else$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_else$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_else$con(out, _) = fprint(out, "PMLSTMNT_else")
implement{}
fprint_pml_stmnt$PMLSTMNT_else$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_else$rpar(out, _) = fprint_pml_stmnt$rpar(out)
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_break$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_break$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_break$rpar: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_break(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_break$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_break$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_break$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_break$con(out, _) = fprint(out, "PMLSTMNT_break")
implement{}
fprint_pml_stmnt$PMLSTMNT_break$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_break$rpar(out, _) = fprint_pml_stmnt$rpar(out)
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_goto$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_goto$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_goto$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_goto$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_goto(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_goto$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_goto$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_goto$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_goto$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_goto$con(out, _) = fprint(out, "PMLSTMNT_goto")
implement{}
fprint_pml_stmnt$PMLSTMNT_goto$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_goto$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_goto$arg1(out, arg0) =
  let val-PMLSTMNT_goto(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name$sep1: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name$arg1: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_name$arg2: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_name(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_name$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_name$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_name$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_name$sep1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_name$arg2<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_name$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_name$con(out, _) = fprint(out, "PMLSTMNT_name")
implement{}
fprint_pml_stmnt$PMLSTMNT_name$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_name$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_name$sep1(out, _) = fprint_pml_stmnt$sep<>(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_name$arg1(out, arg0) =
  let val-PMLSTMNT_name(arg1, _) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
implement{}
fprint_pml_stmnt$PMLSTMNT_name$arg2(out, arg0) =
  let val-PMLSTMNT_name(_, arg2) = arg0 in fprint_pml_stmnt$carg(out, arg2) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assert$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assert$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assert$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_assert$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_assert(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_assert$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_assert$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_assert$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_assert$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_assert$con(out, _) = fprint(out, "PMLSTMNT_assert")
implement{}
fprint_pml_stmnt$PMLSTMNT_assert$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_assert$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_assert$arg1(out, arg0) =
  let val-PMLSTMNT_assert(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_exp$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_exp$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_exp$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_exp$arg1: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_exp(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_exp$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_exp$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_exp$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_exp$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_exp$con(out, _) = fprint(out, "PMLSTMNT_exp")
implement{}
fprint_pml_stmnt$PMLSTMNT_exp$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_exp$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_exp$arg1(out, arg0) =
  let val-PMLSTMNT_exp(arg1) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
//
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline$con: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline$lpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline$rpar: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline$sep1: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline$arg1: $d2ctype(fprint_pml_stmnt<>)
extern
fun{}
fprint_pml_stmnt$PMLSTMNT_inline$arg2: $d2ctype(fprint_pml_stmnt<>)
//
implement{}
fprint_pml_stmnt$PMLSTMNT_inline(out, arg0) = 
{
//
val () = fprint_pml_stmnt$PMLSTMNT_inline$con<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_inline$lpar<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_inline$arg1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_inline$sep1<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_inline$arg2<>(out, arg0)
val () = fprint_pml_stmnt$PMLSTMNT_inline$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_stmnt$PMLSTMNT_inline$con(out, _) = fprint(out, "PMLSTMNT_inline")
implement{}
fprint_pml_stmnt$PMLSTMNT_inline$lpar(out, _) = fprint_pml_stmnt$lpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_inline$rpar(out, _) = fprint_pml_stmnt$rpar(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_inline$sep1(out, _) = fprint_pml_stmnt$sep<>(out)
implement{}
fprint_pml_stmnt$PMLSTMNT_inline$arg1(out, arg0) =
  let val-PMLSTMNT_inline(arg1, _) = arg0 in fprint_pml_stmnt$carg(out, arg1) end
implement{}
fprint_pml_stmnt$PMLSTMNT_inline$arg2(out, arg0) =
  let val-PMLSTMNT_inline(_, arg2) = arg0 in fprint_pml_stmnt$carg(out, arg2) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_pml_module$PMLMODULE_utype: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_mtype: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_declst: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_proctype: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_inline: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_init: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_never: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_c_code: $d2ctype(fprint_pml_module<>)
//
(* ****** ****** *)
//
implement{}
fprint_pml_module
  (out, arg0) =
(
case+ arg0 of
| PMLMODULE_utype _ => fprint_pml_module$PMLMODULE_utype<>(out, arg0)
| PMLMODULE_mtype _ => fprint_pml_module$PMLMODULE_mtype<>(out, arg0)
| PMLMODULE_declst _ => fprint_pml_module$PMLMODULE_declst<>(out, arg0)
| PMLMODULE_proctype _ => fprint_pml_module$PMLMODULE_proctype<>(out, arg0)
| PMLMODULE_inline _ => fprint_pml_module$PMLMODULE_inline<>(out, arg0)
| PMLMODULE_init _ => fprint_pml_module$PMLMODULE_init<>(out, arg0)
| PMLMODULE_never _ => fprint_pml_module$PMLMODULE_never<>(out, arg0)
| PMLMODULE_c_code _ => fprint_pml_module$PMLMODULE_c_code<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_module$sep: (FILEref) -> void
implement{}
fprint_pml_module$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_pml_module$lpar: (FILEref) -> void
implement{}
fprint_pml_module$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_pml_module$rpar: (FILEref) -> void
implement{}
fprint_pml_module$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_pml_module$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_pml_module$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_pml_module$PMLMODULE_utype$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_utype$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_utype$rpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_utype$sep1: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_utype$arg1: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_utype$arg2: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_utype(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_utype$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_utype$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_utype$arg1<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_utype$sep1<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_utype$arg2<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_utype$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_utype$con(out, _) = fprint(out, "PMLMODULE_utype")
implement{}
fprint_pml_module$PMLMODULE_utype$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_utype$rpar(out, _) = fprint_pml_module$rpar(out)
implement{}
fprint_pml_module$PMLMODULE_utype$sep1(out, _) = fprint_pml_module$sep<>(out)
implement{}
fprint_pml_module$PMLMODULE_utype$arg1(out, arg0) =
  let val-PMLMODULE_utype(arg1, _) = arg0 in fprint_pml_module$carg(out, arg1) end
implement{}
fprint_pml_module$PMLMODULE_utype$arg2(out, arg0) =
  let val-PMLMODULE_utype(_, arg2) = arg0 in fprint_pml_module$carg(out, arg2) end
//
extern
fun{}
fprint_pml_module$PMLMODULE_mtype$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_mtype$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_mtype$rpar: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_mtype(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_mtype$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_mtype$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_mtype$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_mtype$con(out, _) = fprint(out, "PMLMODULE_mtype")
implement{}
fprint_pml_module$PMLMODULE_mtype$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_mtype$rpar(out, _) = fprint_pml_module$rpar(out)
//
extern
fun{}
fprint_pml_module$PMLMODULE_declst$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_declst$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_declst$rpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_declst$arg1: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_declst(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_declst$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_declst$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_declst$arg1<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_declst$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_declst$con(out, _) = fprint(out, "PMLMODULE_declst")
implement{}
fprint_pml_module$PMLMODULE_declst$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_declst$rpar(out, _) = fprint_pml_module$rpar(out)
implement{}
fprint_pml_module$PMLMODULE_declst$arg1(out, arg0) =
  let val-PMLMODULE_declst(arg1) = arg0 in fprint_pml_module$carg(out, arg1) end
//
extern
fun{}
fprint_pml_module$PMLMODULE_proctype$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_proctype$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_proctype$rpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_proctype$arg1: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_proctype(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_proctype$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_proctype$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_proctype$arg1<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_proctype$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_proctype$con(out, _) = fprint(out, "PMLMODULE_proctype")
implement{}
fprint_pml_module$PMLMODULE_proctype$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_proctype$rpar(out, _) = fprint_pml_module$rpar(out)
implement{}
fprint_pml_module$PMLMODULE_proctype$arg1(out, arg0) =
  let val-PMLMODULE_proctype(arg1) = arg0 in fprint_pml_module$carg(out, arg1) end
//
extern
fun{}
fprint_pml_module$PMLMODULE_inline$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_inline$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_inline$rpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_inline$arg1: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_inline(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_inline$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_inline$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_inline$arg1<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_inline$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_inline$con(out, _) = fprint(out, "PMLMODULE_inline")
implement{}
fprint_pml_module$PMLMODULE_inline$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_inline$rpar(out, _) = fprint_pml_module$rpar(out)
implement{}
fprint_pml_module$PMLMODULE_inline$arg1(out, arg0) =
  let val-PMLMODULE_inline(arg1) = arg0 in fprint_pml_module$carg(out, arg1) end
//
extern
fun{}
fprint_pml_module$PMLMODULE_init$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_init$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_init$rpar: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_init(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_init$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_init$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_init$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_init$con(out, _) = fprint(out, "PMLMODULE_init")
implement{}
fprint_pml_module$PMLMODULE_init$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_init$rpar(out, _) = fprint_pml_module$rpar(out)
//
extern
fun{}
fprint_pml_module$PMLMODULE_never$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_never$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_never$rpar: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_never(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_never$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_never$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_never$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_never$con(out, _) = fprint(out, "PMLMODULE_never")
implement{}
fprint_pml_module$PMLMODULE_never$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_never$rpar(out, _) = fprint_pml_module$rpar(out)
//
extern
fun{}
fprint_pml_module$PMLMODULE_c_code$con: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_c_code$lpar: $d2ctype(fprint_pml_module<>)
extern
fun{}
fprint_pml_module$PMLMODULE_c_code$rpar: $d2ctype(fprint_pml_module<>)
//
implement{}
fprint_pml_module$PMLMODULE_c_code(out, arg0) = 
{
//
val () = fprint_pml_module$PMLMODULE_c_code$con<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_c_code$lpar<>(out, arg0)
val () = fprint_pml_module$PMLMODULE_c_code$rpar<>(out, arg0)
//
}
implement{}
fprint_pml_module$PMLMODULE_c_code$con(out, _) = fprint(out, "PMLMODULE_c_code")
implement{}
fprint_pml_module$PMLMODULE_c_code$lpar(out, _) = fprint_pml_module$lpar(out)
implement{}
fprint_pml_module$PMLMODULE_c_code$rpar(out, _) = fprint_pml_module$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_type
  (arg0) =
(
case+ arg0 of
| PMLTYPE_bit _ => "PMLTYPE_bit"
| PMLTYPE_bool _ => "PMLTYPE_bool"
| PMLTYPE_byte _ => "PMLTYPE_byte"
| PMLTYPE_pid _ => "PMLTYPE_pid"
| PMLTYPE_short _ => "PMLTYPE_short"
| PMLTYPE_int _ => "PMLTYPE_int"
| PMLTYPE_mtype _ => "PMLTYPE_mtype"
| PMLTYPE_chan _ => "PMLTYPE_chan"
| PMLTYPE_uname _ => "PMLTYPE_uname"
| PMLTYPE_todo _ => "PMLTYPE_todo"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_atom
  (arg0) =
(
case+ arg0 of
| PMLATOM_INT _ => "PMLATOM_INT"
| PMLATOM_BOOL _ => "PMLATOM_BOOL"
| PMLATOM_CHAR _ => "PMLATOM_CHAR"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_opr
  (arg0) =
(
case+ arg0 of
| PMLOPR_plus _ => "PMLOPR_plus"
| PMLOPR_minus _ => "PMLOPR_minus"
| PMLOPR_and _ => "PMLOPR_and"
| PMLOPR_or _ => "PMLOPR_or"
| PMLOPR_neg _ => "PMLOPR_neg"
| PMLOPR_ban _ => "PMLOPR_ban"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_anyexp
  (arg0) =
(
case+ arg0 of
| PMLANYEXP_binarop _ => "PMLANYEXP_binarop"
| PMLANYEXP_unarop _ => "PMLANYEXP_unarop"
| PMLANYEXP_select _ => "PMLANYEXP_select"
| PMLANYEXP_varref _ => "PMLANYEXP_varref"
| PMLANYEXP_const _ => "PMLANYEXP_const"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_varref
  (arg0) =
(
case+ arg0 of
| PMLVARREF _ => "PMLVARREF"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_exp
  (arg0) =
(
case+ arg0 of
| PMLEXP_anyexp _ => "PMLEXP_anyexp"
| PMLEXP_chanop _ => "PMLEXP_chanop"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_ivar
  (arg0) =
(
case+ arg0 of
| PMLIVAR_exp _ => "PMLIVAR_exp"
| PMLIVAR_chan _ => "PMLIVAR_chan"
| PMLIVAR_name _ => "PMLIVAR_name"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_step
  (arg0) =
(
case+ arg0 of
| PMLSTEP_declst _ => "PMLSTEP_declst"
| PMLSTEP_stmnt _ => "PMLSTEP_stmnt"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_stmnt
  (arg0) =
(
case+ arg0 of
| PMLSTMNT_if _ => "PMLSTMNT_if"
| PMLSTMNT_do _ => "PMLSTMNT_do"
| PMLSTMNT_atomic _ => "PMLSTMNT_atomic"
| PMLSTMNT_dstep _ => "PMLSTMNT_dstep"
| PMLSTMNT_block _ => "PMLSTMNT_block"
| PMLSTMNT_assign _ => "PMLSTMNT_assign"
| PMLSTMNT_else _ => "PMLSTMNT_else"
| PMLSTMNT_break _ => "PMLSTMNT_break"
| PMLSTMNT_goto _ => "PMLSTMNT_goto"
| PMLSTMNT_name _ => "PMLSTMNT_name"
| PMLSTMNT_assert _ => "PMLSTMNT_assert"
| PMLSTMNT_exp _ => "PMLSTMNT_exp"
| PMLSTMNT_inline _ => "PMLSTMNT_inline"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_pml_module
  (arg0) =
(
case+ arg0 of
| PMLMODULE_utype _ => "PMLMODULE_utype"
| PMLMODULE_mtype _ => "PMLMODULE_mtype"
| PMLMODULE_declst _ => "PMLMODULE_declst"
| PMLMODULE_proctype _ => "PMLMODULE_proctype"
| PMLMODULE_inline _ => "PMLMODULE_inline"
| PMLMODULE_init _ => "PMLMODULE_init"
| PMLMODULE_never _ => "PMLMODULE_never"
| PMLMODULE_c_code _ => "PMLMODULE_c_code"
)
//
(* ****** ****** *)
