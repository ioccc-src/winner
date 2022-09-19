#include <stdio.h>
#define  true

true /*:all

CC=cc
PROG=tomx

false :
	make -f $0 $1
	exit 0

all: $(PROG)

%:%.c
	$(CC) $< -o $@

clean:
	rm $(PROG)

.PHONY: /* true clean */
	int main() {return!printf("Hello, world\n");}
