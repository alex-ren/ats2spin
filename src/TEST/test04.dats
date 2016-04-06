

case RANDOM of
| _ => let
   val x = 
   val y =
   val () = guard_assert (x > y && y > 3)
   in ... end
| _ => let
  val msg = chan_recv (ch)
in
  case+ msg of
  | DENY () =>
  | ACCEPT (x, y) =>

? todo how to express block receive for certain message

