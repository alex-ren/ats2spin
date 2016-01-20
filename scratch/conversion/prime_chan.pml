
chan prime_ch = [0] of {int};

chan counter_ch = [0] of {int};

#define CHAN_NO 10

chan filters_ch[CHAN_NO] = [0] of {int};

proctype counter_proc(chan counter; int n) {
  end:
  do
  :: counter ! n -> n = n + 1;
  od
}

proctype filter_proc(chan chout; chan chin; int p) {
  int num = 0;
  do
  :: chin ? num ->
     if 
     :: num % p > 0 -> 
        end:
        chout ! num;
     :: else -> skip;
     fi
  od
}

proctype primes_proc(chan prime) {
  run counter_proc(counter_ch, 2);
  int p = 0;
  counter_ch ? p;
  prime ! p;
  int ch_no = 0;
  chan chout = filters_ch[ch_no];
  run filter_proc(chout, counter_ch, p);
  do
  :: filters_ch[ch_no] ? p -> 
     end:
     prime ! p;
     run filter_proc(filters_ch[ch_no + 1], filters_ch[ch_no], p);
     ch_no = ch_no + 1;
  od
}

active proctype sieve_proc() {
  run primes_proc(prime_ch);
  int c = 0;
  do
  :: c < CHAN_NO -> 
     printf("ready to receive\n");
     int p = 0;
     prime_ch ? p;
     printf("p is %d\n", p);
     c = c + 1;
  :: else -> break;
  od
}

