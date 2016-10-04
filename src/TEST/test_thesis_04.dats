
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

abstype chanref(a:vt@ype) = pml$chan

extern fun {a:vt@ype} pml$chan_create$chanref (n: int): chanref(a)
extern fun {a:vt@ype} pml$chan_send$chanref (chanref(a), a): void
extern fun {a:vt@ype} pml$chan_recv$chanref (chanref(a)): a

abstype chanrecur = pml$chan

extern fun pml$chan_create$chanrecur (n: int): chanrecur
extern fun pml$chan_send$chanrecur (chanrecur, chanrecur): void
extern fun pml$chan_recv$chanrecur (chanrecur): chanrecur

