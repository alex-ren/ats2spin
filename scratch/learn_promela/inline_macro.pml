int g = 0;

#define goo(x, y) \
  int v = x + y; \
  g = v;

inline foo(x, y) {
  int v = x + y;
  g = v;
  
}

active proctype P() {
  foo(1, 2);
  foo(2, 3);
  goo(4, 5);
}



