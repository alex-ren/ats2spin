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

all:: test01_dats.json
all:: test02_dats.json
all:: test_pml_01_dats.json
all:: test_pml_02_dats.json
all:: test_pml_03_dats.json
all:: test_pml_04_dats.json
all:: test_pml_05_dats.json
all:: test_pml_06_dats.json

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
cleanall:: ; $(RMF) test01_dats.json
cleanall:: ; $(RMF) test02_dats.json
cleanall:: ; $(RMF) test_pml_01_dats.json
cleanall:: ; $(RMF) test_pml_02_dats.json
cleanall:: ; $(RMF) test_pml_03_dats.json
cleanall:: ; $(RMF) test_pml_04_dats.json
cleanall:: ; $(RMF) test_pml_05_dats.json
cleanall:: ; $(RMF) test_pml_06_dats.json

###### end of [Makefile] ######
