
staload "./Promela.sats"

fun pml$init (): void = let
  val x = 1
  val () = pml$assert (x = 1)
in end

