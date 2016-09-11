
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


