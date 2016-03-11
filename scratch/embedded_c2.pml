
int x = 0;

active proctype P() {
  c_code { y = 478; printf("xxxxxxxxxxxx\n"); };
  x = 3;
  printf("yyyyyyyyyyyy x is %d\n", x);
  x = 478;
  printf("yyyyyyyyyyyy x is %d\n", x);
  assert(false);
}

