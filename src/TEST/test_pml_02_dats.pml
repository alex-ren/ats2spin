
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

proctype foo_0(int x_1; int y_2) {
  int v1_3;
  int v2_5;
  v1_3 = (x_1) + (y_2);
  v2_5 = (x_1) - (y_2);
  printf("v1 is %d", v1_3)
}
proctype foo1_7(int x_8; int y_9) {
  int v1_10;
  int v2_11;
  v1_10 = (x_8) + (y_9);
  v2_11 = (x_8) - (y_9);
  printf("v1 is %d", v1_10)
}
init {
atomic {
  int x_13;
  int y_14;
  x_13 = 1;
  y_14 = run foo_0(1, x_13);
  run foo1_7(1, y_14)
}
}

