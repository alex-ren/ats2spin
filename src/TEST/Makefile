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

all:: test_scratch_dats.json
all:: test01_dats.json
all:: test02_dats.json
all:: test_pml_01_dats.json
all:: test_pml_02_dats.json
all:: test_pml_03_dats.json
all:: test_pml_04_dats.json
all:: test_pml_05_dats.json
all:: test_pml_06_dats.json
all:: test_pml_07_dats.json
all:: test_pml_08_dats.json
all:: test_pml_09_dats.json
all:: test_pml_10_dats.json
all:: test_pml_11_dats.json
all:: test_pml_12_dats.json
all:: test_pml_13_dats.json
all:: test_pml_14_dats.json
all:: test_pml_15_dats.json

all:: test_example_01_peterson_dats.json

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
cleanall:: ; $(RMF) test_scratch_dats.json
cleanall:: ; $(RMF) test01_dats.json
cleanall:: ; $(RMF) test02_dats.json
cleanall:: ; $(RMF) test_pml_01_dats.json
cleanall:: ; $(RMF) test_pml_02_dats.json
cleanall:: ; $(RMF) test_pml_03_dats.json
cleanall:: ; $(RMF) test_pml_04_dats.json
cleanall:: ; $(RMF) test_pml_05_dats.json
cleanall:: ; $(RMF) test_pml_06_dats.json
cleanall:: ; $(RMF) test_pml_07_dats.json
cleanall:: ; $(RMF) test_pml_08_dats.json
cleanall:: ; $(RMF) test_pml_09_dats.json
cleanall:: ; $(RMF) test_pml_10_dats.json
cleanall:: ; $(RMF) test_pml_11_dats.json
cleanall:: ; $(RMF) test_pml_12_dats.json
cleanall:: ; $(RMF) test_pml_13_dats.json
cleanall:: ; $(RMF) test_pml_14_dats.json
cleanall:: ; $(RMF) test_pml_15_dats.json

cleanall:: ; $(RMF) test_example_01_peterson_dats.json

###### end of [Makefile] ######
