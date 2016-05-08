
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

extern fun pml$print_string (s: string): void
extern fun pml$print_int (i: int): void

fun proctype$foo {x: int} (x: int x, y: int): void = let
  val v1 = x + y
  val v2 = x - y
  val () = pml$print_string ("xx%d")
  val () = pml$print_int (x)
in
end

fun init$main (): void = ()



