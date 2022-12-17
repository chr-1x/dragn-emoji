SVGS := $(wildcard *.svg)
PNGS := $(SVGS:%.svg=%.png)

.PHONY: clean

dragn-emoji.tar.gz: $(PNGS)
	tar -c $? | gzip > $@

%.nooptim.png: %.svg
	magick convert -background none -geometry 256x256 $< $@

%.png: %.nooptim.png
	oxipng -o max --out $@ $<

clean:
	find . -maxdepth 1 -name '*.png' -delete
	rm -f dragn-emoji.tar.gz
