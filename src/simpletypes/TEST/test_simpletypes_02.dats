
fun fact (x: int, accu: int): int = 
  if (x > 0) then fact (x - 1, accu * x)
  else 1

fun foo (): void = let
  val x = 3
  val ret = fact (3, 1)
in end


