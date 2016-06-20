
datatype message =
| START of (int)
| END of (int, int)

fun foo (m: message): int =
case+ m of
| START (x) => x
| END (x, y) => y






