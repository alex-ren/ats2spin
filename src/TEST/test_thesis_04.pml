active proctype foo() {
  chan ch = [1] of {int};
  int x;
  ch!5;
  ch?x;
  printf("x is %d\n", x);
}


active proctype foo1() {
  chan ch = [1] of {int};
  int y = 1 + 2;
  ch!1;
  ch?1;
  ch!6;
  ch?eval(y + 3);
  printf("end\n")
}

