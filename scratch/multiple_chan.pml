
active proctype foo() {
  int x = 0;
     x = x + 1;
  chan ch = [1] of {int};

  do
  :: x < 5 -> 
     ch ! 1;
  :: else -> break;
  od
}

