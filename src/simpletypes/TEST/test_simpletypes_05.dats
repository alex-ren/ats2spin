

datatype mylist (a: t@ype+) =
| mycons of (a, mylist a)
| mynil of ()

fun {a:t@ype} foo (xs: mylist a): int =
case+ xs of
| mycons (x, xs1) => 1
| mynil () => 0

