inline foo_0(x_1) {
  int y_2;
  y_2 = (x_1) + (1);
  x_1 = ((y_2) * (y_2)) + (1)
}
init {
  int y_6;
  int x_7;
  x_7 = 2;
  printf("old x is %d", x_7);
  foo_0(x_7);
  printf("new x is %d", x_7)
}

