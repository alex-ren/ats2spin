
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
    ./../parsing/parsing.sats \
    ./../postiats/postiats.sats \
    ./../simpletypes/simpletypes.sats \
    ./instr0.sats

ATS2PROMELA_dyn := \
    ./../utils/emiter.dats \
    ./../parsing/parsing.dats \
    ./../parsing/parsing_s2rt.dats \
    ./../parsing/parsing_s2cst.dats \
    ./../parsing/parsing_s2var.dats \
    ./../parsing/parsing_s2exp.dats \
    ./../parsing/parsing_d2con.dats \
    ./../parsing/parsing_d2cst.dats \
    ./../parsing/parsing_d2ecl.dats \
    ./../parsing/parsing_d2exp.dats \
    ./../parsing/parsing_d2sym.dats \
    ./../parsing/parsing_d2var.dats \
    ./../parsing/parsing_export.dats \
    ./../parsing/parsing_p2at.dats \
    ./../parsing/dynloadall.dats \
    ./../postiats/postiats.dats \
    ./../postiats/postiats_stamp.dats \
    ./../postiats/postiats_symbol.dats \
    ./../postiats/postiats_location.dats \
    ./../postiats/postiats_label.dats \
    ./../postiats/postiats_s2cst.dats \
    ./../postiats/postiats_s2var.dats \
    ./../postiats/postiats_s2rt.dats \
    ./../postiats/postiats_s2exp.dats \
    ./../postiats/postiats_d2con.dats \
    ./../postiats/postiats_d2cst.dats \
    ./../postiats/postiats_d2var.dats \
    ./../postiats/postiats_d2sym.dats \
    ./../postiats/postiats_p2at.dats \
    ./../postiats/postiats_c2lau.dats \
    ./../postiats/postiats_d2exp.dats \
    ./../postiats/postiats_mylib.dats \
    ./../postiats/postiats_d2ecl.dats \
    ./../postiats/dynloadall.dats \
    ./../simpletypes/simpletypes.dats \
    ./../simpletypes/simpletypes_typemap.dats \
    ./../simpletypes/simpletypes_poly_para_map.dats \
    ./../simpletypes/simpletypes_translate.dats \
    ./../simpletypes/simpletypes_instantiate.dats \
    ./../simpletypes/simpletypes_export.dats \
    ./../simpletypes/dynloadall.dats \
    instr0.dats \
    i0exp.dats \
    i0name.dats \
    i0ins.dats \
    i0fundef.dats \
    i0optimize.dats \
    i0funmap.dats \
    i0idmap.dats \
    i0id.dats \
    i0stamp_allocator.dats \
    i0type0.dats \
    dynloadall.dats


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
	make ATS2PROMELA_INSTR0

######
#
ats2promela_instr0.o: $(ATS2PROMELAOBJ) ; ld -r -o $@ $^
#
# evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

MAKE=make

######
#
#
ATS2PROMELA_INSTR0:: ats2promela_instr0

ats2promela_instr0: ats2promela_instr0.o \
  main_ats2promela_instr0_dats.o; \
  $(CC) -o $@ $^ $(LDFLAGS)

######

unittest:: ATS2PROMELA_INSTR0
unittest:: ats2promela_instr0.o \
  test_ats2promela_instr0_dats.o; \
  $(CC) -o test_ats2promela_instr0 $^ $(LDFLAGS)

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

codegen:: ./../postiats/postiats_codegen2.hats \
    ./../simpletypes/simpletypes_codegen2.hats \
    ./instr0_codegen2.hats ;

./../postiats/postiats_codegen2.hats: \
./../postiats/postiats.sats ./../postiats/codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d ./../postiats/codegen.dats

./../simpletypes/simpletypes_codegen2.hats: \
./../simpletypes/simpletypes.sats ./../simpletypes/codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d ./../simpletypes/codegen.dats

./instr0_codegen2.hats: \
./instr0.sats ./codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d codegen.dats

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
	./ats2promela_instr0 $< 
# > $(patsubst %.json, %.instr0, $<)
# cat $(patsubst %.json, %.instr0, $<)

debug_%: TEST/test_%_dats.json
	./ats2promela_instr0 $< --debug

# ######
#
testall:: all
#
testall:: ; $(MAKE) -C TEST
#
testall:: test_instr0_01
testall:: test_instr0_02
testall:: test_instr0_03
testall:: test_instr0_04
testall:: test_instr0_05
testall:: test_instr0_06
testall:: test_instr0_07
testall:: test_instr0_08
testall:: test_instr0_09
testall:: test_instr0_10
testall:: test_instr0_11
testall:: test_instr0_12
testall:: test_instr0_13
testall:: test_instr0_14
testall:: test_instr0_15
testall:: test_instr0_16
testall:: test_instr0_17
testall:: test_instr0_18
testall:: test_instr0_19

# ######

cleanlocal:: ; $(RMF) *_?ats.c
cleanlocal:: ; $(RMF) *_?ats.o
cleanlocal:: ; $(RMF) ats2promela_instr0.o
cleanlocal:: ; $(RMF) ats2promela_instr0

cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) ./../utils/*_?ats.c
cleanats:: ; $(RMF) ./../parsing/*_?ats.c

######

cleanall:: ; $(RMF) *_?ats.o
cleanall:: ; $(RMF) ./../utils/*_?ats.o
cleanall:: ; $(RMF) ./../parsing/*_?ats.o
cleanall:: ; $(RMF) ./../postiats/*_?ats.o
cleanall:: ; $(RMF) ats2promela_instr0.o

######

cleanall:: ; $(RMF) ats2promela_instr0
cleanall:: ; $(RMF) test_ats2promela_instr0


# cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######

