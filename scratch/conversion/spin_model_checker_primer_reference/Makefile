
# Problem found in this is trivial:
# One process is sleeping. One process doesn't
# run. The third process keeps running.
uts_model_trivial:
	spin -f '<>[]p' > uts_model_dats.ltl
	spin -a -N uts_model_dats.ltl uts_model_dats.pml
	gcc -o pan pan.c
	./pan -a -m60
	spin -t -N uts_model_dats.ltl -p uts_model_dats.pml # -t trace, -p print


uts_model_counterexample:
	spin -f '<>[]p && []<>q && []<>r' > uts_model_dats.ltl
	spin -a -N uts_model_dats.ltl uts_model_dats.pml
	gcc -o pan pan.c
	./pan -a
	spin -t -N uts_model_dats.ltl uts_model_dats.pml
	
uts_model_scheduling_good:
	spin -f '<>[]p && []<>q && []<>r' > uts_model_dats.ltl
	spin -a -N uts_model_dats.ltl -DFIX uts_model_dats.pml  # -DFIX is for macro.
	gcc -o pan pan.c
	./pan -a

client_server_checking:
	spin -a client_server.pml
	gcc -o pan pan.c
	./pan

clean:
	rm -rf pan
	rm -rf pan.*
	rm -rf *.trail

