
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
1. `test_pml_01.dats`
    This file is for testing generating proctype.
2. `test_pml_02.dats`
    This file is for testing the usage of starting new processes in the init.
3. `test_pml_03.dats`
    This file is for testing the usage of extfcall.
4. `test_pml_04.dats`
    This file is for testing the inclusion of Promela code in ATS.
5. `test_pml_05.dats`
    This file is for testing invoking functions defined in Promela.
6. `test_pml_06.dats`
    This file is for testing the invocation of inline functions.
7. `test_pml_07.dats`
    This file is for testing the usage of call by reference.
8. `test_pml_08.dats`
    This file is for testing recursive inline function.
9. `test_pml_09.dats`
    This file is for testing mutually recursive inline functions.
10. `test_pml_10.dats`
    This file is for testing the usage of "if" branch
11. `test_pml_11.dats`
    This file is for testing the blocking guard.
12. `test_pml_12.dats`
    This file is for testing the usage of pid.
13. `test_pml_13.dats`
    This file is for testing the usage of assert
14. `test_pml_14.dats`
    This file is for testing the usage of operators
15. `test_pml_15.dats`
    This file is for testing the usage of call by reference and recursive function.
16. `test_pml_16.dats`
    This file is for testing the usage of "case RANDOM".

