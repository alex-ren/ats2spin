
inline foo1(x) {
  x = 3;
  goto hello1;
hello1:
}

proctype foo(int x) {
  x = 3;
  goto hello;
hello:
}

init {
  run foo(3);
  int y;
  foo1(y);
}


