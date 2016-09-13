

proctype foo() {
  printf("hello world\n");
}

init {
  printf("init 00\n");
  int x; 
  printf("init 01\n");
  pid y;
  y = 1 + (run foo()) - 1;
  printf("init 02 y is %d\n", y);
}


