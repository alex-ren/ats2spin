

// ============================
// Manually written

bit turn = 0;
bool flag[2] = false;

byte critical = 0;

#define get_other_party(ats_pid) (1 - ats_pid)

#define flag_get(ats_pid) flag[ats_pid]

inline flag_set(ats_pid, i) {
  flag[ats_pid] = i;
}

#define turn_get() turn

inline turn_set(ats_pid) {
  turn = 1 - ats_pid;
}


// ============================
// Generated

inline user_loop (clo_arg_i, clo_arg_pid) {
  skip;
user_loop_beg:
  flag_set(clo_arg_pid, true);
  turn_set(clo_arg_pid);
  if
  :: !flag_get(get_other_party(clo_arg_pid)) ->
        turn_set(get_other_party(clo_arg_pid));
  :: else
  fi
  clo_arg_pid == turn_get();
  //
  // This is a critical section
  critical++;
  assert(critical < 2);
  critical--;
  //
  flag_set(clo_arg_pid, false);
  goto user_loop_beg;
}

active [2] proctype user() {
  int ats_pid = _pid;  // Promela$mypid() => _pid
  int i = ats_pid;
  assert((i == 0) + (i == 1));

  user_loop(i, ats_pid);
}

