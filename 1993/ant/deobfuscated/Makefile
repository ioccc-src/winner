CFLAGS= -Os -Wno-deprecated-non-prototype

all: build

build: ant ant-c89

clean:
	-rm -f ant ant-c89 *.out

# Original K&R version.
ant$E: ant.c
	${CC} ${CFLAGS} ant.c -o $@

ant-c89$E: ant-c89.c
	${CC} ${CFLAGS} ant-c89.c -o $@

test: ant$E
	${MAKE} -f test.mk PRG=./ant >ant.out 2>&1

test-c89: ant-c89$E
	${MAKE} -f test.mk PRG=./ant-c89 >ant-c89.out 2>&1

# Make sure the old and revised versions behave the same.
test-compare: build test test-c89
	sed -e 's/-c89//' ant-c89.out | diff -u ant.out -
	rm *.out

