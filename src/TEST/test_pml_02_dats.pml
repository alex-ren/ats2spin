
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
  printf("v1 is %d", v1_3)
}
proctype foo1_5(int x_6; int y_7) {
  int v1_8;
  int v2_9;
  v1_8 = (x_6) + (y_7);
  v2_9 = (x_6) - (y_7);
  printf("v1 is %d", v1_8)
}
init {
atomic {
  int x_11;
  pid y_12;
  x_11 = 1;
  y_12 = run foo_0(1, x_11);
  run foo1_5(1, 2)
}
}

