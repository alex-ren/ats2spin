

fun fact (x: int, accu: int): int =
  if x = 0 then accu
  else fact (accu * x, x - 1)

fun fact1 (x: int, accu: int): int =
  if x = 0 then accu
  else fact (accu * x, x - 1)

