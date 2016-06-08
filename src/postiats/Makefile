
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
    postiats.sats

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
    postiats.dats \
    postiats_stamp.dats \
    postiats_symbol.dats \
    postiats_location.dats \
    postiats_label.dats \
    postiats_s2cst.dats \
    postiats_s2var.dats \
    postiats_s2exp.dats \
    postiats_s2rt.dats \
    postiats_d2con.dats \
    postiats_d2cst.dats \
    postiats_d2var.dats \
    postiats_d2sym.dats \
    postiats_p2at.dats \
    postiats_c2lau.dats \
    postiats_d2exp.dats \
    postiats_mylib.dats \
    dynloadall.dats \
    postiats_d2ecl.dats


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
	make ATS2PROMELA_POSTIATS

######
#
ats2promela_postiats.o: $(ATS2PROMELAOBJ) ; ld -r -o $@ $^
#
# evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

MAKE=make

######
#
#
ATS2PROMELA_POSTIATS:: ats2promela_postiats

ats2promela_postiats: ats2promela_postiats.o \
  main_ats2promela_postiats_dats.o; \
  $(CC) -o $@ $^ $(LDFLAGS)

######

unittest:: ATS2PROMELA_POSTIATS
unittest:: ats2promela_postiats.o \
  test_ats2promela_postiats_dats.o; \
  $(CC) -o test_ats2promela_postiats $^ $(LDFLAGS)

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

codegen:: postiats_codegen2.hats;

postiats_codegen2.hats: \
postiats.sats codegen.dats; \
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
	./ats2promela_postiats $< 
# > $(patsubst %.json, %.postiats, $<)
# cat $(patsubst %.json, %.postiats, $<)

debug_%: TEST/test_%_dats.json
	./ats2promela_postiats $< --debug

# ######
#
testall:: all
#
testall:: ; $(MAKE) -C TEST
#
testall:: test_postiats_01
testall:: test_postiats_02
testall:: test_parsing_01

# ######

cleanlocal:: ; $(RMF) *_?ats.c
cleanlocal:: ; $(RMF) *_?ats.o
cleanlocal:: ; $(RMF) ats2promela_postiats.o
cleanlocal:: ; $(RMF) ats2promela_postiats

cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) ./../utils/*_?ats.c
cleanats:: ; $(RMF) ./../parsing/*_?ats.c

######

cleanall:: ; $(RMF) *_?ats.o
cleanall:: ; $(RMF) ./../utils/*_?ats.o
cleanall:: ; $(RMF) ./../parsing/*_?ats.o
cleanall:: ; $(RMF) ats2promela_postiats.o

######

cleanall:: ; $(RMF) ats2promela_postiats
cleanall:: ; $(RMF) test_ats2promela_postiats


# cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######

