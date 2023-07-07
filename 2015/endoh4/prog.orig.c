f(y,x){int m,z;for(m=z=1;m*m<=y?z=y%m?z:m:x+1?z<2?x?f(x,0):putchar(64):f(z,x),putchar(x?10:32),y-=z:(f(z,y/z),0);)m++;}main(y){f(y-1,-1);}
