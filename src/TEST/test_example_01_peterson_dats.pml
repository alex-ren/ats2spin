

 ========= Hello from ATS2PML! =============


## ======== preprocessed content ==============================

D2Cextcode(

// Header in Promela

#define get_pid() _pid

#define int2pid(x) x
#define pid2int(x) x


// End of header
)


## ======== level postiats ==============================

D2Cextcode(

// Header in Promela

#define get_pid() _pid

#define int2pid(x) x
#define pid2int(x) x


// End of header
)
, D2Cignored(), D2Cignored(), D2Cignored(), D2Cextcode(

bool turn, flag[2];
byte cnt;


#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n
)
, D2Cdcstdecs(
lemma_pid_scope(3062)), D2Cdcstdecs(
flag_get(3063)), D2Cdcstdecs(
flag_set(3064)), D2Cdcstdecs(
turn_get(3065)), D2Cdcstdecs(
turn_set(3066)), D2Cfundecs(
f2undec{d2v= proctype$proc(3868); def= D2Elam(; D2Eexp(D2Elet(D2Cvaldecs(
v2aldec{pat= P2Tvar(i(3869)); def= D2Eapplst(D2Ecst(pml$mypid(3046)); D2EXPARGdyn(-1; ))}
), D2Cvaldecs(
v2aldec{pat= P2Tempty(); def= D2Eapplst(D2Ecst(pml$assert(3047)); D2EXPARGdyn(-1; D2E...(...)))}
), D2Cvaldecs(
v2aldec{pat= P2Tvar(j(3870)); def= D2Eapplst(D2Esym(-); D2EXPARGdyn(-1; D2Ei0nt(1), D2Evar(i(3869))))}
), D2Cfundecs(
f2undec{d2v= inline$loop(3871); def= D2Elam(P2Tpat(P2Tvar(i(3872))), P2Tpat(P2Tvar(j(3873))); D2Eexp(D2Eexp(D2Elet(D2Cvaldecs(
v2aldec{pat= P2Tempty(); def= D2Eapplst(D2Ecst(flag_set(3064)); D2EXPARGdyn(-1; D2Evar(i(3872)), D2Ecst(true_bool(0))))}
), D2Cvaldecs(
v2aldec{pat= P2Tempty(); def= D2Eapplst(D2Ecst(turn_set(3066)); D2EXPARGdyn(-1; D2Evar(i(3872))))}
), D2Cvaldecs(
v2aldec{pat= P2Tempty(); def= D2Eapplst(D2Ecst(pml$wait_until(3048)); D2EXPARGdyn(-1; D2E...(...)))}
), D2Cvaldecs(
v2aldec{pat= P2Tempty(); def= D2Eapplst(D2Ecst(flag_set(3064)); D2EXPARGdyn(-1; D2Evar(i(3872)), D2Ecst(false_bool(1))))}
); D2Eapplst(D2Evar(inline$loop(3871)); D2EXPARGdyn(-1; D2Evar(i(3872)), D2Evar(j(3873)))))))}
); D2Eapplst(D2Evar(inline$loop(3871)); D2EXPARGdyn(-1; D2Evar(i(3869)), D2Evar(j(3870))))))}
)

## ======== transform postiats to instr0 ================



## ======== level instr0 ==============================

DEC0extcode(
// Header in Promela

#define get_pid() _pid

#define int2pid(x) x
#define pid2int(x) x


// End of header
)

DEC0extcode(
bool turn, flag[2];
byte cnt;


#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n
)

DEC0fun(// group contains (inline$loop_9)
fun inline$loop_9(i_10, j_11) {
INS0assign(none,EXP0app(flag_set,EXP0var(i_10), EXP0var(true_bool)))
INS0assign(none,EXP0app(turn_set,EXP0var(i_10)))
INS0assign(none,EXP0app(pml$wait_until,EXP0lambody(EXP0app(+,EXP0app(=,EXP0app(flag_get,EXP0var(j_11)), EXP0var(false_bool)), EXP0app(=,EXP0var(i_10), EXP0app(turn_get,))))))
INS0assign(none,EXP0app(flag_set,EXP0var(i_10), EXP0var(false_bool)))
INS0return(EXP0app(inline$loop_9,EXP0var(i_10), EXP0var(j_11)))
})

DEC0fun(// group contains ()
fun proctype$proc_0() {
INS0decl(i_1,EXP0app(pml$mypid,))
INS0assign(none,EXP0app(pml$assert,EXP0app(+,EXP0app(=,EXP0var(i_1), EXP0app(int2pid,EXP0i0nt(0))), EXP0app(=,EXP0var(i_1), EXP0app(int2pid,EXP0i0nt(1))))))
INS0decl(j_7,EXP0app(-,EXP0i0nt(1), EXP0var(i_1)))
INS0return(EXP0app(inline$loop_9,EXP0var(i_1), EXP0var(j_7)))
})



## ======== level instr0 after tail call optimization =====================

DEC0extcode(
// Header in Promela

#define get_pid() _pid

#define int2pid(x) x
#define pid2int(x) x


// End of header
)

DEC0extcode(
bool turn, flag[2];
byte cnt;


#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n
)

DEC0fun(// group contains (inline$loop_9)
fun inline$loop_9(i_20, j_19) {
INS0init_loop(i_10, j_11,(i_10, i_20), (j_11, j_19))
INS0label(loop_21)
INS0assign(none,EXP0app(flag_set,EXP0var(i_10), EXP0var(true_bool)))
INS0assign(none,EXP0app(turn_set,EXP0var(i_10)))
INS0assign(none,EXP0app(pml$wait_until,EXP0lambody(EXP0app(+,EXP0app(=,EXP0app(flag_get,EXP0var(j_11)), EXP0var(false_bool)), EXP0app(=,EXP0var(i_10), EXP0app(turn_get,))))))
INS0assign(none,EXP0app(flag_set,EXP0var(i_10), EXP0var(false_bool)))
INS0tail_jump(
{
INS0decl(i_22,EXP0var(i_10))
INS0decl(j_23,EXP0var(j_11))
INS0assign(EXP0var(i_10),EXP0var(i_22))
INS0assign(EXP0var(j_11),EXP0var(j_23))
},
loop_21
)
})

DEC0fun(// group contains ()
fun proctype$proc_0() {
INS0decl(i_1,EXP0app(pml$mypid,))
INS0assign(none,EXP0app(pml$assert,EXP0app(+,EXP0app(=,EXP0var(i_1), EXP0app(int2pid,EXP0i0nt(0))), EXP0app(=,EXP0var(i_1), EXP0app(int2pid,EXP0i0nt(1))))))
INS0decl(j_7,EXP0app(-,EXP0i0nt(1), EXP0var(i_1)))
INS0return(EXP0app(inline$loop_9,EXP0var(i_1), EXP0var(j_7)))
})



## ======== level instr0 after declarations movement =====================

DEC0extcode(
// Header in Promela

#define get_pid() _pid

#define int2pid(x) x
#define pid2int(x) x


// End of header
)

DEC0extcode(
bool turn, flag[2];
byte cnt;


#define flag_get(n) flag[n]

#define flag_set(n, b) \
flag[n] = b

#define turn_get() turn

#define turn_set(n) \
turn = n
)

DEC0fun(// group contains (inline$loop_9)
fun inline$loop_9(i_20, j_19) {
INS0decl(i_10,none)
INS0decl(j_11,none)
INS0decl(i_22,none)
INS0decl(j_23,none)
INS0assign(EXP0var(i_10),EXP0var(i_20))
INS0assign(EXP0var(j_11),EXP0var(j_19))
INS0label(loop_21)
INS0assign(none,EXP0app(flag_set,EXP0var(i_10), EXP0var(true_bool)))
INS0assign(none,EXP0app(turn_set,EXP0var(i_10)))
INS0assign(none,EXP0app(pml$wait_until,EXP0lambody(EXP0app(+,EXP0app(=,EXP0app(flag_get,EXP0var(j_11)), EXP0var(false_bool)), EXP0app(=,EXP0var(i_10), EXP0app(turn_get,))))))
INS0assign(none,EXP0app(flag_set,EXP0var(i_10), EXP0var(false_bool)))
INS0tail_jump(
{
INS0assign(EXP0var(i_22),EXP0var(i_10))
INS0assign(EXP0var(j_23),EXP0var(j_11))
INS0assign(EXP0var(i_10),EXP0var(i_22))
INS0assign(EXP0var(j_11),EXP0var(j_23))
},
loop_21
)
})

DEC0fun(// group contains ()
fun proctype$proc_0() {
INS0decl(i_1,none)
INS0decl(j_7,none)
INS0assign(EXP0var(i_1),EXP0app(pml$mypid,))
INS0assign(none,EXP0app(pml$assert,EXP0app(+,EXP0app(=,EXP0var(i_1), EXP0app(int2pid,EXP0i0nt(0))), EXP0app(=,EXP0var(i_1), EXP0app(int2pid,EXP0i0nt(1))))))
INS0assign(EXP0var(j_7),EXP0app(-,EXP0i0nt(1), EXP0var(i_1)))
INS0return(EXP0app(inline$loop_9,EXP0var(i_1), EXP0var(j_7)))
})

