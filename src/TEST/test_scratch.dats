
staload "./Promela.sats"

fun pml$init (): void = let
  val x = 1
  val () = pml$assert (x = 1)
in end

datatype FOO =
| AA of (int, char)
| BB of ()

fun foo (x: FOO): void = let
  val y = 1
  var z = 3
in
  case- x of
  | AA (z, 'c') => ()
  | BB () => ()
end

fun proctype$foo1 (): void = let
  val x = pml$run (pml$wait_until (lam () => true))
in end




