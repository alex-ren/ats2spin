
// Header in Promela

#define get_pid() _pid

// End of header

init {
  int x_1;
  int x_3;
  int x_5;
  int x_7;
  int y_9;
  x_1 = (1) + (1);
  x_3 = (x_1) - (1);
  x_5 = (x_3) * (1);
  x_7 = (x_5) / (1);
  y_9 = ~(x_7);
  assert((2) > (1));
  assert((2) >= (1));
  assert((1) < (2));
  assert((1) <= (2));
  assert(((2) > (1)) * ((3) > (2)));
  assert(((2) > (1)) + ((3) > (2)));
  assert((3) == (3));
  assert(~((3) == (3)))
}

