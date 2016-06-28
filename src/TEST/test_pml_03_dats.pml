

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

proctype foo_0(int x_1; int y_2) {
  int v1_3;
  int v2_4;
  v1_3 = (x_1) + (y_2);
  v2_4 = (x_1) - (y_2);
  printf("x is %d", 3)
}
init {
atomic {
  run foo_0(1, 2)
}
}

