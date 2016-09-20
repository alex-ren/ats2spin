staload "./Promela.sats"


fun proctype$foo (x: int): void = let
  var count: int = 0
  var sum: int = 0
  fun inline$loop (c: &int, s: &int): void = let
    val () = s := s + c
    val () = c := c + 1
  in
    if c > x then ()
    else inline$loop (c, s)
  end
  val () = inline$loop (count, sum)
  val () = $extfcall (void, "printf", "sum is %d\\n", sum)
  val () = pml$assert0 (sum = 10)
in
end

fun pml$init (): void = let
  val _ = pml$run (proctype$foo (4))
in end


