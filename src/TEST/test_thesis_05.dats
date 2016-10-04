
staload "./Promela.sats"

fun proctype$foo () = let
  val arr = pml$array_create$<int>(2, 1)
  val () = pml$array_set$ (arr, 1, 3)
  val ele = pml$array_get${int} (arr, 0)
in end

abstype arrayref (a:vt@ype) = pml$array

extern fun {a: vt@ype} pml$array_create$arrayref (
  int, ele: a): arrayref (a)
extern fun pml$array_get$arrayref {a: vt@ype} (
  arr: arrayref a, n: int): a
extern fun pml$array_set$ {a: vt@ype} (
  arr: arrayref a, n: int, ele: a): void

