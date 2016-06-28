

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header


int g = 3;
int g2 = 4;

init {
atomic {
  assert((3) > (2))
}
}

