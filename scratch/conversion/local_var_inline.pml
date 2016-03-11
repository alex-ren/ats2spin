/*
 * From the following example, it seems that the definition of local variable
 * inside an inline function conflicts with those defined before the invocation
 * of the inline function, and it has no effect after the invocation of the
 * inline function.
 */

int y;

inline foo() {
  int x = 3;
}

inline goo() {
  do
  :: y = 1;
     do
     :: true -> 
     // int x = 4; // This conflicts with the definition in foo.
     foo();
     foo();  // This is fine.
     // x = 4;  // The definition in foo is not visible here.
     int x = 4;
     od
  od
}



active proctype proc1() {
  goo();
}


