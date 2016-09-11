

// Header in Promela

#define get_pid() (_pid - 1)

#define int2pid(x) x
#define pid2int(x) x

#define atsbool_true true
#define atsbool_false false


// End of header


bool turn, flag[2];

#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n

int g_lock = 0;

#define vlock_acquire(_) \
d_step { \
assert(g_lock == 0); \
g_lock = 1; \
}

#define vlock_release(_) \
g_lock = 0



inline loop_7(i_25, j_24) {
  pid i_8;
  pid j_9;
  int lock_17;
  pid i_27;
  pid j_28;
  i_8 = i_25;
  j_9 = j_24;
  loop_26:
  flag_set(i_8, atsbool_true);
  turn_set(j_9);
  ((flag_get(j_9)) == (atsbool_false)) + ((i_8) == (turn_get()));
  printf("pid: %d \n", i_8);
  vlock_acquire(lock_17);
  vlock_release(lock_17);
  flag_set(i_8, atsbool_false);
  i_27 = i_8;
  j_28 = j_9;
  i_8 = i_27;
  j_9 = j_28;
  goto loop_26
}
proctype proc_0() {
  pid i_1;
  pid j_5;
  i_1 = get_pid();
  assert(((i_1) == (int2pid(0))) + ((i_1) == (int2pid(1))));
  j_5 = int2pid((1) - (pid2int(i_1)));
  loop_7(i_1, j_5)
}
init {
atomic {
  pid pid1_21;
  pid pid2_23;
  pid1_21 = run proc_0();
  pid2_23 = run proc_0()
}
}

