
process_scheduling_trivial:
	spin -f '<>[]p' > process_scheduling.ltl
	spin -a -N process_scheduling.ltl process_scheduling.pml
	gcc -o pan pan.c
	./pan -a -m60
	spin -t -p process_scheduling.pml


rocess_scheduling_counterexample:
	spin -f '<>[]p && []<>q && []<>r' > process_scheduling.ltl
	spin -a -N process_scheduling.ltl process_scheduling.pml
	gcc -o pan pan.c
	./pan -a
	spin -t process_scheduling.pml
	
process_scheduling_good:
	spin -f '<>[]p && []<>q && []<>r' > process_scheduling.ltl
	spin -a -N process_scheduling.ltl -DFIX process_scheduling.pml
	gcc -o pan pan.c
	./pan -a


