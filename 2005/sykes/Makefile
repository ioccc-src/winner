LDFLAGS+=-lcurses

build: sykes

clean:
	-rm *.bin

clobber: clean
	-rm sykes pet.rom

sykes: sykes.c
	${CC} ${CFLAGS} ${LDFLAGS} $< -o $@

alt: sykes.orig
	
sykes.orig: sykes.orig.c
	${CC} ${CFLAGS} ${LDFLAGS} $< -o $@

data: pet.rom

pet.rom: basic-2-c000.901465-01.bin basic-2-d000.901465-02.bin edit-2-n.901447-24.bin nullfill.bin kernal-2.901465-03.bin
	cat basic-2-c000.901465-01.bin basic-2-d000.901465-02.bin edit-2-n.901447-24.bin nullfill.bin kernal-2.901465-03.bin >pet.rom

basic-2-c000.901465-01.bin:
	wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/basic-2-c000.901465-01.bin

basic-2-d000.901465-02.bin:
	wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/basic-2-d000.901465-02.bin

edit-2-n.901447-24.bin:
	wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/edit-2-n.901447-24.bin

kernal-2.901465-03.bin:
	wget http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/pet/kernal-2.901465-03.bin

nullfill.bin:
	dd bs=2k count=1 if=/dev/zero of=nullfill.bin

