

datatype mytype0 =
| mycon0 of (int, char)
| mynil0 of ()

datatype mytype (a: t@ype+, b: type) =
| mycons of (a, b, mytype0)
| mynil of ()


fun {a:t@ype} {b:type} foo (xs: mytype (a, b)): int =
case+ xs of
| mycons (x, y, xs1) => 1
| mynil () => 0

