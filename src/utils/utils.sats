
fun mystring_append (s1: string, s2: string): string
overload + with mystring_append

exception not_supported of string


macdef exitlocmsg(m) = exit_errmsg (1, ,(m) + "\n" + $mylocation)

