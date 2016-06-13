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

all:: test_promela_01_dats.json
all:: test_promela_02_dats.json
all:: test_promela_03_dats.json
all:: test_promela_04_dats.json
all:: test_promela_05_dats.json
all:: test_promela_06_dats.json
all:: test_promela_07_dats.json
all:: test_promela_08_dats.json
all:: test_promela_09_dats.json
all:: test_promela_10_dats.json
all:: test_promela_11_dats.json
all:: test_promela_12_dats.json
all:: test_promela_13_dats.json
all:: test_promela_14_dats.json
all:: test_promela_15_dats.json
all:: test_promela_16_dats.json
all:: test_promela_17_dats.json
all:: test_promela_18_dats.json

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
cleanall:: ; $(RMF) test_promela_01_dats.json
cleanall:: ; $(RMF) test_promela_02_dats.json
cleanall:: ; $(RMF) test_promela_03_dats.json
cleanall:: ; $(RMF) test_promela_04_dats.json
cleanall:: ; $(RMF) test_promela_05_dats.json
cleanall:: ; $(RMF) test_promela_06_dats.json
cleanall:: ; $(RMF) test_promela_07_dats.json
cleanall:: ; $(RMF) test_promela_08_dats.json
cleanall:: ; $(RMF) test_promela_09_dats.json
cleanall:: ; $(RMF) test_promela_10_dats.json
cleanall:: ; $(RMF) test_promela_11_dats.json
cleanall:: ; $(RMF) test_promela_12_dats.json
cleanall:: ; $(RMF) test_promela_13_dats.json
cleanall:: ; $(RMF) test_promela_14_dats.json
cleanall:: ; $(RMF) test_promela_15_dats.json
cleanall:: ; $(RMF) test_promela_16_dats.json
cleanall:: ; $(RMF) test_promela_17_dats.json
cleanall:: ; $(RMF) test_promela_18_dats.json

###### end of [Makefile] ######
