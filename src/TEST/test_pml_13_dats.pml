

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

init {
atomic {
  int x_1;
  x_1 = 2;
  assert((x_1) > (1))
}
}

