
(*
* This file is for testing type change due to reference type.
*)


extern fun foo1 (a: int, x: &int >> char): void
extern fun foo2 (a: int, x: &char >> int): void
extern fun foo3 (a: int, x: &int >> char): void
extern fun foo4 (x: &int): void

fun test ():void = let
  var x: int = 0
  val () = foo1 (1, x)
  val () = foo2 (2, x)
in end

extern fun test2 (a: int, x: &int >> char): void
implement test2 (a, x) = let
  val () = foo3 (a, x)
  val () = foo2 (a, x)
  val () = foo1 (a, x)
in end

fun test3 (a: int, b: int, x: &int >> char): void = foo3 (a, x)
