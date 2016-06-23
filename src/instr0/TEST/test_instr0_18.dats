
datatype message =
| START of (int, char)
| END of (int, int)

fun foo (m: message): int =
case+ m of
| START (x, y) => x
| END (x, y) => y

extern fun recv {a:t@ype} (ch: int): a

fun foo1 (ch: int): int = let
  val m = recv (ch)
  val ret = foo (m)
in
  0
end






