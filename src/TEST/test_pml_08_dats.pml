
inline foo_0(x_8, y_7) {
  int x_1;
  int y_2;
  int y_3;
  int x_10;
  int y_11;
  x_1 = x_8;
  y_2 = y_7;
  foo_9:
  y_3 = (x_1) + (1);
  printf("y is %d", y_3);
  x_10 = y_3;
  y_11 = x_1;
  x_1 = x_10;
  y_2 = y_11;
  goto foo_9
}
init {
  int x_6;
  x_6 = 1;
  foo_0(x_6, 2)
}

