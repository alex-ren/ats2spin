
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
    ./simpletypes.sats

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
    simpletypes.dats \
    simpletypes_typemap.dats \
    simpletypes_poly_para_map.dats \
    simpletypes_translate.dats \
    simpletypes_instantiate.dats \
    simpletypes_export.dats \
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
	make ATS2PROMELA_SIMPLETYPES

######
#
ats2promela_simpletypes.o: $(ATS2PROMELAOBJ) ; ld -r -o $@ $^
#
# evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

MAKE=make

######
#
#
ATS2PROMELA_SIMPLETYPES:: ats2promela_simpletypes

ats2promela_simpletypes: ats2promela_simpletypes.o \
  main_ats2promela_simpletypes_dats.o; \
  $(CC) -o $@ $^ $(LDFLAGS)

######

unittest:: ATS2PROMELA_SIMPLETYPES
unittest:: ats2promela_simpletypes.o \
  test_ats2promela_simpletypes_dats.o; \
  $(CC) -o test_ats2promela_simpletypes $^ $(LDFLAGS)

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
    ./simpletypes_codegen2.hats ;

./../postiats/postiats_codegen2.hats: \
./../postiats/postiats.sats ./../postiats/codegen.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d ./../postiats/codegen.dats

./simpletypes_codegen2.hats: \
./simpletypes.sats ./codegen.dats; \
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
	./ats2promela_simpletypes $< 
# > $(patsubst %.json, %.simpletypes, $<)
# cat $(patsubst %.json, %.simpletypes, $<)

debug_%: TEST/test_%_dats.json
	./ats2promela_simpletypes $< --debug

# ######
#
testall:: all
#
testall:: ; $(MAKE) -C TEST
#
testall:: test_simpletypes_01
testall:: test_simpletypes_02
testall:: test_simpletypes_03

# ######

cleanlocal:: ; $(RMF) *_?ats.c
cleanlocal:: ; $(RMF) *_?ats.o
cleanlocal:: ; $(RMF) ats2promela_simpletypes.o
cleanlocal:: ; $(RMF) ats2promela_simpletypes

cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) ./../utils/*_?ats.c
cleanats:: ; $(RMF) ./../parsing/*_?ats.c

######

cleanall:: ; $(RMF) *_?ats.o
cleanall:: ; $(RMF) ./../utils/*_?ats.o
cleanall:: ; $(RMF) ./../parsing/*_?ats.o
cleanall:: ; $(RMF) ./../postiats/*_?ats.o
cleanall:: ; $(RMF) ats2promela_simpletypes.o

######

cleanall:: ; $(RMF) ats2promela_simpletypes
cleanall:: ; $(RMF) test_ats2promela_simpletypes


# cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######

