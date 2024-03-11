#!/usr/bin/env bash
alias c="cc -Wno-implicit-int -E -Dc='int main(){printf(\"N%sested comments allowed.\\n"'",/*/*/0*/**/1?"":"o n"'");}' stig.c|grep -v '^#'>o.c;cc -include stdio.h -o o o.c;./o"
