#
# A Simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

CFLAGS :=
CFLAGS += -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 
CFLAGS +=  $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lm
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += -lpcre
LDFLAGS +=  $(shell pkg-config --libs json-c)

######

MALLOCFLAG=-DATS_MEMALLOC_GCBDW

######

ATS2PROMELA_sta := \
    postiats/utfpl.sats \
    instr0/instr0.sats \
    promela/promela.sats

ATS2PROMELA_dyn := \
    utils/emiter.dats \
    postiats/utfpl.dats \
    postiats/utfpl_stamp.dats \
    postiats/utfpl_symbol.dats \
    postiats/utfpl_location.dats \
    postiats/utfpl_label.dats \
    postiats/utfpl_d2cst.dats \
    postiats/utfpl_d2var.dats \
    postiats/utfpl_d2sym.dats \
    postiats/utfpl_p2at.dats \
    postiats/utfpl_d2exp.dats \
    postiats/utfpl_d2ecl.dats \
    postiats/utfpleval_mylib.dats \
    postiats/utfpl_dynloadall.dats \
    instr0/instr0.dats \
    instr0/i0exp.dats \
    instr0/i0name.dats \
    instr0/i0ins.dats \
    instr0/i0fundef.dats \
    instr0/optimize.dats \
    instr0/i0funmap.dats \
    instr0/i0idmap.dats \
    instr0/stamp_allocator.dats \
    instr0/dynloadall.dats \
    promela/promela.dats \
    promela/promela_fprint.dats \
    promela/promela_emit.dats \
    promela/pml_name.dats \
    promela/pml_uname.dats \
    promela/pml_decl.dats \
    promela/pml_proctype.dats \
    promela/dynloadall.dats \


ATS2PROMELASRC := \
    $(ATS2PROMELA_sta) \
    $(ATS2PROMELA_dyn) \

######

ATS2PROMELAOBJ := $(ATS2PROMELASRC)
ATS2PROMELAOBJ := $(patsubst %.sats, %_sats.o, $(ATS2PROMELAOBJ))
ATS2PROMELAOBJ := $(patsubst %.dats, %_dats.o, $(ATS2PROMELAOBJ))

######

all:: 
	make codegen
	make ATS2PROMELA

######
#
ats2promela.o: $(ATS2PROMELAOBJ) ; ld -r -o $@ $^
#
parsing/parsing.o: ; make -C parsing parsing.o
#
# evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

MAKE=make

######
#
ATS2PROMELA:: ; \
  $(MAKE) -C parsing

ATS2PROMELA:: ats2promela

ats2promela: ats2promela.o \
  main_ats2promela_dats.o \
  parsing/parsing.o; \
  $(CC) -o $@ $^ $(LDFLAGS)

######

unittest:: ATS2PROMELA
unittest:: ats2promela.o \
  test_ats2promela_dats.o \
  parsing/parsing.o; \
  $(CC) -o test_ats2promela $^ $(LDFLAGS)

# PATSCC2= $(PATSCC) -atsccomp "$(CCOPT)" $(MALLOCFLAG) $(CFLAGS)
# %_sats.o: %.sats ; $(PATSCC2) -c $< -o $@
# %_dats.o: %.dats ; $(PATSCC2) -c $< -o $@


# ######### ##########
# Two steps. Not good with .depend
# %_sats.o: %_sats.c ; $(CC) $(INCLUDE) $(CFLAGS) -c $< -o $@
# %_dats.o: %_dats.c ; $(CC) $(INCLUDE) $(CFLAGS) $(MALLOCFLAG) -c $< -o $@
# 
# .PRECIOUS: %_sats.c %_dats.c
# 
# %_sats.c: %.sats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -s $<
# %_dats.c: %.dats ; $(PATSOPT) $(INCLUDE_ATS) -o $@ -d $<


%_sats.o: %.sats
	$(PATSOPT) $(INCLUDE_ATS) -o $(patsubst %.sats, %_sats.c, $<) -s $<
	$(CC) $(INCLUDE) $(CFLAGS) -c $(patsubst %.sats, %_sats.c, $<) -o $@

ATS2PROMELAOBJ := $(patsubst %.sats, %_sats.o, $(ATS2PROMELAOBJ))

%_dats.o: %.dats
	$(PATSOPT) $(INCLUDE_ATS) -o $(patsubst %.dats, %_dats.c, $<) -d $<
	$(CC) $(INCLUDE) $(CFLAGS) $(MALLOCFLAG) -c $(patsubst %.dats, %_dats.c, $<) -o $@

# ######### ##########

codegen:: postiats/postiats_codegen2.hats \
    instr0/instr0_codegen2.hats \
    promela/promela_codegen2.hats;

instr0/instr0_codegen2.hats: \
./instr0/instr0.sats ./instr0/codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d instr0/codegen.dats


postiats/postiats_codegen2.hats: \
./postiats/utfpl.sats ./postiats/codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d postiats/codegen.dats

promela/promela_codegen2.hats: \
./promela/promela.sats ./promela/codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d promela/codegen.dats

# ######### ##########


# ######### ##########


######

-include .depend

######

depend:: ; $(RMF) .depend
depend:: ; $(PATSOPT) --output-a .depend --depgen -
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(ATS2PROMELA_sta)
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(ATS2PROMELA_dyn)
# depend:: ; $(PATSOPT) --output-a .depend --depgen -s utfpleval.sats
# depend:: ; $(PATSOPT) --output-a .depend --depgen -d utfpleval_symenv.dats
# depend:: ; $(PATSOPT) --output-a .depend --depgen -d utfpleval.dats

######
#
testall:: all
#
testall:: ; $(MAKE) -C TEST
#
testall:: test_pml_01
testall:: test_pml_02

# testall:: ; ./ats2promela TEST/test_pml_01_dats.json
# testall:: ; ./ats2promela TEST/test01_dats.json
# testall:: ; ./utfpleval TEST/test02_utfpl.json
# testall:: ; ./utfpleval TEST/test03_utfpl.json
# testall:: ; ./utfpleval TEST/test04_utfpl.json
# testall:: ; ./utfpleval TEST/test05_utfpl.json
# testall:: ; ./utfpleval TEST/test06_utfpl.json < TEST/test06_utfpl.json
# testall:: ; ./utfpleval TEST/queens_utfpl.json
# #
# testall:: cleanall
# #
# ######

test_%: TEST/test_%_dats.json
	./ats2promela $< 

cleanats:: ; $(RMF) postiats/*_?ats.c
cleanats:: ; $(RMF) utils/*_?ats.c
cleanats:: ; $(RMF) instr0/*_?ats.c
cleanats:: ; $(RMF) promela/*_?ats.c
cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: ; $(RMF) postiats/*_?ats.o
cleanall:: ; $(RMF) utils/*_?ats.o
cleanall:: ; $(RMF) instr0/*_?ats.o
cleanats:: ; $(RMF) promela/*_?ats.o
cleanall:: ; $(RMF) ats2promela.o

######

cleanall:: ; $(RMF) ats2promela
cleanall:: ; $(RMF) test_ats2promela

# cleanall:: ; make -C parsing cleanall

# cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######

