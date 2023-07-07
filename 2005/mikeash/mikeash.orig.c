;typedef char n;typedef n*m;int C;n c[11];n y[]={37,100,0};n b[2048];int i
;int A(void){return C=getchar();}int B(m s){return strlen(s)
;}n w[2048];typedef m defvar;m R(void){do A();while(isblank(C) || C == '\n')
;if(C<0) return 0;i=0;if(C==';'){for
(defvar q=
";typedef char n;typedef n*m;int C;n c[11];n y[]={37,100,0};n b[2048];int iY;int A(void){return C=getchar();}int B(m s){return strlen(s)Y;}n w[2048];typedef m defvar;m R(void){do A();while(isblank(C) || C == '\n')Y;if(C<0) return 0;i=0;if(C==';'){forY(defvar q=Y~sY;C!='\n';A()Y);R();}else if(C=='('||C==')')b[i++]=C;else if(C==34)do b[i++]=CY;while(A()!=34);else do b[i++]=C;while(!isblank(A())&&C!='\n')Y;b[i] = 0;return b;}typedef defvar*format;m E(void){Y;m a=R();if(!a) return 0;if(*a==34)return aY;if(*a=='#'){c[0]=a[2]=='N'?'\n':a[2];return c;}if(*a=='q')return wY;if(*a=='('){a=R();if(*a=='d'){R();strcpy(w,E());R();return wY;}else if(*a=='f'){R();m f = strdup(E());*strchr(f,126)=37Y;m s=E();s[B(s)+1]=0;s[B(s)]=34;printf(f+1,s);R()Y;}else if(*a=='s'){n p=*E();n o=*E();m r=strdup(E());a=r;forY(format t ;*a;a++)*a=*a==o?p:*aY;R();return r;}else if(*a=='c'){c[0]=*E()-32/*Y(substitute #\Newline (char-upcase #\y ) q= )q= );*/Y;R();return c;}else{n z=*a;int d=atoi(E()),e=atoi(E())Y;sprintf(c,y,z-'+'?z-'-'?z-'*'?d/e:d*e:d-e:d+e);R();return cY;}}return a;}int main(void){while(C+1)E();return 0;}Y"
;C!='\n';A()
);R();}else if(C=='('||C==')')b[i++]=C;else if(C==34)do b[i++]=C
;while(A()!=34);else do b[i++]=C;while(!isblank(A())&&C!='\n')
;b[i] = 0;return b;}typedef defvar*format;m E(void){
;m a=R();if(!a) return 0;if(*a==34)return a
;if(*a=='#'){c[0]=a[2]=='N'?'\n':a[2];return c;}if(*a=='q')return w
;if(*a=='('){a=R();if(*a=='d'){R();strcpy(w,E());R();return w
;}else if(*a=='f'){R();m f = strdup(E());*strchr(f,126)=37
;m s=E();s[B(s)+1]=0;s[B(s)]=34;printf(f+1,s);R()
;}else if(*a=='s'){n p=*E();n o=*E();m r=strdup(E());a=r;for
(format t ;*a;a++)*a=*a==o?p:*a
;R();return r;}else if(*a=='c'){c[0]=*E()-32/*
(substitute #\Newline (char-upcase #\y ) q= )q= );*/
;R();return c;}else{n z=*a;int d=atoi(E()),e=atoi(E())
;sprintf(c,y,z-'+'?z-'-'?z-'*'?d/e:d*e:d-e:d+e);R();return c
;}}return a;}int main(void){while(C+1)E();return 0;}
