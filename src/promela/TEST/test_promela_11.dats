

/*
* This file is for testing the blocking guard.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

%{
int g = 0;

#define g_get() g

inline g_set(x) {
  g = x;
}
%}

extern fun g_get (): int = "ext#g_get"
extern fun g_set (x: int): void = "ext#g_set"

fun proctype$foo1 (x: int): void = let
  val () = $extfcall (void, "printf", "g is %d in foo1", g_get())
  val y = g_get()
  val () = g_set (x + y)
in end

fun proctype$foo2 (): void = let
  val x = 3
  val () = pml$wait_until (lam () => x + g_get () > 0)
  val () = $extfcall (void, "printf", "g is %d in foo2", g_get())
in end

fun pml$init (): void = let
  val pid1 = pml$run (proctype$foo1 (1))
  val pid2 = pml$run (proctype$foo2 ())
in end


