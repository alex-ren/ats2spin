
int x = 0;
int y = 1;

// Bad
// active proctype foo1() {
// do
//   :: atomic {
//   if
//   :: x == 3 -> break;
//   :: else -> x = x + 1;
//   fi
// od  // Error: syntax error saw 'keyword: od' near 'od'
// }
// }
  
// Good
// active proctype foo2() {
// do
//   :: atomic {
//   if
//   :: x == 3 -> break;
//   :: else -> x = x + 1;
//   fi
// }
// od
// }

// Good: "while loop" in atomic
// active proctype foo3() {
// atomic {
// do 
//   :: 
//   if
//   :: x == 3 -> break;
//   :: else -> x = x + 1;
//   fi
// od
// }
// }

// Bad: label inside atomic
// active proctype foo4() {
// atomic {
// int y = 1;
// loop:
//   if
//   :: x <= 3 -> x = x + 1;  goto loop;
//   :: else -> skip;
//   fi
// y = y + 1;
// }
// }

// Good: Embedded atomic.
active proctype foo5() {
atomic {x = 1; atomic { x= 2;}}
}


active proctype checker() {
  assert(x != 2);
}




