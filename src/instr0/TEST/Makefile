#
# A simple Makefile
#

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

ifeq ("$(PATSHOMERELOC)","")
  PATSHOMERELOCQ="$(ATSHOMERELOC)"
else
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::

######

all:: test_instr0_01_dats.json
all:: test_instr0_02_dats.json
all:: test_instr0_03_dats.json
all:: test_instr0_04_dats.json
all:: test_instr0_05_dats.json
all:: test_instr0_06_dats.json
all:: test_instr0_07_dats.json
all:: test_instr0_08_dats.json
all:: test_instr0_09_dats.json
all:: test_instr0_10_dats.json
all:: test_instr0_11_dats.json
all:: test_instr0_12_dats.json
all:: test_instr0_13_dats.json
all:: test_instr0_14_dats.json
all:: test_instr0_15_dats.json
all:: test_instr0_16_dats.json
all:: test_instr0_17_dats.json
all:: test_instr0_18_dats.json
all:: test_instr0_19_dats.json

######
#
%_dats.json: %.dats ; \
  $(PATSOPT) --jsonize-2 -o $@ -d $<
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~

cleanall:: clean
cleanall:: ; $(RMF) test_instr0_01_dats.json
cleanall:: ; $(RMF) test_instr0_02_dats.json
cleanall:: ; $(RMF) test_instr0_03_dats.json
cleanall:: ; $(RMF) test_instr0_04_dats.json
cleanall:: ; $(RMF) test_instr0_05_dats.json
cleanall:: ; $(RMF) test_instr0_06_dats.json
cleanall:: ; $(RMF) test_instr0_07_dats.json
cleanall:: ; $(RMF) test_instr0_08_dats.json
cleanall:: ; $(RMF) test_instr0_09_dats.json
cleanall:: ; $(RMF) test_instr0_10_dats.json
cleanall:: ; $(RMF) test_instr0_11_dats.json
cleanall:: ; $(RMF) test_instr0_12_dats.json
cleanall:: ; $(RMF) test_instr0_13_dats.json
cleanall:: ; $(RMF) test_instr0_14_dats.json
cleanall:: ; $(RMF) test_instr0_15_dats.json
cleanall:: ; $(RMF) test_instr0_16_dats.json
cleanall:: ; $(RMF) test_instr0_17_dats.json
cleanall:: ; $(RMF) test_instr0_18_dats.json
cleanall:: ; $(RMF) test_instr0_19_dats.json

###### end of [Makefile] ######
