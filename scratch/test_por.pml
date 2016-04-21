
// This file is for experimenting the POR in SPIN model checker.

int g = 0;

inline foo (ret) {
  int xfoo = g;
d_step {
  xfoo = xfoo + 1;
  ret = xfoo;
}
}

active proctype procA() {
    int x = g;
    g = 3;
    foo (x);
}

active proctype procB() {
    int y = g;
    g = 4;
    g = 5;
    g = 5;
}



