

fun fact (x: int, accu: int): int =
  if x = 0 then accu
  else fact (accu * x, x - 1)

fun proc_fact (): void = let
  fun loop (): void = let
    val x = 1
    val r = fact (x, 0)
  in
    loop ()
  end
in end

  
