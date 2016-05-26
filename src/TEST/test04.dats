

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
  | DENY (x, y) => assert (x = 3)
  | ACCEPT (x, y) =>

? todo how to express block receive for certain message



(ch1 >> ch2): message

block receive
  val pattern = recv$xxxx


  val () = 
  case RANDOM of 
  | _ => let
    val ~pattern = recv$xxx (ch)
  in
  end
  | _ => let
    val () = guard$ (lam () => exp1)
  | _ => let
    val () = send$xxx (ch, exp)




