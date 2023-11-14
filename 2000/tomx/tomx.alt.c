#include <stdio.h>
#define  true

true /*:all

CC=cc
PROG=mkentry

false :
	make -f $0 $1
	exit 0

all: $(PROG)

%:%.c
	$(CC) $< -o $@

clean:
	rm $(PROG)

.PHONY: /* true clean */
#undef   true
#include "mkentry.c"
