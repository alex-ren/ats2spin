(* ****** ****** *)
//
extern
fun{}
fprint_i0exp$EXP0int: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0i0nt: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0string: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0var: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0app: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0extfcall: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0lambody: $d2ctype(fprint_i0exp<>)
//
(* ****** ****** *)
//
implement{}
fprint_i0exp
  (out, arg0) =
(
case+ arg0 of
| EXP0int _ => fprint_i0exp$EXP0int<>(out, arg0)
| EXP0i0nt _ => fprint_i0exp$EXP0i0nt<>(out, arg0)
| EXP0string _ => fprint_i0exp$EXP0string<>(out, arg0)
| EXP0var _ => fprint_i0exp$EXP0var<>(out, arg0)
| EXP0app _ => fprint_i0exp$EXP0app<>(out, arg0)
| EXP0extfcall _ => fprint_i0exp$EXP0extfcall<>(out, arg0)
| EXP0lambody _ => fprint_i0exp$EXP0lambody<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_i0exp$sep: (FILEref) -> void
implement{}
fprint_i0exp$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_i0exp$lpar: (FILEref) -> void
implement{}
fprint_i0exp$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_i0exp$rpar: (FILEref) -> void
implement{}
fprint_i0exp$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_i0exp$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_i0exp$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_i0exp$EXP0int$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0int$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0int$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0int$arg1: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0int(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0int$con<>(out, arg0)
val () = fprint_i0exp$EXP0int$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0int$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0int$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0int$con(out, _) = fprint(out, "EXP0int")
implement{}
fprint_i0exp$EXP0int$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0int$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0int$arg1(out, arg0) =
  let val-EXP0int(arg1) = arg0 in fprint_i0exp$carg(out, arg1) end
//
extern
fun{}
fprint_i0exp$EXP0i0nt$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0i0nt$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0i0nt$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0i0nt$arg1: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0i0nt(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0i0nt$con<>(out, arg0)
val () = fprint_i0exp$EXP0i0nt$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0i0nt$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0i0nt$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0i0nt$con(out, _) = fprint(out, "EXP0i0nt")
implement{}
fprint_i0exp$EXP0i0nt$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0i0nt$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0i0nt$arg1(out, arg0) =
  let val-EXP0i0nt(arg1) = arg0 in fprint_i0exp$carg(out, arg1) end
//
extern
fun{}
fprint_i0exp$EXP0string$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0string$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0string$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0string$arg1: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0string(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0string$con<>(out, arg0)
val () = fprint_i0exp$EXP0string$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0string$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0string$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0string$con(out, _) = fprint(out, "EXP0string")
implement{}
fprint_i0exp$EXP0string$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0string$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0string$arg1(out, arg0) =
  let val-EXP0string(arg1) = arg0 in fprint_i0exp$carg(out, arg1) end
//
extern
fun{}
fprint_i0exp$EXP0var$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0var$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0var$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0var$arg1: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0var(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0var$con<>(out, arg0)
val () = fprint_i0exp$EXP0var$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0var$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0var$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0var$con(out, _) = fprint(out, "EXP0var")
implement{}
fprint_i0exp$EXP0var$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0var$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0var$arg1(out, arg0) =
  let val-EXP0var(arg1) = arg0 in fprint_i0exp$carg(out, arg1) end
//
extern
fun{}
fprint_i0exp$EXP0app$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0app$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0app$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0app$sep1: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0app$arg1: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0app$arg2: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0app(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0app$con<>(out, arg0)
val () = fprint_i0exp$EXP0app$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0app$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0app$sep1<>(out, arg0)
val () = fprint_i0exp$EXP0app$arg2<>(out, arg0)
val () = fprint_i0exp$EXP0app$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0app$con(out, _) = fprint(out, "EXP0app")
implement{}
fprint_i0exp$EXP0app$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0app$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0app$sep1(out, _) = fprint_i0exp$sep<>(out)
implement{}
fprint_i0exp$EXP0app$arg1(out, arg0) =
  let val-EXP0app(arg1, _) = arg0 in fprint_i0exp$carg(out, arg1) end
implement{}
fprint_i0exp$EXP0app$arg2(out, arg0) =
  let val-EXP0app(_, arg2) = arg0 in fprint_i0exp$carg(out, arg2) end
//
extern
fun{}
fprint_i0exp$EXP0extfcall$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0extfcall$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0extfcall$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0extfcall$sep1: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0extfcall$arg1: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0extfcall$arg2: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0extfcall(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0extfcall$con<>(out, arg0)
val () = fprint_i0exp$EXP0extfcall$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0extfcall$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0extfcall$sep1<>(out, arg0)
val () = fprint_i0exp$EXP0extfcall$arg2<>(out, arg0)
val () = fprint_i0exp$EXP0extfcall$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0extfcall$con(out, _) = fprint(out, "EXP0extfcall")
implement{}
fprint_i0exp$EXP0extfcall$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0extfcall$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0extfcall$sep1(out, _) = fprint_i0exp$sep<>(out)
implement{}
fprint_i0exp$EXP0extfcall$arg1(out, arg0) =
  let val-EXP0extfcall(arg1, _) = arg0 in fprint_i0exp$carg(out, arg1) end
implement{}
fprint_i0exp$EXP0extfcall$arg2(out, arg0) =
  let val-EXP0extfcall(_, arg2) = arg0 in fprint_i0exp$carg(out, arg2) end
//
extern
fun{}
fprint_i0exp$EXP0lambody$con: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0lambody$lpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0lambody$rpar: $d2ctype(fprint_i0exp<>)
extern
fun{}
fprint_i0exp$EXP0lambody$arg1: $d2ctype(fprint_i0exp<>)
//
implement{}
fprint_i0exp$EXP0lambody(out, arg0) = 
{
//
val () = fprint_i0exp$EXP0lambody$con<>(out, arg0)
val () = fprint_i0exp$EXP0lambody$lpar<>(out, arg0)
val () = fprint_i0exp$EXP0lambody$arg1<>(out, arg0)
val () = fprint_i0exp$EXP0lambody$rpar<>(out, arg0)
//
}
implement{}
fprint_i0exp$EXP0lambody$con(out, _) = fprint(out, "EXP0lambody")
implement{}
fprint_i0exp$EXP0lambody$lpar(out, _) = fprint_i0exp$lpar(out)
implement{}
fprint_i0exp$EXP0lambody$rpar(out, _) = fprint_i0exp$rpar(out)
implement{}
fprint_i0exp$EXP0lambody$arg1(out, arg0) =
  let val-EXP0lambody(arg1) = arg0 in fprint_i0exp$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_i0ins$INS0decl: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0assign: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0label: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0return: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0random: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0goto: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0init_loop: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0tail_jump: $d2ctype(fprint_i0ins<>)
//
(* ****** ****** *)
//
implement{}
fprint_i0ins
  (out, arg0) =
(
case+ arg0 of
| INS0decl _ => fprint_i0ins$INS0decl<>(out, arg0)
| INS0assign _ => fprint_i0ins$INS0assign<>(out, arg0)
| INS0label _ => fprint_i0ins$INS0label<>(out, arg0)
| INS0return _ => fprint_i0ins$INS0return<>(out, arg0)
| INS0ifbranch _ => fprint_i0ins$INS0ifbranch<>(out, arg0)
| INS0random _ => fprint_i0ins$INS0random<>(out, arg0)
| INS0goto _ => fprint_i0ins$INS0goto<>(out, arg0)
| INS0init_loop _ => fprint_i0ins$INS0init_loop<>(out, arg0)
| INS0tail_jump _ => fprint_i0ins$INS0tail_jump<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_i0ins$sep: (FILEref) -> void
implement{}
fprint_i0ins$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_i0ins$lpar: (FILEref) -> void
implement{}
fprint_i0ins$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_i0ins$rpar: (FILEref) -> void
implement{}
fprint_i0ins$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_i0ins$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_i0ins$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_i0ins$INS0decl$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0decl$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0decl$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0decl$sep1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0decl$arg1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0decl$arg2: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0decl(out, arg0) = 
{
//
val () = fprint_i0ins$INS0decl$con<>(out, arg0)
val () = fprint_i0ins$INS0decl$lpar<>(out, arg0)
val () = fprint_i0ins$INS0decl$arg1<>(out, arg0)
val () = fprint_i0ins$INS0decl$sep1<>(out, arg0)
val () = fprint_i0ins$INS0decl$arg2<>(out, arg0)
val () = fprint_i0ins$INS0decl$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0decl$con(out, _) = fprint(out, "INS0decl")
implement{}
fprint_i0ins$INS0decl$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0decl$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0decl$sep1(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0decl$arg1(out, arg0) =
  let val-INS0decl(arg1, _) = arg0 in fprint_i0ins$carg(out, arg1) end
implement{}
fprint_i0ins$INS0decl$arg2(out, arg0) =
  let val-INS0decl(_, arg2) = arg0 in fprint_i0ins$carg(out, arg2) end
//
extern
fun{}
fprint_i0ins$INS0assign$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0assign$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0assign$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0assign$sep1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0assign$arg1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0assign$arg2: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0assign(out, arg0) = 
{
//
val () = fprint_i0ins$INS0assign$con<>(out, arg0)
val () = fprint_i0ins$INS0assign$lpar<>(out, arg0)
val () = fprint_i0ins$INS0assign$arg1<>(out, arg0)
val () = fprint_i0ins$INS0assign$sep1<>(out, arg0)
val () = fprint_i0ins$INS0assign$arg2<>(out, arg0)
val () = fprint_i0ins$INS0assign$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0assign$con(out, _) = fprint(out, "INS0assign")
implement{}
fprint_i0ins$INS0assign$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0assign$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0assign$sep1(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0assign$arg1(out, arg0) =
  let val-INS0assign(arg1, _) = arg0 in fprint_i0ins$carg(out, arg1) end
implement{}
fprint_i0ins$INS0assign$arg2(out, arg0) =
  let val-INS0assign(_, arg2) = arg0 in fprint_i0ins$carg(out, arg2) end
//
extern
fun{}
fprint_i0ins$INS0label$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0label$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0label$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0label$arg1: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0label(out, arg0) = 
{
//
val () = fprint_i0ins$INS0label$con<>(out, arg0)
val () = fprint_i0ins$INS0label$lpar<>(out, arg0)
val () = fprint_i0ins$INS0label$arg1<>(out, arg0)
val () = fprint_i0ins$INS0label$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0label$con(out, _) = fprint(out, "INS0label")
implement{}
fprint_i0ins$INS0label$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0label$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0label$arg1(out, arg0) =
  let val-INS0label(arg1) = arg0 in fprint_i0ins$carg(out, arg1) end
//
extern
fun{}
fprint_i0ins$INS0return$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0return$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0return$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0return$arg1: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0return(out, arg0) = 
{
//
val () = fprint_i0ins$INS0return$con<>(out, arg0)
val () = fprint_i0ins$INS0return$lpar<>(out, arg0)
val () = fprint_i0ins$INS0return$arg1<>(out, arg0)
val () = fprint_i0ins$INS0return$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0return$con(out, _) = fprint(out, "INS0return")
implement{}
fprint_i0ins$INS0return$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0return$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0return$arg1(out, arg0) =
  let val-INS0return(arg1) = arg0 in fprint_i0ins$carg(out, arg1) end
//
extern
fun{}
fprint_i0ins$INS0ifbranch$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$sep1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$sep2: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$arg1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$arg2: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0ifbranch$arg3: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0ifbranch(out, arg0) = 
{
//
val () = fprint_i0ins$INS0ifbranch$con<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$lpar<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$arg1<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$sep1<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$arg2<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$sep2<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$arg3<>(out, arg0)
val () = fprint_i0ins$INS0ifbranch$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0ifbranch$con(out, _) = fprint(out, "INS0ifbranch")
implement{}
fprint_i0ins$INS0ifbranch$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0ifbranch$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0ifbranch$sep1(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0ifbranch$sep2(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0ifbranch$arg1(out, arg0) =
  let val-INS0ifbranch(arg1, _, _) = arg0 in fprint_i0ins$carg(out, arg1) end
implement{}
fprint_i0ins$INS0ifbranch$arg2(out, arg0) =
  let val-INS0ifbranch(_, arg2, _) = arg0 in fprint_i0ins$carg(out, arg2) end
implement{}
fprint_i0ins$INS0ifbranch$arg3(out, arg0) =
  let val-INS0ifbranch(_, _, arg3) = arg0 in fprint_i0ins$carg(out, arg3) end
//
extern
fun{}
fprint_i0ins$INS0random$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0random$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0random$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0random$sep1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0random$arg1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0random$arg2: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0random(out, arg0) = 
{
//
val () = fprint_i0ins$INS0random$con<>(out, arg0)
val () = fprint_i0ins$INS0random$lpar<>(out, arg0)
val () = fprint_i0ins$INS0random$arg1<>(out, arg0)
val () = fprint_i0ins$INS0random$sep1<>(out, arg0)
val () = fprint_i0ins$INS0random$arg2<>(out, arg0)
val () = fprint_i0ins$INS0random$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0random$con(out, _) = fprint(out, "INS0random")
implement{}
fprint_i0ins$INS0random$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0random$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0random$sep1(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0random$arg1(out, arg0) =
  let val-INS0random(arg1, _) = arg0 in fprint_i0ins$carg(out, arg1) end
implement{}
fprint_i0ins$INS0random$arg2(out, arg0) =
  let val-INS0random(_, arg2) = arg0 in fprint_i0ins$carg(out, arg2) end
//
extern
fun{}
fprint_i0ins$INS0goto$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0goto$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0goto$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0goto$arg1: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0goto(out, arg0) = 
{
//
val () = fprint_i0ins$INS0goto$con<>(out, arg0)
val () = fprint_i0ins$INS0goto$lpar<>(out, arg0)
val () = fprint_i0ins$INS0goto$arg1<>(out, arg0)
val () = fprint_i0ins$INS0goto$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0goto$con(out, _) = fprint(out, "INS0goto")
implement{}
fprint_i0ins$INS0goto$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0goto$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0goto$arg1(out, arg0) =
  let val-INS0goto(arg1) = arg0 in fprint_i0ins$carg(out, arg1) end
//
extern
fun{}
fprint_i0ins$INS0init_loop$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0init_loop$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0init_loop$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0init_loop$sep1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0init_loop$arg1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0init_loop$arg2: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0init_loop(out, arg0) = 
{
//
val () = fprint_i0ins$INS0init_loop$con<>(out, arg0)
val () = fprint_i0ins$INS0init_loop$lpar<>(out, arg0)
val () = fprint_i0ins$INS0init_loop$arg1<>(out, arg0)
val () = fprint_i0ins$INS0init_loop$sep1<>(out, arg0)
val () = fprint_i0ins$INS0init_loop$arg2<>(out, arg0)
val () = fprint_i0ins$INS0init_loop$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0init_loop$con(out, _) = fprint(out, "INS0init_loop")
implement{}
fprint_i0ins$INS0init_loop$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0init_loop$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0init_loop$sep1(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0init_loop$arg1(out, arg0) =
  let val-INS0init_loop(arg1, _) = arg0 in fprint_i0ins$carg(out, arg1) end
implement{}
fprint_i0ins$INS0init_loop$arg2(out, arg0) =
  let val-INS0init_loop(_, arg2) = arg0 in fprint_i0ins$carg(out, arg2) end
//
extern
fun{}
fprint_i0ins$INS0tail_jump$con: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0tail_jump$lpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0tail_jump$rpar: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0tail_jump$sep1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0tail_jump$arg1: $d2ctype(fprint_i0ins<>)
extern
fun{}
fprint_i0ins$INS0tail_jump$arg2: $d2ctype(fprint_i0ins<>)
//
implement{}
fprint_i0ins$INS0tail_jump(out, arg0) = 
{
//
val () = fprint_i0ins$INS0tail_jump$con<>(out, arg0)
val () = fprint_i0ins$INS0tail_jump$lpar<>(out, arg0)
val () = fprint_i0ins$INS0tail_jump$arg1<>(out, arg0)
val () = fprint_i0ins$INS0tail_jump$sep1<>(out, arg0)
val () = fprint_i0ins$INS0tail_jump$arg2<>(out, arg0)
val () = fprint_i0ins$INS0tail_jump$rpar<>(out, arg0)
//
}
implement{}
fprint_i0ins$INS0tail_jump$con(out, _) = fprint(out, "INS0tail_jump")
implement{}
fprint_i0ins$INS0tail_jump$lpar(out, _) = fprint_i0ins$lpar(out)
implement{}
fprint_i0ins$INS0tail_jump$rpar(out, _) = fprint_i0ins$rpar(out)
implement{}
fprint_i0ins$INS0tail_jump$sep1(out, _) = fprint_i0ins$sep<>(out)
implement{}
fprint_i0ins$INS0tail_jump$arg1(out, arg0) =
  let val-INS0tail_jump(arg1, _) = arg0 in fprint_i0ins$carg(out, arg1) end
implement{}
fprint_i0ins$INS0tail_jump$arg2(out, arg0) =
  let val-INS0tail_jump(_, arg2) = arg0 in fprint_i0ins$carg(out, arg2) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_i0decl$DEC0fun: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0extcode: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0gvar: $d2ctype(fprint_i0decl<>)
//
(* ****** ****** *)
//
implement{}
fprint_i0decl
  (out, arg0) =
(
case+ arg0 of
| DEC0fun _ => fprint_i0decl$DEC0fun<>(out, arg0)
| DEC0extcode _ => fprint_i0decl$DEC0extcode<>(out, arg0)
| DEC0gvar _ => fprint_i0decl$DEC0gvar<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_i0decl$sep: (FILEref) -> void
implement{}
fprint_i0decl$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_i0decl$lpar: (FILEref) -> void
implement{}
fprint_i0decl$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_i0decl$rpar: (FILEref) -> void
implement{}
fprint_i0decl$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_i0decl$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_i0decl$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_i0decl$DEC0fun$con: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0fun$lpar: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0fun$rpar: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0fun$arg1: $d2ctype(fprint_i0decl<>)
//
implement{}
fprint_i0decl$DEC0fun(out, arg0) = 
{
//
val () = fprint_i0decl$DEC0fun$con<>(out, arg0)
val () = fprint_i0decl$DEC0fun$lpar<>(out, arg0)
val () = fprint_i0decl$DEC0fun$arg1<>(out, arg0)
val () = fprint_i0decl$DEC0fun$rpar<>(out, arg0)
//
}
implement{}
fprint_i0decl$DEC0fun$con(out, _) = fprint(out, "DEC0fun")
implement{}
fprint_i0decl$DEC0fun$lpar(out, _) = fprint_i0decl$lpar(out)
implement{}
fprint_i0decl$DEC0fun$rpar(out, _) = fprint_i0decl$rpar(out)
implement{}
fprint_i0decl$DEC0fun$arg1(out, arg0) =
  let val-DEC0fun(arg1) = arg0 in fprint_i0decl$carg(out, arg1) end
//
extern
fun{}
fprint_i0decl$DEC0extcode$con: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0extcode$lpar: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0extcode$rpar: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0extcode$arg1: $d2ctype(fprint_i0decl<>)
//
implement{}
fprint_i0decl$DEC0extcode(out, arg0) = 
{
//
val () = fprint_i0decl$DEC0extcode$con<>(out, arg0)
val () = fprint_i0decl$DEC0extcode$lpar<>(out, arg0)
val () = fprint_i0decl$DEC0extcode$arg1<>(out, arg0)
val () = fprint_i0decl$DEC0extcode$rpar<>(out, arg0)
//
}
implement{}
fprint_i0decl$DEC0extcode$con(out, _) = fprint(out, "DEC0extcode")
implement{}
fprint_i0decl$DEC0extcode$lpar(out, _) = fprint_i0decl$lpar(out)
implement{}
fprint_i0decl$DEC0extcode$rpar(out, _) = fprint_i0decl$rpar(out)
implement{}
fprint_i0decl$DEC0extcode$arg1(out, arg0) =
  let val-DEC0extcode(arg1) = arg0 in fprint_i0decl$carg(out, arg1) end
//
extern
fun{}
fprint_i0decl$DEC0gvar$con: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0gvar$lpar: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0gvar$rpar: $d2ctype(fprint_i0decl<>)
extern
fun{}
fprint_i0decl$DEC0gvar$arg1: $d2ctype(fprint_i0decl<>)
//
implement{}
fprint_i0decl$DEC0gvar(out, arg0) = 
{
//
val () = fprint_i0decl$DEC0gvar$con<>(out, arg0)
val () = fprint_i0decl$DEC0gvar$lpar<>(out, arg0)
val () = fprint_i0decl$DEC0gvar$arg1<>(out, arg0)
val () = fprint_i0decl$DEC0gvar$rpar<>(out, arg0)
//
}
implement{}
fprint_i0decl$DEC0gvar$con(out, _) = fprint(out, "DEC0gvar")
implement{}
fprint_i0decl$DEC0gvar$lpar(out, _) = fprint_i0decl$lpar(out)
implement{}
fprint_i0decl$DEC0gvar$rpar(out, _) = fprint_i0decl$rpar(out)
implement{}
fprint_i0decl$DEC0gvar$arg1(out, arg0) =
  let val-DEC0gvar(arg1) = arg0 in fprint_i0decl$carg(out, arg1) end
//
(* ****** ****** *)
(* ****** ****** *)
//
extern
fun{}
fprint_type0$TYPE0int: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0char: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0bool: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0unit: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0fun: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ref: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0symbol: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0datatype: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ignored: $d2ctype(fprint_type0<>)
//
(* ****** ****** *)
//
implement{}
fprint_type0
  (out, arg0) =
(
case+ arg0 of
| TYPE0int _ => fprint_type0$TYPE0int<>(out, arg0)
| TYPE0char _ => fprint_type0$TYPE0char<>(out, arg0)
| TYPE0bool _ => fprint_type0$TYPE0bool<>(out, arg0)
| TYPE0unit _ => fprint_type0$TYPE0unit<>(out, arg0)
| TYPE0fun _ => fprint_type0$TYPE0fun<>(out, arg0)
| TYPE0ref _ => fprint_type0$TYPE0ref<>(out, arg0)
| TYPE0symbol _ => fprint_type0$TYPE0symbol<>(out, arg0)
| TYPE0datatype _ => fprint_type0$TYPE0datatype<>(out, arg0)
| TYPE0ignored _ => fprint_type0$TYPE0ignored<>(out, arg0)
)
//
(* ****** ****** *)
//
extern
fun{}
fprint_type0$sep: (FILEref) -> void
implement{}
fprint_type0$sep(out) = fprint(out, ",")
//
extern
fun{}
fprint_type0$lpar: (FILEref) -> void
implement{}
fprint_type0$lpar(out) = fprint(out, "(")
//
extern
fun{}
fprint_type0$rpar: (FILEref) -> void
implement{}
fprint_type0$rpar(out) = fprint(out, ")")
//
extern
fun{a:t0p}
fprint_type0$carg: (FILEref, INV(a)) -> void
implement{a}
fprint_type0$carg(out, arg) = fprint_val<a>(out, arg)
//
(* ****** ****** *)
//
extern
fun{}
fprint_type0$TYPE0int$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0int$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0int$rpar: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0int(out, arg0) = 
{
//
val () = fprint_type0$TYPE0int$con<>(out, arg0)
val () = fprint_type0$TYPE0int$lpar<>(out, arg0)
val () = fprint_type0$TYPE0int$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0int$con(out, _) = fprint(out, "TYPE0int")
implement{}
fprint_type0$TYPE0int$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0int$rpar(out, _) = fprint_type0$rpar(out)
//
extern
fun{}
fprint_type0$TYPE0char$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0char$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0char$rpar: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0char(out, arg0) = 
{
//
val () = fprint_type0$TYPE0char$con<>(out, arg0)
val () = fprint_type0$TYPE0char$lpar<>(out, arg0)
val () = fprint_type0$TYPE0char$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0char$con(out, _) = fprint(out, "TYPE0char")
implement{}
fprint_type0$TYPE0char$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0char$rpar(out, _) = fprint_type0$rpar(out)
//
extern
fun{}
fprint_type0$TYPE0bool$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0bool$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0bool$rpar: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0bool(out, arg0) = 
{
//
val () = fprint_type0$TYPE0bool$con<>(out, arg0)
val () = fprint_type0$TYPE0bool$lpar<>(out, arg0)
val () = fprint_type0$TYPE0bool$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0bool$con(out, _) = fprint(out, "TYPE0bool")
implement{}
fprint_type0$TYPE0bool$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0bool$rpar(out, _) = fprint_type0$rpar(out)
//
extern
fun{}
fprint_type0$TYPE0unit$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0unit$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0unit$rpar: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0unit(out, arg0) = 
{
//
val () = fprint_type0$TYPE0unit$con<>(out, arg0)
val () = fprint_type0$TYPE0unit$lpar<>(out, arg0)
val () = fprint_type0$TYPE0unit$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0unit$con(out, _) = fprint(out, "TYPE0unit")
implement{}
fprint_type0$TYPE0unit$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0unit$rpar(out, _) = fprint_type0$rpar(out)
//
extern
fun{}
fprint_type0$TYPE0fun$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0fun$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0fun$rpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0fun$sep1: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0fun$arg1: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0fun$arg2: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0fun(out, arg0) = 
{
//
val () = fprint_type0$TYPE0fun$con<>(out, arg0)
val () = fprint_type0$TYPE0fun$lpar<>(out, arg0)
val () = fprint_type0$TYPE0fun$arg1<>(out, arg0)
val () = fprint_type0$TYPE0fun$sep1<>(out, arg0)
val () = fprint_type0$TYPE0fun$arg2<>(out, arg0)
val () = fprint_type0$TYPE0fun$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0fun$con(out, _) = fprint(out, "TYPE0fun")
implement{}
fprint_type0$TYPE0fun$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0fun$rpar(out, _) = fprint_type0$rpar(out)
implement{}
fprint_type0$TYPE0fun$sep1(out, _) = fprint_type0$sep<>(out)
implement{}
fprint_type0$TYPE0fun$arg1(out, arg0) =
  let val-TYPE0fun(arg1, _) = arg0 in fprint_type0$carg(out, arg1) end
implement{}
fprint_type0$TYPE0fun$arg2(out, arg0) =
  let val-TYPE0fun(_, arg2) = arg0 in fprint_type0$carg(out, arg2) end
//
extern
fun{}
fprint_type0$TYPE0ref$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ref$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ref$rpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ref$arg1: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0ref(out, arg0) = 
{
//
val () = fprint_type0$TYPE0ref$con<>(out, arg0)
val () = fprint_type0$TYPE0ref$lpar<>(out, arg0)
val () = fprint_type0$TYPE0ref$arg1<>(out, arg0)
val () = fprint_type0$TYPE0ref$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0ref$con(out, _) = fprint(out, "TYPE0ref")
implement{}
fprint_type0$TYPE0ref$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0ref$rpar(out, _) = fprint_type0$rpar(out)
implement{}
fprint_type0$TYPE0ref$arg1(out, arg0) =
  let val-TYPE0ref(arg1) = arg0 in fprint_type0$carg(out, arg1) end
//
extern
fun{}
fprint_type0$TYPE0symbol$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0symbol$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0symbol$rpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0symbol$arg1: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0symbol(out, arg0) = 
{
//
val () = fprint_type0$TYPE0symbol$con<>(out, arg0)
val () = fprint_type0$TYPE0symbol$lpar<>(out, arg0)
val () = fprint_type0$TYPE0symbol$arg1<>(out, arg0)
val () = fprint_type0$TYPE0symbol$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0symbol$con(out, _) = fprint(out, "TYPE0symbol")
implement{}
fprint_type0$TYPE0symbol$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0symbol$rpar(out, _) = fprint_type0$rpar(out)
implement{}
fprint_type0$TYPE0symbol$arg1(out, arg0) =
  let val-TYPE0symbol(arg1) = arg0 in fprint_type0$carg(out, arg1) end
//
extern
fun{}
fprint_type0$TYPE0datatype$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0datatype$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0datatype$rpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0datatype$arg1: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0datatype(out, arg0) = 
{
//
val () = fprint_type0$TYPE0datatype$con<>(out, arg0)
val () = fprint_type0$TYPE0datatype$lpar<>(out, arg0)
val () = fprint_type0$TYPE0datatype$arg1<>(out, arg0)
val () = fprint_type0$TYPE0datatype$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0datatype$con(out, _) = fprint(out, "TYPE0datatype")
implement{}
fprint_type0$TYPE0datatype$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0datatype$rpar(out, _) = fprint_type0$rpar(out)
implement{}
fprint_type0$TYPE0datatype$arg1(out, arg0) =
  let val-TYPE0datatype(arg1) = arg0 in fprint_type0$carg(out, arg1) end
//
extern
fun{}
fprint_type0$TYPE0ignored$con: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ignored$lpar: $d2ctype(fprint_type0<>)
extern
fun{}
fprint_type0$TYPE0ignored$rpar: $d2ctype(fprint_type0<>)
//
implement{}
fprint_type0$TYPE0ignored(out, arg0) = 
{
//
val () = fprint_type0$TYPE0ignored$con<>(out, arg0)
val () = fprint_type0$TYPE0ignored$lpar<>(out, arg0)
val () = fprint_type0$TYPE0ignored$rpar<>(out, arg0)
//
}
implement{}
fprint_type0$TYPE0ignored$con(out, _) = fprint(out, "TYPE0ignored")
implement{}
fprint_type0$TYPE0ignored$lpar(out, _) = fprint_type0$lpar(out)
implement{}
fprint_type0$TYPE0ignored$rpar(out, _) = fprint_type0$rpar(out)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_type0
  (arg0) =
(
case+ arg0 of
| TYPE0int _ => "TYPE0int"
| TYPE0char _ => "TYPE0char"
| TYPE0bool _ => "TYPE0bool"
| TYPE0unit _ => "TYPE0unit"
| TYPE0fun _ => "TYPE0fun"
| TYPE0ref _ => "TYPE0ref"
| TYPE0symbol _ => "TYPE0symbol"
| TYPE0datatype _ => "TYPE0datatype"
| TYPE0ignored _ => "TYPE0ignored"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_i0exp
  (arg0) =
(
case+ arg0 of
| EXP0int _ => "EXP0int"
| EXP0i0nt _ => "EXP0i0nt"
| EXP0string _ => "EXP0string"
| EXP0var _ => "EXP0var"
| EXP0app _ => "EXP0app"
| EXP0extfcall _ => "EXP0extfcall"
| EXP0lambody _ => "EXP0lambody"
)
//
(* ****** ****** *)
(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_i0ins
  (arg0) =
(
case+ arg0 of
| INS0decl _ => "INS0decl"
| INS0assign _ => "INS0assign"
| INS0label _ => "INS0label"
| INS0return _ => "INS0return"
| INS0ifbranch _ => "INS0ifbranch"
| INS0random _ => "INS0random"
| INS0goto _ => "INS0goto"
| INS0init_loop _ => "INS0init_loop"
| INS0tail_jump _ => "INS0tail_jump"
)
//
(* ****** ****** *)
