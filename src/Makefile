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

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

CFLAGS :=
CFLAGS += -IIATS $(PATSHOMEQ)
CFLAGS += -IIATS $(PATSHOMEQ)/ccomp/runtime
CFLAGS += -IIATS $(PATSHOMERELOCQ)/contrib
CFLAGS +=  $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lm
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS +=  $(shell pkg-config --libs json-c)

######

MALLOCFLAG=-DATS_MEMALLOC_GCBDW

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOPT)" $(MALLOCFLAG) $(CFLAGS)

######


ATS2PROMELA_sta := \
    postiats/utfpl.sats

ATS2PROMELA_dyn := \
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
    postiats/utfpl_dynloadall_dats.o \
    postiats/utfpleval_mylib_dats.o \

    # postiats/utfpleval_symenv_dats.o \


# UTFPLSRC := \
#   $(UTFPLSRC_sta) \
#   $(UTFPLSRC_dyn) \

ATS2PROMELASRC := \
    $(ATS2PROMELA_sta) \
    $(ATS2PROMELA_dyn) \

######

ATS2PROMELAOBJ := $(ATS2PROMELASRC)
ATS2PROMELAOBJ := $(patsubst %.sats, %_sats.o, $(ATS2PROMELAOBJ))
ATS2PROMELAOBJ := $(patsubst %.dats, %_dats.o, $(ATS2PROMELAOBJ))

######

all:: ATS2PROMELA

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
# # ATS2PROMELA:: ; \
# #   $(MAKE) -C evaluating
# 

ATS2PROMELA:: ats2promela.o \
  main_ats2promela_dats.o \
  parsing/parsing.o; \
  $(PATSCC2) -o ats2promela $^ $(LDFLAGS)


# ATS2PROMELA:: utfpl.o \
#   parsing/parsing.o \
#   evaluating/evaluating.o \
#   utfpl_dynloadall_dats.o \
#   utfpleval_dats.o \
#   utfpleval_symenv_dats.o \
#   utfpleval_mylib_dats.o ; \
#   $(PATSCC2) -o utfpleval $^ $(LDFLAGS)
#
######

unittest:: ATS2PROMELA
unittest:: ats2promela.o \
  test_ats2promela_dats.o \
  parsing/parsing.o; \
  $(PATSCC2) -o test_ats2promela $^ $(LDFLAGS)

%_sats.o: %.sats ; $(PATSCC2) -c $< -o $@
%_dats.o: %.dats ; $(PATSCC2) -c $< -o $@

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

# ######
# #
# testall:: UTFPLEVAL
# #
# testall:: ; $(MAKE) -C TEST
# #
# testall:: ; ./utfpleval TEST/test01_utfpl.json
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

cleanats:: ; $(RMF) postiats/*_?ats.c
cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: ; $(RMF) ats2promela
cleanall:: ; $(RMF) test_ats2promela

cleanall:: ; $(RMF) ats2promela.o

cleanall:: ; $(RMF) postiats/*_?ats.o
cleanall:: ; make -C parsing cleanall

# cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######

