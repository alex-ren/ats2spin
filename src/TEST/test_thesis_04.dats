
staload "./Promela.sats"

fun proctype$foo () = let
  val ch = pml$chan_create$<int>(1)
  val () = pml$chan_send$<int>(ch, 5)
in
  case pml$chan_recv$<int> (ch) of
  | x => let
  val () = $extfcall (void, "printf", "x is %d\\n", x)
  in end
end

fun proctype$foo () = let
  val ch = pml$chan_create$<int>(1)
  val y = 1 + 2
  val () = pml$chan_send$<int>(ch, 1)
in
  case- pml$chan_recv$<int> (ch) of
  | 1 => let
  val () = pml$chan_send$<int>(ch, 6)
  in
  case- pml$chan_recv$<int> (ch) of
  | x when x = y + 3 => let
  val () = $extfcall (void, "printf", "end\\n")
  in end
  end
end

// abstype chanx
// 
// extern fun chanx_create {a:t@ype} (n: int): chanx
// extern fun chanx_read (ch: chanx): @(chanx, int)
// 
// val ch = chanx_create {@(chanx, int)} (3): chanx
// 
// 
// abstype chan(a:t@ype)
// 
// typedef chanr = chan (@(x, int))
// 
// 
// extern fun chanx_read {a:t@ype} (ch: chan a): a
// 
// typedef chanb (b:t@ype) = chan(b)
// 
// typedef chanx (x:t@ype) = chan (chanb (x))
// 
// typedef a = (int, b)
// and b = int



////


typedef chana = chan (chana)

