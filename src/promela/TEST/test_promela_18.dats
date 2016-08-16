/*
* This file is for testing the usage of "case" expression with datatype.
*
*/
datatype message =
| START of (int, char)
| END of (int, int)

fun inline$foo (m: message, x: &int): void =
case+ m of
| START (x0, y0) => let val () = x := x0 in end
| END (x0, y0) => let val () = x := y0 in end

// extern fun inline$recv {a:t@ype} (ch: int): a
// 
// fun foo1 (ch: int): int = let
//   val m = recv (ch)
//   val ret = foo (m)
// in
//   0
// end

// fun inline$foo (): void = let
// in
//   case+ RANDOM of
//   | 0 => let
//     val- START (x) = recv_msg (ch)





