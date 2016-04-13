int g = 0;

#define goo(x, y) \
  int v = x + y; \
  g = v;

inline foo(x, y) {
  int v = x + y;
  g = v;
  
}

proctype P() {
  foo(1, 2);
  foo(2, 3);
  goo(4, 5);
}


inline foo1(x, y) {
  int c = 0;
target3:
  if
  :: c > 3 -> skip;
  :: else -> printf("c is %d\n", c); c = c + 1; goto target3;
  fi
}

proctype P1(int x; int y) {

target3:
  printf("target3 in P1\n");

foo1(x, 4);

// foo1(x, 4);



  

}

init {
  g = 0;

  atomic {
    run P1(1, 2);
  }
}



