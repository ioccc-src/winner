
build: klausler

clean:
	-rm dict.h

clobber: clean
	-rm klausler

klausler: klausler.c dict.h
	${CC} ${CFLAGS} ${LDFLAGS} $< -o $@

alt:

data: dict.h

dict.h:
	dict="";\
  	for f in mydict /usr/share/dict/words /usr/dict/words /usr/lib/dict/words ;\
  	do if [ -r $$f ]; then dict="$$dict $$f"; fi; done; \
  	if [ ".$$dict" = . ]; then echo no dictionary found; exit 1; fi; \
  	cat $$dict | \
     	tr -cd 'A-Za-z\n' |\
     	tr A-Z a-z |\
     	egrep -v '^[^ais]$$' |\
     	sort |\
     	uniq |\
     	sed 's/^/"/;s/$$/",/' >dict.h

