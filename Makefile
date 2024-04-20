ZIPOUT = dejavuln-autoroot.zip

FILES = autoroot.sh hbchannel-0.6.3.ipk lol$$(sh$$IFS/tmp/usb/sda/sda1/autoroot.sh).mp3 lol$$(sh$$IFS/tmp/usb/sda/sda1/autoroot.sh).lrc

.PHONY: all
all: $(ZIPOUT)

$(ZIPOUT): $(FILES)
	zip -X '$(@)' -- $(foreach f,$^,'$(f)')

.PHONY: clean
clean:
	rm -f -- '$(ZIPOUT)'
