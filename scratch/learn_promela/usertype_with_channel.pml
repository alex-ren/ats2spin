

typedef MSG0 {
  int row;
  int col;
}

typedef MSG {
  int row;
  int col;
  MSG0 msg;
}

chan ch = [0] of {int, int, MSG0};

proctype foo () {
  int x;
  int y;
  MSG m;
  MSG n;
  n.row = m.row;
  n.col = m.col;
  // n = m;
  MSG0 m0;
  m.col = 2;
  m0.row = 33;
  m0.col = 44;
  printf ("hello world\n");
  ch?x, eval(m.col), m0;  // caution: can not put "eval" around m0
  printf ("m.col is %d, m0.row is %d, m0.col is %d\n", m.col, m0.row, m0.col);
}

init {
atomic {
  run foo ();
  MSG0 m0;
  m0.row = 33;
  m0.col = 44;
  ch!1, 2, m0;
  printf ("end of init\n")
}
}



