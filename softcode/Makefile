#

SOFTPROJ = initiatives worldtime
MUSH = $(foreach dir,$(SOFTPROJ),$(dir)/$(dir).mush)
UMUSH = $(MUSH:%.mush=%.umush)
UNFORMAT = $(PERL) ../utilities/unformat.pl

.PHONY: all
all: all-projects.umush

%.umush: %.mush
	@echo UNFORMAT $<
	@$(UNFORMAT) $< > $@

all-projects.umush: $(UMUSH)
	@echo CAT $^
	@cat $^ > $@

.PHONY: clean
clean:
	@echo CLEAN
	@rm -f $(UMUSH) all-projects.umush *~

