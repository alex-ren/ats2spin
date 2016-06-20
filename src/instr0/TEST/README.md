
Spin Commands
------------------------------
The followings are some commands ispin uses to do simulation and verification.

1. Simulation

    ```Bash
    spin -p -s -r -X -v -n123 -l -g -u10000 temp.pml
    ```
2. Verification

    ```Bash
    spin -a  temp.pml
    gcc -DMEMLIM=1024 -O2 -DXUSAFE -DSAFETY -DNOCLAIM -w -o pan pan.c
    ./pan -m10000
    ```
Description of Test Files
--------------------------------------
1. `test_instr0_01.dats`
    This file is for testing generating proctype.
2. `test_instr0_02.dats`
    This file is for testing the usage of starting new processes in the init.
3. `test_instr0_03.dats`
    This file is for testing the usage of extfcall.
4. `test_instr0_04.dats`
    This file is for testing the inclusion of Promela code in ATS.
5. `test_instr0_05.dats`
    This file is for testing invoking functions defined in Promela.
6. `test_instr0_06.dats`
    This file is for testing the invocation of inline functions.
7. `test_instr0_07.dats`
    This file is for testing the usage of call by reference.
8. `test_instr0_08.dats`
    This file is for testing recursive inline function.
9. `test_instr0_09.dats`
    This file is for testing mutually recursive inline functions.
10. `test_instr0_10.dats`
    This file is for testing the usage of "if" branch
11. `test_instr0_11.dats`
    This file is for testing the blocking guard.
12. `test_instr0_12.dats`
    This file is for testing the usage of pid.
13. `test_instr0_13.dats`
    This file is for testing the usage of assert
14. `test_instr0_14.dats`
    This file is for testing the usage of operators
15. `test_instr0_15.dats`
    This file is for testing the usage of call by reference and recursive function.
16. `test_instr0_16.dats`
    This file is for testing the usage of "case RANDOM".
17. `test_instr0_17.dats`
    This file is for testing the usage of "case RANDOM" with tail call.
18. `test_instr0_18.dats`
    This file is for testing the usage of "case" expression with datatype.
19. `test_instr0_19.dats`
    This file is for testing the usage of abstract types.

