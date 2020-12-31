f(y,x){int m,z;for(m=z=1;m*m<=y?z=y%m?z:m:x+1?z<2?y&&f(x,0):f(z,x),putchar(x?10:32<<!y),y-=z*!!y:(f(z,y/z),0);)m++;}main(y){f(y-1,-1);}
