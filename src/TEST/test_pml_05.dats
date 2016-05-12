
/*
* This file is for testing invoking functions defined in Promela.
*
*/
#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "./Promela.sats"

%{
int g = 3;
int g2 = 4;
#define pml_get_g() g + 1
inline pml_set_g(x) {
  g = x;
}
%}

extern fun get_g (): int = "ext#pml_get_g"
// extern inline function must return void type
extern fun set_g (x: int): void = "ext#pml_set_g"

extern fun foo (): void

fun pml$init (): void = let
  val x = get_g ()
  val y = x + 1
  val () = set_g (y)
in 
end




