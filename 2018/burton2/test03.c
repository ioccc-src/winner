#include <stdio.h>
char a[] = "main() { return printf(\" hello, world!\n\"     \" } ; // this is not a comment";
int main() { printf("%s\n", a); }
