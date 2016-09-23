
proctype foo() {
  int n = 0;
  do
  :: n <= 3 ->
  chan ch = [1] of {int};
  ch!3;
  n = n + 1;
  :: else -> break
  od
  printf("hello world\n")
}

init {
  run foo()
}


