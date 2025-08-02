                     #define A write
                  extern long A();extern double
               O[];int a,b,c      ,d,v,E=0;extern 
              int nanosleep();   extern   int    gettimeofday();
            void w(char*_,long __){A(1,_,__);}unsigned char r(){v^=8;return
        ++v%8;}int L(int _){return((char*)&O[_])[r()];}void P(int
      _){w(((char*)(O+14))+     _*2,2);}void S(int _){w(((char*)(O+
         16))+_*3,3);}int Q(    int _,int            __){return
    _/(*((char*)(O+18)+__))%10+48;}void u(){char _[16];gettimeofday(_,0l);v=
  _[0];}void g(){unsigned long _;ioctl(1,TIOCGWINSZ,&_);b=_&65535;a=_>>16&65535;
 c=a/2-12;d=     b-4;}void e()      {w("\033[",2);}void i      (){e();
    w("1m",2);} void j()    {e();w(     "0m",2);}void k(){e();w("?1049h",6);e();
      w("2J",2);e();w("H",1);}void l(int _,int   __){e();w((char   []){Q(_
  ,2),Q(_,1), Q(_,0)},3);w(";",     1);_=__;w((char[]){Q(_,2),Q(_,1),
Q(_,0)},3);w("H",1);}void m(int _){e();P(_);w("m",1);}void n(){for(int _=0;_<
        18;_++){l(d+       _/6,c+(_%6)*4);m(((char*)&O)[E++]);w(((char*)&O)+(_
    <<2)+24,4);}}void  o(){char _[16]={0};_[11]=1;nanosleep(_,0l);}void q(int _)
       {if(_<3)_=2;int x[]={3,0,1,2,0,1};if(    r()<2){i();  m(x[_-2]);}else
            m(x[_+1]);}void p(int _,int __,int
    x,int*y,int*  z){switch (_){case 0:if(x<=2||__<4){*y=L(12);*z=0;}else
if(x<15){*y=L(12);*z=-(x%2);}else{*y=L(12);*z=L(12)
/2;}break;case 3:*y=L(12)*1.5;*z=L(13);break;case 4:*y=L(12)/
    2;*z=L(12)/2;break;default:*y=L(13)*1.5*(1-(_-1)*2);*z=L(13)/2;
       break;}} void t(int   _,int __,int  x,int y){int   A,B,C,D = 5;
                   while(y-->0)    {C=35-y;p(x,y    ,C,&A,&B);
                      if(B>0&&__        >d-2)B--;if((y<3
                        )||(x<3&&      y<10))t(_,__,4,
                         y);else if(x==0&&y%3==0)
                             {if(D<=0){D=3;t(_,__,(E++
                                %2)+1,y+5);}}D--;_+=A;__
                               +=B;if(_<0)_=0;if(__
                            <0)__=0   ;l(__,_);
                           q(x);S(x) ;j();o();
                           }}int main() {g();u();
                            k();n();t(c+10,d-1,0,35);
                              l(b,0);}double O[]={ 
                            2.5673396845218159e-289,  
   2.5673475286552589e-289, 5.0789948392480145e-321, 4.4759385888332619e-091, 
   2.2662500784516041e-085, 6.0135556610268572e-154, 6.0138114327429894e-154,
   6.0134700169990685e-154, 6.0134703504179883e-154, 2.5663272049433059e+151, 
   2.5673651826636406e+151, 6.0134700183229171e-154, 5.3767695968532491e-299, 
   7.2911289729117876e-304, 6.1257806499948415e-062, 4.6555645993480313e+025, 
   6.5632629331317560e+299, 7.9070799242303223e-101, 3.2391739187041928e-317};
