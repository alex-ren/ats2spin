c_decl {
    typedef struct Proc {
        int rlock;
        int state;
        struct Rendez *r;
    } Proc;

    typedef struct Rendez {
        int lck;
        int cond;
        Proc *p;
    } Rendez;
}
c_code {
    Proc H1;
    Proc *up0 = &H1;
    Rendez RR;
}

/*
* The following two c_state declarations presume type
* Rendez known the first enters R1 into state vector
* as a global variable, and the second enters R2 into
* proctype structure as local variable.
*/
c_state "Rendez R1" "Global"
c_state "Rendez R2" "Local ex2" "now.R1"
/*
* The next two c_state declarations are kept outside
* the state vector. They define H1 and up0 as global
* objects, which are declared elsewhere.
*/
c_state "extern Proc H1" "Hidden"
c_state "extern Proc *up0" "Hidden"

/*
* The following declaration defines that RR is to be
* treated as a state variable -- no matter how it was
* declared; it can be an arbitrary external variable.
*/
c_decl {
\#include "types.h" /* declare type Rendez */
/* for the purpose of the backslash, see p. 504 */
}

c_track "&RR" "sizeof(Rendez)"

active proctype ex2()
{
    c_code { now.R1.cond = 1; }; /* global */
    c_code { Pex2->R2.lck = 0; }; /* local */
    c_code { H1.rlock = up0->state; }; /* C */
    
    printf("This is Spin Version 4.0\n")
}



