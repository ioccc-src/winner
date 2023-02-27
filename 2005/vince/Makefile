LDFLAGS+=-lGL -lGLU -L${X11_LIBDIR} -lX11

build: vince

clean:
	
clobber:
	-rm vince vince.improved

vince: vince.c
	${CC} ${CFLAGS} -I${X11_INCLUDEDIR} ${LDFLAGS} $< -o $@

alt: vince.improved

vince.improved: vince.improved.c
	${CC} ${CFLAGS} -I${X11_INCLUDEDIR} ${LDFLAGS} $< -o $@

data:

