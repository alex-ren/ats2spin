
// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header

init {
atomic {
  int x_1;
  int x_2;
  int x_3;
  int x_4;
  int y_5;
  x_1 = (1) + (1);
  x_2 = (x_1) - (1);
  x_3 = (x_2) * (1);
  x_4 = (x_3) / (1);
  y_5 = ~(x_4);
  assert((2) > (1));
  assert((2) >= (1));
  assert((1) < (2));
  assert((1) <= (2));
  assert(((2) > (1)) * ((3) > (2)));
  assert(((2) > (1)) + ((3) > (2)));
  assert((3) == (3));
  assert(~((3) == (3)))
}
}

