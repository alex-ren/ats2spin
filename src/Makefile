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
    parsing/parsing.sats \
    postiats/postiats.sats \
    instr0/instr0.sats \
    promela/promela.sats

ATS2PROMELA_dyn := \
    utils/emiter.dats \
    parsing/parsing.dats \
    parsing/parsing_s2rt.dats \
    parsing/parsing_s2cst.dats \
    parsing/parsing_s2var.dats \
    parsing/parsing_d2con.dats \
    parsing/parsing_d2cst.dats \
    parsing/parsing_d2ecl.dats \
    parsing/parsing_d2exp.dats \
    parsing/parsing_d2sym.dats \
    parsing/parsing_d2var.dats \
    parsing/parsing_export.dats \
    parsing/parsing_p2at.dats \
    parsing/dynloadall.dats \
    postiats/postiats.dats \
    postiats/postiats_stamp.dats \
    postiats/postiats_symbol.dats \
    postiats/postiats_location.dats \
    postiats/postiats_label.dats \
    postiats/postiats_s2cst.dats \
    postiats/postiats_s2var.dats \
    postiats/postiats_d2con.dats \
    postiats/postiats_d2cst.dats \
    postiats/postiats_d2var.dats \
    postiats/postiats_d2sym.dats \
    postiats/postiats_p2at.dats \
    postiats/postiats_c2lau.dats \
    postiats/postiats_d2exp.dats \
    postiats/postiats_d2ecl.dats \
    postiats/postiats_mylib.dats \
    postiats/dynloadall.dats \
    instr0/instr0.dats \
    instr0/i0exp.dats \
    instr0/i0name.dats \
    instr0/i0ins.dats \
    instr0/i0fundef.dats \
    instr0/i0optimize.dats \
    instr0/i0funmap.dats \
    instr0/i0idmap.dats \
    instr0/i0id.dats \
    instr0/i0stamp_allocator.dats \
    instr0/dynloadall.dats \
    promela/promela.dats \
    promela/promela_fprint.dats \
    promela/promela_emit.dats \
    promela/pml_name.dats \
    promela/pml_uname.dats \
    promela/pml_decl.dats \
    promela/pml_proctype.dats \
    promela/pml_inline.dats \
    promela/dynloadall.dats


ATS2PROMELASRC := \
    $(ATS2PROMELA_sta) \
    $(ATS2PROMELA_dyn)

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
# evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

MAKE=make

######
#
#
ATS2PROMELA:: ats2promela

ats2promela: ats2promela.o \
  main_ats2promela_dats.o; \
  $(CC) -o $@ $^ $(LDFLAGS)

######

unittest:: ATS2PROMELA
unittest:: ats2promela.o \
  test_ats2promela_dats.o; \
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
./postiats/postiats.sats ./postiats/codegen.dats; \
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

######

test_%: TEST/test_%_dats.json
	./ats2promela $< > $(patsubst %.json, %.pml, $<)
	cat $(patsubst %.json, %.pml, $<)
	spin -u1000 $(patsubst %.json, %.pml, $<)

debug_%: TEST/test_%_dats.json
	./ats2promela $< --debug
#	cat $(patsubst %.json, %.pml, $<)

# ######
#
testall:: all
#
testall:: ; $(MAKE) -C TEST
#
testall:: test_pml_01
testall:: test_pml_02
testall:: test_pml_03
testall:: test_pml_04
testall:: test_pml_05
testall:: test_pml_06
testall:: test_pml_07
testall:: test_pml_08
testall:: test_pml_09
testall:: test_pml_10
testall:: test_pml_11
testall:: test_pml_12
testall:: test_pml_13
testall:: test_pml_14
testall:: test_pml_15

testall:: test_example_01_peterson

testall:: test_pml_16
testall:: test_pml_17
testall:: test_pml_18

# ######


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


# cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######

