#include <stdio.h>

#define maxc (prs >> 16)
#define maxr (prs & 0xff00) >> 8
#define find (col > 1)
#define endb || (prs & 16) && X(0) || chpa || (eols, 0)
#define lnst doln ? 0 : (init, 0) || (prs & 128) && X(0)
#define L    endb) || 0 || (find ? 0 : (rrr++, rrc = 0)) || (lnst
#define X(p) (dfc++ && ((prs & 48) != 32 || rrc < maxc) && ++ccl && \
             (find ? (bat = bit, bit = but, but = p, ccl == col && \
             (ret = bat + bit + but) + 1) : (las = las * 2 + \
             (((main(ccl + 1, cro - 1) + main(ccl + 1, cro) + \
             main(ccl + 1, cro + 1) - p) | p) == 3), occ |= las & 1, \
             printf(" %c", "_O"[las & 1]), ccl == 2 && (sta |= (las & 3) << 6),\
             0)))
#define _    || (find || rrc++, 0) || X(0)
#define O    || (find || rrc++, 0) || X(1)
#define chpa (find && col > ccl && ((ret = bit + but) + 1))
#define eols (!find && (cro == 1 ? (sta |= occ << 3) : cro == 2 && \
             (sta |= occ << 2), sta |= (las & 3) << 4))
#define init (find ? (ret = bit = but = 0) : (ocp = occ, las = occ = 0, \
             printf("\nL")), dfc = (prs & 192) != 64, ccl = 0)
#define doln !(dfl++ && (((prs & 3) != 2) || rrr < maxr) && \
             (++cro == row || !find))
#define recu (col =- col, (ccl = find ? rcf : rcl), cro = rro, 0 _ || \
             (rrc >= maxc ? 0 : (find ? rcf = ccl : (rcl = ccl), \
             main(-col, row))))
#define addl (lnst || (rro = cro, find ? rcf = ccl : (rrc = 0, rcl = ccl), \
             0) || main(-col, row) || (ccl = rcl + 1, 0) endb)
#define outp (find || printf("\n\nGEN %d STAT %ld\nEND\n", ++gen, \
             (long)ccl << 16 | cro << 8 | (sta | occ | ocp << 1) ^ 0x66))
#define GEN  endb) || (prs & 1) && addl || (outp, 0)), ret)); } int gen =
#define STAT ;long prs =
#define END  ;
#define LIFE int bat, bit, but, las, gen, ret, rcl, rcf, rro, rrc, rrr, \
             occ, ocp, sta, dfc; long prs; main(int col, int row) { \
             int dfl = ((prs & 12) != 4), ccl = 0, cro = 0; return \
             col == 1 && printf("LIFE\n"), (col < 0 ? recu : \
             (((ret = 0) || (prs & 8) && addl || 0 && (0

#include "life.d"
