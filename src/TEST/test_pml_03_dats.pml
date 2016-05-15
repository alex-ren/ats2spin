
// Header in Promela

#define get_pid() _pid

// End of header

proctype foo_0(int x_1; int y_2) {
  int v1_3;
  int v2_5;
  v1_3 = (x_1) + (y_2);
  v2_5 = (x_1) - (y_2);
  printf("x is %d", 3)
}
init {
  run foo_0(1, 2)
}

