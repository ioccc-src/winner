#include<stdio.h>
#undef FOO
#ifndef FOO
int main() {
	printf("howdy!\n");
}
