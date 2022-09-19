#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#define e(t, v, w) n t(u x, u y) { n a = sqrt(x+y); r ((v - a) * (w - a)); }
#define w while(
#define r return
typedef char u; typedef short q; typedef double n;
u *z = "Z«åª®éÕšµf®¦nyZf«U^¶š]zêi–i[m¶éª­¦V§e–¾ZùjUg\x3òŠpX¬©PH«Ú•û\b\vŞHO.ƒQf\x1d‡‰ï÷S7|)=Ùn\x4!E<›Z¦\x1flvšd(r³¼ıËÅ€ñÂ×¼ıÀc¨-|¦]Ä«IÿW—R^©è\x2""C©ƒÉOæ¢\vDh\rïÆxÕ¼Íöc\thÕºşÉX+:Õìq³|¯\x1c×Îg„¶s‰ïøA(\x11""DÑ\x1d:ê×\x1bk@\x11""E-Ès¹Ä»\x2+\x4I¼jT®óŒÇ{ša×0\a+qm¸\aIÍß\x17\x18ÍGù@İ\v[vİ…ã¨-|¦û:•\f­2Oe]†Uºí\x10×)u\rY]¾>£Ûw{3\x19\v""acC8ÿ5é\bÿ„lJnsy.:Ø­3rKx'ò'!%Â¹ş|skq¢C©³&\x15K\x4""fA—‰¢r7]ùÛ€z%¿‡CJ­^}´Ÿ×½Z\n;L\x1aN#ùNìG®skq¢K!ô‰EŒ\x17ÿãzàw›ºìeTD²tõİ[_›•JË¼6Ü\x3\b¤F& ]’ÚˆéşrJs<–5I;ƒXdºÿåŒ\x17³]2IŸÂ«æíÚãèG×\"èf}Án“öÀˆãj§Î%óˆå\nªc­ÌÔ8À±èRM7ƒ±ùµ\r_\x17\x19\a(+u\x1d=IÌÙ@ÈCl\x16ˆÇåïÆ\x1f""eåRìy¯÷è!.\x1f`åuW&„¦÷>–İ…ë\x18Ş;ÂÜ¶‹Fn›vAEÕ+qnVR’eŸE<eƒ!fÛå[\x17#…»IÌùnàÄ…•hÓŞù\x1c""7—%×pÖ³éf\x19\a\vŞ;uIÊ?ŒµI1$Â+û›vŞ\x5Æ,yËODéd*èfïH²]\x3ÚlõLŸQsĞ{™¤„dêvİ×ï€§ÂW\x10", x, y;
n g() { r (n)rand()/18972; } n t, v; q F, B, C; e(a, 0, 3.0) e(b, 3.0, 4.125) 
e(c, 4.125, 9) u f(n (*h)()) { do { t=g() * 6.283184; v = sqrt(g() * 72); y = 
sin(t) * v; x=cos(t)*v; } w (h(x*x,y*y)>=0)||(fabs(x) > 5) || (fabs(y) > 5));
r ((y+5) * 11) + x + 7; } u k(q x, u l) { u o = 0; F = 0; w F < 189) { B =C =
0; w 1) { y = ((z[F/4]>>((F++%4)*2))&3) - 1; if (y&2) 
break; C = (C*2)+y, ++B; } if (!(C - x | B - l)) r (o<26)?o+0x61:((2108973>>(
(o-26)*8))&47); ++o; } r 1; } u s[1079]; u *E(u v) { u *x = s; w v--)w *(x++)
); r x; } main() { q A = 0, B = 0, C = 1078; u l = 0; u *p = s; srand(time( 0
) ); w C) { A = (A*2) + ((((z[B/8+48]+114)^2)>>(7-(B++%8)))&1),++l; x = k(A,l
); if (x-1) { *(p++)=x, A=l=0, C--; } } printf("%s%s %s%s%s\n", E(0), E(f(c))
, E(f(a)), E(1), E(f(b))); }
