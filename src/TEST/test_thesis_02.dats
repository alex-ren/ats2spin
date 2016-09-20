staload "./Promela.sats"

fun proctype$foo (n: int): void = let
  var x: int = 0
  var y: int = 0

  fun inline$incx (x1: &int, y1: &int): void =
  if x1 > n then () 
  else let
    val () = x1 := x1 + 1
    // val () = inline$incy (x1, y1)
  in 
    inline$incy (x1, y1)
  end
  and inline$incy (x2: &int, y2: &int): void = let
    val () = y2 := y2 + 1
  in
    inline$incx (x2, y2)
  end

  val () = inline$incx (x, y)
  val () = $extfcall (void, "printf", "x is %d\\n", x)
  val () = $extfcall (void, "printf", "y is %d\\n", y)
in end

fun pml$init (): void = let
  val _ = pml$run (proctype$foo (100))
in end

