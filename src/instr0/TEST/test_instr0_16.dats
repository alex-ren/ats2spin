

/*
* This file is for testing the usage of "case RANDOM".
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

fun inline$foo (): void = let
  val x = 1
in
  case+ RANDOM of
  | 0 => let
    val () = pml$wait_until (lam () => false)
    val () = $extfcall (void, "printf", "this is branch 1\\n")
  in end
  | 1 => let
    val y = 3
    val () = $extfcall (void, "printf", "this is branch 2\\n")
  in end
  | _ => let
    val () = pml$wait_until (lam () => true)
    val () = $extfcall (void, "printf", "this is branch else\\n")
  in end
end

fun inline$foo2 (): void = let
  val x = 1
in
  case+ RANDOM of
  | 0 => let
    val () = pml$wait_until (lam () => false)
    val () = $extfcall (void, "printf", "this is branch 1\\n")
  in end
  | 1 => let
    val () = pml$wait_until (lam () => true)
    val () = $extfcall (void, "printf", "this is branch 2\\n")
  in end
end

fun proctype$foo (): void = inline$foo ()
fun proctype$foo2 (): void = inline$foo2 ()

fun pml$init (): void = let
  val _ = pml$run (proctype$foo ())
  val _ = pml$run (proctype$foo2 ())
in end


//// extern fun check {x,y:int} (x: int x, y: int y): bool (x <> y)
//// 
//// // Won't type check
//// // fun inline$foo {x:int} (x: int x): void = let
//// // in
//// //   case (RANDOM) of
//// //   | _ when check (x, 1) => let
//// //     prval () = (): [x <> 1] void
//// //   in end
//// //   | _ when check (x, 2) => let
//// //     prval () = (): [x <> 2] void
//// //   in end
//// //   | _ => let
//// //     prval () = (): [x <> 1 && x <> 2] void
//// //   in end
//// // end
//// 
//// // Too verbose
//// fun inline$foo {x:int} (x: int x): void = let
//// in
////   case+ (RANDOM) of
////   | _ when check (x, 1) => let
////     prval () = (): [x <> 1] void
////   in end
////   | _ when check (x, 2) => let
////     prval () = (): [x <> 2] void
////   in end
////   | _  => let
////     // prval () = (): [x <> 1 && x <> 2] void
////   in end
//// end
//// 
//// 
//// extern fun channel1_ready (x: &int? >> opt (int, b)): #[b:bool] bool b
//// extern fun channel2_ready (x: &int? >> opt (int, b)): #[b:bool] bool b
//// 
//// fun inline$foo (): void = let
////   var x: int?
////   var y: int?
//// in
////   case+ (RANDOM) of
////   | _ when channel1_ready (x) => let
////     val () = $extfcall (void, "printf", "channel1 is ready \\n")
////     prval () = opt_unsome (x)
////   in end
////   | _ when channel2_ready (x) => let
////     val () = $extfcall (void, "printf", "channel2 is ready \\n")
////     prval () = opt_unsome (x)
////   in end
////   | _ => let
////     val () = $extfcall (void, "printf", "no channel is ready \\n")
////   in end
//// end


// fun inline$foo (): void = let
//   var x: int?
//   var y: int?
// in
//   (case (RANDOM) of
//   | 1 => 
//   (if channel1_ready (x) then let
//     val () = $extfcall (void, "printf", "channel1 is ready \\n")
//     prval () = opt_unsome (x)
//   in end else let
//     prval () = opt_unnone (x)
//   in end
//   ): void
//   | 2 => 
//   (if channel2_ready (x) then let
//     val () = $extfcall (void, "printf", "channel2 is ready \\n")
//     prval () = opt_unsome (x)
//   in end else let
//     prval () = opt_unnone (x)
//   in end
//   ): void
//   | 3 => 
//   (if (~channel1_ready(x)) * (~channel2_ready(y)) then let
//     val () = $extfcall (void, "printf", "no channel is ready \\n")
//     prval () = opt_unnone (x)
//     prval () = opt_unnone (y)
//   in end else ...
//   ): void
//   ): void
// end

////

fun
foo{i:nat}
  (x: int(i), y: int(i+1)): void = ()
//
(* ****** ****** *)

implement
main0 () = () where
{
//
var x: int
var y: int
//
val i = (0: intGte(0))
//
val () = (
//
case: [i:nat]
(
  x: int(i), y: int(i+1)
) => (i >= 1) of
  true => (x := i; y := x+1)
| false => (x := 10; y := 11)
//
) : void // end of [val]
//
val () = foo(x, y)
//
val () = println! ("x = ", x, " and y = ", y)
//
} (* end of [main0] *)

