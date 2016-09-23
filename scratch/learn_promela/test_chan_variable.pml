

proctype foo (int x) {
  chan ch = [2] of {int};
  // chan ch = [x] of {int};  // cannot use variable to define the type of channels
  x = 4;
}

init {
  run foo(3)
}



