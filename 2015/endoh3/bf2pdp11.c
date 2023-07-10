#include <stdio.h>

int main() {
    unsigned short n, mem[32768], *p;
    unsigned short *stack[256], **sp = stack, **sp2;
    char c;

    sp = stack;
    p = mem;
    *p++ = 0000401;  p++;           /* BR 1; DAT */
    *p++ = 0012700; *p++ =       1; /* MOV #1,R0 */
    *p++ = 0012701; *p++ = 0177777; /* MOV #-1,R1 */

    for(; (c = getchar()) >= 0; ) {
	switch (c) {
	    case '>':
		*p++ = 0005741; /* TST -(R1) */
		break;

	    case '<':
		*p++ = 0005721; /* TST (R1)+ */
		break;

	    case '+':
		*p++ = 0011102; /* MOV (R1),R2 */
		*p++ = 0005722; /* TST (R2)+ */
		*p++ = 0077200; /* SOB R2,0 */
		*p++ = 0010211; /* MOV R2,(R1) */
		break;

	    case '-':
		*p++ = 0011102; /* MOV (R1),R2 */
		*p++ = 0077200; /* SOB R2,0 */
		*p++ = 0010211; /* MOV R2,(R1) */
		break;

	    case '[':
		*sp++ = p;
		*p++ = 0011102; /* MOV (R1),R2 */
		*p++ = 0005722; /* TST (R2)+ */
		*p++ = 0077200; /* SOB R2,0 */
		*p++ = 0000401; /* BR 1 */
		*p++ = 0000403; /* BR 3 */
		*p++ = 0077202; /* SOB R2,-2 */
		*p++ = 0011707; /* MOV ???,R7 (need backpatch) */
		*sp++ = p++;
		break;

	    case ']':
		sp -= 2;
		*p++ = 0011707; /* MOV ???,R7 */
		*p++ = (*sp - mem) * 2;
		*sp[1] = (p - mem) * 2;
		break;

	    case '.':
		n = (p - mem) * 2 + 8;
		*p++ = 0012702; *p++= 2; /* MOV #2,R2 */
		*p++ = 0011112;          /* MOV (R1),(R2) */
		*p++ = 0104404; *p++ = 2; *p++ = 1; /* call write() */
		break;

	    case ',':
		fputs("instruction , (getchar) is not supported\n", stderr);
		return 1;
	}
    }

    printf("short main[32768] = { ");
    for (n = 0; mem + n < p - 1; n++) {
	printf("%d, ", mem[n]);
    }
    printf("%d };\n", mem[n]);

    return 0;
}
