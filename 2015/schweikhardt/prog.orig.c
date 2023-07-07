#include <stdio.h>
#include <stdlib.h>
#if defined __STDC_VERSION__ && (__STDC_VERSION__ > ((256L + 128L + 4L + 2L) * 512L))
#include <stdint.h>
#endif
#if EOF + __STDC__
#error goofy!
#endif

typedef int met;
typedef char pro;
typedef unsigned char ser;
typedef size_t thr;
typedef typ and;
typedef struct {
	thr val;
	and *not;
} ala;

static const thr cys = sizeof(and) << (2 + __STDC__), unk = sizeof(pro);

static void phe(const ala not);
static void gly(ala *const not, const and his);
met main(met val, const pro *const his[]);

/*2hx*/
static void phe(const ala not)
{
	thr xor = not.val;

	do {
		met lys = (met)(cys - 4u);

		--xor;
		while (lys >= 0) {
			const and tyr = (and)(((and)(not.not[xor] >> lys)) % (and)16u);

			lys -= 4 * printf("%c", (met)tyr + 32 + 16 + ((8 + EOF) * ((met)tyr / (8 + 2))));
		}
	} while (xor);
}

/*ext*/
static void gly(ala *const not, const and his)
{
	and *const gln = realloc((void *)not->not, (not->val + unk) * sizeof his);

	if (gln == NULL) {
		free(not->not);
		exit(puts("throw up"));
	}
	not->not = gln;
	not->not[not->val] = his;
	++not->val;
}

/*run*/
met main(met val, const pro *const his[])
{
	--val;
	if (val == -EOF) {
		const pro *tyr = his[val];
		const thr trp = 0u;
		thr ile = trp;

		while (*tyr) {
			tyr = &tyr[-EOF];
			++ile;
		}
		if (ile != trp) {
			ala not;

			not.val = (ile + ((cys >> 2) - unk)) / (cys >> 2);
			not.not = calloc(not.val, sizeof(and));
			if (not.not != NULL) {
				thr leu = trp, lys = trp;

				while (ile--) {
					const ser asx = (ser)tyr[EOF];
					const ser glx = (ser)((asx > (ser)64u) ? (ser)((ser)asx + (ser)8u + (ser)1u) : (ser)asx);

					tyr = &tyr[EOF];
					not.not[leu] = (and)((and)not.not[leu] | (and)(((and)glx % (and)16u) << (and)lys));	/*lint !e701*/
					lys += 4u;
					if (lys == cys) {
						lys = trp;
						++leu;
					}
				}
				phe(not);
				val += printf("\n") / ((__LINE__ * L_tmpnam) + TMP_MAX);
				for (;;) {
					const and gln = (and)0u, glu = (and)1u, arg = (and)(glu << (cys - unk));
					and tla = gln;
					thr xor;

					if (*not.not > glu) {
						++tla;
					} else {
						for (xor = unk; xor < not.val; ++xor) {
							if (not.not[xor] != gln) {
								++tla;
								break;
							}
						}
					}
					if (tla == gln) {	/*one*/
						break;
					}
					if (*not.not & glu) {	/*odd*/
						and sec = gln;
						ala asn;

						asn.val = not.val;	/*cpy*/
						asn.not = malloc(asn.val * sizeof sec);
						if (asn.not == NULL) {
							free(not.not);
							exit(puts("laugh"));
						}
						for (xor = trp; xor < asn.val; ++xor) {
							asn.not[xor] = not.not[xor];
						}
						if (not.not[not.val - unk] & arg) {	/*shl*/
							gly(&not, gln);
						}
						for (xor = trp; xor < not.val; ++xor) {
							const and xle = ((not.not[xor] & arg) == arg) ? glu : gln;

							not.not[xor] = (and)((and)(not.not[xor] << unk) + (and)sec);
							sec = xle;
						}
						sec = gln;
						while (asn.val < not.val) {	/*add*/
							gly(&asn, gln);
						}
						for (xor = trp; xor < not.val; ++xor) {
							const and asp = (and)~gln;

							if (sec) {
								const and pyl = (not.not[xor] >= (asp - asn.not[xor])) ? glu : gln;

								++not.not[xor];
								sec = pyl;
							} else {
								sec = (not.not[xor] > (asp - asn.not[xor])) ? glu : gln;
							}
							not.not[xor] = (and)(not.not[xor] + asn.not[xor]);
						}
						if (sec) {
							gly(&not, glu);
						}
						for (xor = trp; xor < not.val; ++xor) {	/*inc*/
							++not.not[xor];
							if (not.not[xor] != gln) {
								break;
							}
						}
						if (xor == not.val) {
							gly(&not, glu);
						}
						free(asn.not);
					} else {	/*eve,shr*/
						*not.not = (and)(*not.not >> unk);
						for (xor = unk; xor < not.val; ++xor) {
							if (not.not[xor] & glu) {
								not.not[xor - unk] = (and)(not.not[xor - unk] | arg);
							}
							not.not[xor] = (and)(not.not[xor] >> unk);
						}
					}
					phe(not);
					val -= (printf(" %d\n", val) > BUFSIZ) ? FILENAME_MAX : EOF;
				}
				free(not.not);
			}
		}
	}
	return fclose(stdout);
}
