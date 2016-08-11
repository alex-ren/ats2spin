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

all:: test_simpletypes_01_dats.json
all:: test_simpletypes_02_dats.json
all:: test_simpletypes_03_dats.json
all:: test_simpletypes_04_dats.json
all:: test_simpletypes_05_dats.json
all:: test_simpletypes_06_dats.json
all:: test_simpletypes_07_dats.json
all:: test_simpletypes_08_dats.json


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
cleanall:: ; $(RMF) test_simpletypes_01_dats.json
cleanall:: ; $(RMF) test_simpletypes_02_dats.json
cleanall:: ; $(RMF) test_simpletypes_03_dats.json
cleanall:: ; $(RMF) test_simpletypes_04_dats.json
cleanall:: ; $(RMF) test_simpletypes_05_dats.json
cleanall:: ; $(RMF) test_simpletypes_06_dats.json
cleanall:: ; $(RMF) test_simpletypes_07_dats.json
cleanall:: ; $(RMF) test_simpletypes_08_dats.json

###### end of [Makefile] ######

