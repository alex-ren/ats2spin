proctype foo_0(int x_1; int y_2) {
  int v1_3 = (x_1) + (y_2);
  int v2_5 = (x_1) - (y_2);
  printf("v1 is %d", v1_3)
}
init {
  int x_13 = 1;
  int y_14 = run foo_0(1, x_13);
  run foo1_7(1, y_14)
}
proctype foo1_7(int x_8; int y_9) {
  int v1_10 = (x_8) + (y_9);
  int v2_11 = (x_8) - (y_9);
  printf("v1 is %d", v1_10)
}

