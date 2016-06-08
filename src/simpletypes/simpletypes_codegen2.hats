(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_s3type
  (arg0) =
(
case+ arg0 of
| S3TYPEref _ => "S3TYPEref"
| S3TYPErefarg _ => "S3TYPErefarg"
| S3TYPEelement _ => "S3TYPEelement"
| S3TYPErecord _ => "S3TYPErecord"
| S3TYPEprop _ => "S3TYPEprop"
| S3TYPEcon _ => "S3TYPEcon"
| S3TYPEfun _ => "S3TYPEfun"
| S3TYPEvar _ => "S3TYPEvar"
| S3TYPEpoly _ => "S3TYPEpoly"
| S3TYPEignored _ => "S3TYPEignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_s3type$S3TYPEref: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErefarg: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEelement: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEprop: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEcon: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEvar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEpoly: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEignored: $d2ctype(fprint_s3type<>)
//
(* ****** ****** *)
//
implement{}
fprint_s3type
  (out, arg0) =
(
case+ arg0 of
| S3TYPEref _ => fprint_s3type$S3TYPEref<>(out, arg0)
| S3TYPErefarg _ => fprint_s3type$S3TYPErefarg<>(out, arg0)
| S3TYPEelement _ => fprint_s3type$S3TYPEelement<>(out, arg0)
| S3TYPErecord _ => fprint_s3type$S3TYPErecord<>(out, arg0)
| S3TYPEprop _ => fprint_s3type$S3TYPEprop<>(out, arg0)
| S3TYPEcon _ => fprint_s3type$S3TYPEcon<>(out, arg0)
| S3TYPEfun _ => fprint_s3type$S3TYPEfun<>(out, arg0)
| S3TYPEvar _ => fprint_s3type$S3TYPEvar<>(out, arg0)
| S3TYPEpoly _ => fprint_s3type$S3TYPEpoly<>(out, arg0)
| S3TYPEignored _ => fprint_s3type$S3TYPEignored<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s3type$sep: (FILEref) -> void
implement{}
fprint_s3type$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_s3type$lpar: (FILEref) -> void
implement{}
fprint_s3type$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_s3type$rpar: (FILEref) -> void
implement{}
fprint_s3type$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_s3type$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_s3type$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s3type$S3TYPEref$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEref$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEref$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEref$arg1: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEref(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEref$con<>(out, arg0)
val () = fprint_s3type$S3TYPEref$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEref$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPEref$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEref$con(out, _) = fprint(out, "S3TYPEref")
implement{}
fprint_s3type$S3TYPEref$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEref$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPEref$arg1(out, arg0) =
  let val-S3TYPEref(arg1) = arg0 in fprint_s3type$carg(out, arg1) end
//
extern
fun{}
fprint_s3type$S3TYPErefarg$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErefarg$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErefarg$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErefarg$arg1: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPErefarg(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPErefarg$con<>(out, arg0)
val () = fprint_s3type$S3TYPErefarg$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPErefarg$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPErefarg$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPErefarg$con(out, _) = fprint(out, "S3TYPErefarg")
implement{}
fprint_s3type$S3TYPErefarg$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPErefarg$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPErefarg$arg1(out, arg0) =
  let val-S3TYPErefarg(arg1) = arg0 in fprint_s3type$carg(out, arg1) end
//
extern
fun{}
fprint_s3type$S3TYPEelement$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEelement$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEelement$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEelement$arg1: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEelement(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEelement$con<>(out, arg0)
val () = fprint_s3type$S3TYPEelement$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEelement$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPEelement$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEelement$con(out, _) = fprint(out, "S3TYPEelement")
implement{}
fprint_s3type$S3TYPEelement$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEelement$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPEelement$arg1(out, arg0) =
  let val-S3TYPEelement(arg1) = arg0 in fprint_s3type$carg(out, arg1) end
//
extern
fun{}
fprint_s3type$S3TYPErecord$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$sep1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$sep2: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$arg1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$arg2: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPErecord$arg3: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPErecord(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPErecord$con<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$sep1<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$arg2<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$sep2<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$arg3<>(out, arg0)
val () = fprint_s3type$S3TYPErecord$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPErecord$con(out, _) = fprint(out, "S3TYPErecord")
implement{}
fprint_s3type$S3TYPErecord$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPErecord$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPErecord$sep1(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPErecord$sep2(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPErecord$arg1(out, arg0) =
  let val-S3TYPErecord(arg1, _, _) = arg0 in fprint_s3type$carg(out, arg1) end
implement{}
fprint_s3type$S3TYPErecord$arg2(out, arg0) =
  let val-S3TYPErecord(_, arg2, _) = arg0 in fprint_s3type$carg(out, arg2) end
implement{}
fprint_s3type$S3TYPErecord$arg3(out, arg0) =
  let val-S3TYPErecord(_, _, arg3) = arg0 in fprint_s3type$carg(out, arg3) end
//
extern
fun{}
fprint_s3type$S3TYPEprop$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEprop$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEprop$rpar: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEprop(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEprop$con<>(out, arg0)
val () = fprint_s3type$S3TYPEprop$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEprop$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEprop$con(out, _) = fprint(out, "S3TYPEprop")
implement{}
fprint_s3type$S3TYPEprop$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEprop$rpar(out, _) = fprint_s3type$rpar(out)
//
extern
fun{}
fprint_s3type$S3TYPEcon$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEcon$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEcon$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEcon$sep1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEcon$arg1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEcon$arg2: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEcon(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEcon$con<>(out, arg0)
val () = fprint_s3type$S3TYPEcon$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEcon$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPEcon$sep1<>(out, arg0)
val () = fprint_s3type$S3TYPEcon$arg2<>(out, arg0)
val () = fprint_s3type$S3TYPEcon$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEcon$con(out, _) = fprint(out, "S3TYPEcon")
implement{}
fprint_s3type$S3TYPEcon$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEcon$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPEcon$sep1(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPEcon$arg1(out, arg0) =
  let val-S3TYPEcon(arg1, _) = arg0 in fprint_s3type$carg(out, arg1) end
implement{}
fprint_s3type$S3TYPEcon$arg2(out, arg0) =
  let val-S3TYPEcon(_, arg2) = arg0 in fprint_s3type$carg(out, arg2) end
//
extern
fun{}
fprint_s3type$S3TYPEfun$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$sep1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$sep2: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$sep3: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$arg1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$arg2: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$arg3: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEfun$arg4: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEfun(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEfun$con<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$sep1<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$arg2<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$sep2<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$arg3<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$sep3<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$arg4<>(out, arg0)
val () = fprint_s3type$S3TYPEfun$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEfun$con(out, _) = fprint(out, "S3TYPEfun")
implement{}
fprint_s3type$S3TYPEfun$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEfun$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPEfun$sep1(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPEfun$sep2(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPEfun$sep3(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPEfun$arg1(out, arg0) =
  let val-S3TYPEfun(arg1, _, _, _) = arg0 in fprint_s3type$carg(out, arg1) end
implement{}
fprint_s3type$S3TYPEfun$arg2(out, arg0) =
  let val-S3TYPEfun(_, arg2, _, _) = arg0 in fprint_s3type$carg(out, arg2) end
implement{}
fprint_s3type$S3TYPEfun$arg3(out, arg0) =
  let val-S3TYPEfun(_, _, arg3, _) = arg0 in fprint_s3type$carg(out, arg3) end
implement{}
fprint_s3type$S3TYPEfun$arg4(out, arg0) =
  let val-S3TYPEfun(_, _, _, arg4) = arg0 in fprint_s3type$carg(out, arg4) end
//
extern
fun{}
fprint_s3type$S3TYPEvar$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEvar$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEvar$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEvar$arg1: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEvar(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEvar$con<>(out, arg0)
val () = fprint_s3type$S3TYPEvar$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEvar$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPEvar$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEvar$con(out, _) = fprint(out, "S3TYPEvar")
implement{}
fprint_s3type$S3TYPEvar$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEvar$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPEvar$arg1(out, arg0) =
  let val-S3TYPEvar(arg1) = arg0 in fprint_s3type$carg(out, arg1) end
//
extern
fun{}
fprint_s3type$S3TYPEpoly$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEpoly$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEpoly$rpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEpoly$sep1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEpoly$arg1: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEpoly$arg2: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEpoly(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEpoly$con<>(out, arg0)
val () = fprint_s3type$S3TYPEpoly$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEpoly$arg1<>(out, arg0)
val () = fprint_s3type$S3TYPEpoly$sep1<>(out, arg0)
val () = fprint_s3type$S3TYPEpoly$arg2<>(out, arg0)
val () = fprint_s3type$S3TYPEpoly$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEpoly$con(out, _) = fprint(out, "S3TYPEpoly")
implement{}
fprint_s3type$S3TYPEpoly$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEpoly$rpar(out, _) = fprint_s3type$rpar(out)
implement{}
fprint_s3type$S3TYPEpoly$sep1(out, _) = fprint_s3type$sep<>(out)
implement{}
fprint_s3type$S3TYPEpoly$arg1(out, arg0) =
  let val-S3TYPEpoly(arg1, _) = arg0 in fprint_s3type$carg(out, arg1) end
implement{}
fprint_s3type$S3TYPEpoly$arg2(out, arg0) =
  let val-S3TYPEpoly(_, arg2) = arg0 in fprint_s3type$carg(out, arg2) end
//
extern
fun{}
fprint_s3type$S3TYPEignored$con: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEignored$lpar: $d2ctype(fprint_s3type<>)
extern
fun{}
fprint_s3type$S3TYPEignored$rpar: $d2ctype(fprint_s3type<>)
//
implement{}
fprint_s3type$S3TYPEignored(out, arg0) = 
{
//
val () = fprint_s3type$S3TYPEignored$con<>(out, arg0)
val () = fprint_s3type$S3TYPEignored$lpar<>(out, arg0)
val () = fprint_s3type$S3TYPEignored$rpar<>(out, arg0)
//
}
implement{}
fprint_s3type$S3TYPEignored$con(out, _) = fprint(out, "S3TYPEignored")
implement{}
fprint_s3type$S3TYPEignored$lpar(out, _) = fprint_s3type$lpar(out)
implement{}
fprint_s3type$S3TYPEignored$rpar(out, _) = fprint_s3type$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_s3element$S3ELEMENTint: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTchar: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTbool: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTstring: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTunit: $d2ctype(fprint_s3element<>)
//
(* ****** ****** *)
//
implement{}
fprint_s3element
  (out, arg0) =
(
case+ arg0 of
| S3ELEMENTint _ => fprint_s3element$S3ELEMENTint<>(out, arg0)
| S3ELEMENTchar _ => fprint_s3element$S3ELEMENTchar<>(out, arg0)
| S3ELEMENTbool _ => fprint_s3element$S3ELEMENTbool<>(out, arg0)
| S3ELEMENTstring _ => fprint_s3element$S3ELEMENTstring<>(out, arg0)
| S3ELEMENTunit _ => fprint_s3element$S3ELEMENTunit<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s3element$sep: (FILEref) -> void
implement{}
fprint_s3element$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_s3element$lpar: (FILEref) -> void
implement{}
fprint_s3element$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_s3element$rpar: (FILEref) -> void
implement{}
fprint_s3element$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_s3element$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_s3element$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s3element$S3ELEMENTint$con: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTint$lpar: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTint$rpar: $d2ctype(fprint_s3element<>)
//
implement{}
fprint_s3element$S3ELEMENTint(out, arg0) = 
{
//
val () = fprint_s3element$S3ELEMENTint$con<>(out, arg0)
val () = fprint_s3element$S3ELEMENTint$lpar<>(out, arg0)
val () = fprint_s3element$S3ELEMENTint$rpar<>(out, arg0)
//
}
implement{}
fprint_s3element$S3ELEMENTint$con(out, _) = fprint(out, "S3ELEMENTint")
implement{}
fprint_s3element$S3ELEMENTint$lpar(out, _) = fprint_s3element$lpar(out)
implement{}
fprint_s3element$S3ELEMENTint$rpar(out, _) = fprint_s3element$rpar(out)
//
extern
fun{}
fprint_s3element$S3ELEMENTchar$con: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTchar$lpar: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTchar$rpar: $d2ctype(fprint_s3element<>)
//
implement{}
fprint_s3element$S3ELEMENTchar(out, arg0) = 
{
//
val () = fprint_s3element$S3ELEMENTchar$con<>(out, arg0)
val () = fprint_s3element$S3ELEMENTchar$lpar<>(out, arg0)
val () = fprint_s3element$S3ELEMENTchar$rpar<>(out, arg0)
//
}
implement{}
fprint_s3element$S3ELEMENTchar$con(out, _) = fprint(out, "S3ELEMENTchar")
implement{}
fprint_s3element$S3ELEMENTchar$lpar(out, _) = fprint_s3element$lpar(out)
implement{}
fprint_s3element$S3ELEMENTchar$rpar(out, _) = fprint_s3element$rpar(out)
//
extern
fun{}
fprint_s3element$S3ELEMENTbool$con: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTbool$lpar: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTbool$rpar: $d2ctype(fprint_s3element<>)
//
implement{}
fprint_s3element$S3ELEMENTbool(out, arg0) = 
{
//
val () = fprint_s3element$S3ELEMENTbool$con<>(out, arg0)
val () = fprint_s3element$S3ELEMENTbool$lpar<>(out, arg0)
val () = fprint_s3element$S3ELEMENTbool$rpar<>(out, arg0)
//
}
implement{}
fprint_s3element$S3ELEMENTbool$con(out, _) = fprint(out, "S3ELEMENTbool")
implement{}
fprint_s3element$S3ELEMENTbool$lpar(out, _) = fprint_s3element$lpar(out)
implement{}
fprint_s3element$S3ELEMENTbool$rpar(out, _) = fprint_s3element$rpar(out)
//
extern
fun{}
fprint_s3element$S3ELEMENTstring$con: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTstring$lpar: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTstring$rpar: $d2ctype(fprint_s3element<>)
//
implement{}
fprint_s3element$S3ELEMENTstring(out, arg0) = 
{
//
val () = fprint_s3element$S3ELEMENTstring$con<>(out, arg0)
val () = fprint_s3element$S3ELEMENTstring$lpar<>(out, arg0)
val () = fprint_s3element$S3ELEMENTstring$rpar<>(out, arg0)
//
}
implement{}
fprint_s3element$S3ELEMENTstring$con(out, _) = fprint(out, "S3ELEMENTstring")
implement{}
fprint_s3element$S3ELEMENTstring$lpar(out, _) = fprint_s3element$lpar(out)
implement{}
fprint_s3element$S3ELEMENTstring$rpar(out, _) = fprint_s3element$rpar(out)
//
extern
fun{}
fprint_s3element$S3ELEMENTunit$con: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTunit$lpar: $d2ctype(fprint_s3element<>)
extern
fun{}
fprint_s3element$S3ELEMENTunit$rpar: $d2ctype(fprint_s3element<>)
//
implement{}
fprint_s3element$S3ELEMENTunit(out, arg0) = 
{
//
val () = fprint_s3element$S3ELEMENTunit$con<>(out, arg0)
val () = fprint_s3element$S3ELEMENTunit$lpar<>(out, arg0)
val () = fprint_s3element$S3ELEMENTunit$rpar<>(out, arg0)
//
}
implement{}
fprint_s3element$S3ELEMENTunit$con(out, _) = fprint(out, "S3ELEMENTunit")
implement{}
fprint_s3element$S3ELEMENTunit$lpar(out, _) = fprint_s3element$lpar(out)
implement{}
fprint_s3element$S3ELEMENTunit$rpar(out, _) = fprint_s3element$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_s3tkind$S3TKINDflat: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDboxed: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDignored: $d2ctype(fprint_s3tkind<>)
//
(* ****** ****** *)
//
implement{}
fprint_s3tkind
  (out, arg0) =
(
case+ arg0 of
| S3TKINDflat _ => fprint_s3tkind$S3TKINDflat<>(out, arg0)
| S3TKINDboxed _ => fprint_s3tkind$S3TKINDboxed<>(out, arg0)
| S3TKINDignored _ => fprint_s3tkind$S3TKINDignored<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s3tkind$sep: (FILEref) -> void
implement{}
fprint_s3tkind$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_s3tkind$lpar: (FILEref) -> void
implement{}
fprint_s3tkind$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_s3tkind$rpar: (FILEref) -> void
implement{}
fprint_s3tkind$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_s3tkind$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_s3tkind$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_s3tkind$S3TKINDflat$con: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDflat$lpar: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDflat$rpar: $d2ctype(fprint_s3tkind<>)
//
implement{}
fprint_s3tkind$S3TKINDflat(out, arg0) = 
{
//
val () = fprint_s3tkind$S3TKINDflat$con<>(out, arg0)
val () = fprint_s3tkind$S3TKINDflat$lpar<>(out, arg0)
val () = fprint_s3tkind$S3TKINDflat$rpar<>(out, arg0)
//
}
implement{}
fprint_s3tkind$S3TKINDflat$con(out, _) = fprint(out, "S3TKINDflat")
implement{}
fprint_s3tkind$S3TKINDflat$lpar(out, _) = fprint_s3tkind$lpar(out)
implement{}
fprint_s3tkind$S3TKINDflat$rpar(out, _) = fprint_s3tkind$rpar(out)
//
extern
fun{}
fprint_s3tkind$S3TKINDboxed$con: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDboxed$lpar: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDboxed$rpar: $d2ctype(fprint_s3tkind<>)
//
implement{}
fprint_s3tkind$S3TKINDboxed(out, arg0) = 
{
//
val () = fprint_s3tkind$S3TKINDboxed$con<>(out, arg0)
val () = fprint_s3tkind$S3TKINDboxed$lpar<>(out, arg0)
val () = fprint_s3tkind$S3TKINDboxed$rpar<>(out, arg0)
//
}
implement{}
fprint_s3tkind$S3TKINDboxed$con(out, _) = fprint(out, "S3TKINDboxed")
implement{}
fprint_s3tkind$S3TKINDboxed$lpar(out, _) = fprint_s3tkind$lpar(out)
implement{}
fprint_s3tkind$S3TKINDboxed$rpar(out, _) = fprint_s3tkind$rpar(out)
//
extern
fun{}
fprint_s3tkind$S3TKINDignored$con: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDignored$lpar: $d2ctype(fprint_s3tkind<>)
extern
fun{}
fprint_s3tkind$S3TKINDignored$rpar: $d2ctype(fprint_s3tkind<>)
//
implement{}
fprint_s3tkind$S3TKINDignored(out, arg0) = 
{
//
val () = fprint_s3tkind$S3TKINDignored$con<>(out, arg0)
val () = fprint_s3tkind$S3TKINDignored$lpar<>(out, arg0)
val () = fprint_s3tkind$S3TKINDignored$rpar<>(out, arg0)
//
}
implement{}
fprint_s3tkind$S3TKINDignored$con(out, _) = fprint(out, "S3TKINDignored")
implement{}
fprint_s3tkind$S3TKINDignored$lpar(out, _) = fprint_s3tkind$lpar(out)
implement{}
fprint_s3tkind$S3TKINDignored$rpar(out, _) = fprint_s3tkind$rpar(out)
//
(* ****** ****** *)
