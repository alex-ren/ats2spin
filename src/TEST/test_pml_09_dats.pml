inline foo2_1(x_12, y_11) {
  int x_2;
  int y_3;
  int x_6;
  int y_7;
  int y_8;
  int x_15;
  int y_16;
  int x_4;
  int x_17;
  int y_18;
  x_6 = x_12;
  y_7 = y_11;
  foo2_14:
  y_8 = (y_7) + (1);
  printf("y is %d", y_8);
  x_15 = x_6;
  y_16 = y_8;
  x_2 = x_15;
  y_3 = y_16;
  goto foo1_13;
  foo1_13:
  x_4 = (x_2) + (1);
  printf("x is %d", x_4);
  x_17 = x_4;
  y_18 = y_3;
  x_6 = x_17;
  y_7 = y_18;
  goto foo2_14
}
inline foo1_0(x_20, y_19) {
  int x_2;
  int y_3;
  int x_6;
  int y_7;
  int x_4;
  int x_23;
  int y_24;
  int y_8;
  int x_25;
  int y_26;
  x_2 = x_20;
  y_3 = y_19;
  foo1_21:
  x_4 = (x_2) + (1);
  printf("x is %d", x_4);
  x_23 = x_4;
  y_24 = y_3;
  x_6 = x_23;
  y_7 = y_24;
  goto foo2_22;
  foo2_22:
  y_8 = (y_7) + (1);
  printf("y is %d", y_8);
  x_25 = x_6;
  y_26 = y_8;
  x_2 = x_25;
  y_3 = y_26;
  goto foo1_21
}
init {
  int x_10;
  x_10 = 1;
  foo1_0(x_10, 1)
}

