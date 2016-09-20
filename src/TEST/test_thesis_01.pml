
proctype foo (int x) {
  int counter = 0;
  int sum = 0;
  loop:
  sum = sum + counter;
  counter = counter + 1;
  if
  :: counter > x -> skip
  :: else -> goto loop
  fi
  printf("sum is %d\n", sum)
}

init {
atomic {
  run foo (4)
}
}

