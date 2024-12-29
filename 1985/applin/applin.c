main(v,c)char**c;{for(v[c++]=strdup("Hello, world!\n\n");(!!c)[*c]&&(v--||--c&&execlp(*c,*c,c[!!c]+!!c,!c));**c=!c)write(!!*c,*c,!!**c);}
