
int x = 3;

inline modifyx() {
  x = 0;
}

active proctype foo() {
  modifyx();
}



