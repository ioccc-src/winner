
INCDIR=`sdl-config --cflags`
LDFLAGS+=`sdl-config --libs`

build: jetro

clean:
	
clobber:
	-rm jetro

jetro: jetro.c
	sdl-config --version && ${CC} ${CFLAGS} ${INCDIR} ${LDFLAGS} $< -o $@

alt:

data:

