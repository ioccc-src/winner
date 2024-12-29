/*
 * ag.c
 *
 * Anthony's Grep
 *
 * Public Domain 1992, 2021 by Anthony Howe.  All rights released.
 *
 * Synopsis:  ag <pattern> [files...]
 */

#include <stdio.h>
#include <stdlib.h>

#ifndef ARRAY
#define ARRAY		512
#endif

#define EXIT_MATCH	0
#define EXIT_NOMATCH	1
#define EXIT_USAGE	2
#define EXIT_ERROR	3

/*
 * Non-deterministic Finite-state Automaton
 *
 * An NFA is a directed graph whose nodes are called states.  Each
 * state is either a labeled state denoting a literal value, or a
 * NIL state that has no label.  Each state has at most two edges
 * leaving it.  There is only one start state and one final state,
 * which may be the same state.
 *
 * Various state-structures can be represented by an array.  These
 * structures have only one start point being the left most index,
 * and one end point being the right most index.
 *
 *	a		...[a]...
 *
 *	ab		...[a][b]...
 *
 *	^a		[bol][a]...
 *
 *	a$		...[a][eol]
 *
 *	a.b		...[a][wild][b]...
 *	        		_
 *			       v \
 *	a*		...[\][a][\]...
 *			     \____^
 *
 *	a?		...[\][a]...
 *			     \___^
 *			            _______________
 *			           /               v
 *	a|b		...[\][a][/][stop][pass][b]...
 *			     \_____________^
 *
 *	[a0-9]		...[class][a][0][1][2][3][4][5][6][7][8][9][stop]...
 *
 *	[^a0-9]		...[nclass][a][0][1][2][3][4][5][6][7][8][9][stop]...
 *
 *			            _____________  _______________
 *			           /             v/               v
 *	a|b|c		...[\][a][/][stop][\][b][/][stop][pass][c]...
 *			     \_____________^\_____________^
 *
 *			        _            _______________
 *			       v \          /               v
 *	a*(b|c)		...[\][a][\][\][b][/][stop][pass][c]...
 *			     \____^   \_____________^
 */

#define BOL		('\n')
#define EOL		('\n')
#define STOP		('\n')
#define WILD		(0)
#define CLASS		(-1)
#define NCLASS		(-2)
#define PASS		(-3)
#define JUMP(n)		(-4-(n))
#define CHAR(c)		(c)
#define ISJUMP(x)	((x) <= PASS)
#define ISCHAR(x)	(0 <= (x))

/*
 * Special member that is contained in all sets.  It is the location
 * of the WILD element that the pattern array is initialised with in
 * main().  Due to the way from() performs the pattern search, this
 * member is always the first member of a set and so can be used to
 * delimit sets.
 */
#define MEMBER		2

static int chr;
static int final;
static int nesting;
static int array[ARRAY], next;

/*
 * The number of states will always be related to the number of
 * unique sets in set[], which is less-than-equal-to next_set.
 * There is no need to bounds check dfa[][] since next_set
 * is bounds checked in from() and would cause an error well in
 * advance of overflowing the total number of possible states.
 */
static int dfa[ARRAY][ARRAY];
static int set[ARRAY], new_set, next_set;

void expr(char **);

/*
 * Allocate an element from the pool of free elements.  The
 * global variable 'next' points to the next free element in
 * the pool.  Return the allocated element's index.
 */
int
new(int c)
{
	if (ARRAY <= next) {
		fprintf(stderr, "ag: Pattern too long.\n");
		exit(EXIT_ERROR);
	}
	array[next] = c;
	return (next++);
}

/*
 *	literal
 *		.
 *		class
 *		character
 *		\ character
 *
 *	class
 *		[ ] ]
 *		[ range ]
 *		[ ] range ]
 *		[ ^ range ]
 *		[ ^ ] range ]
 *
 *	range
 *		-
 *		character
 *		range character
 *		character_low - character_hi
 *		range character_low - character_hi
 */
void
literal(char **p)
{
	int i, j;
	if (**p == '.') {
		new(WILD);
	} else if (**p == '[') {
		++*p;
		i = new(CLASS);
		if (**p == '^') {
			++*p;
			array[i] = NCLASS;
		}
		if (**p == ']') {
			++*p;
			new(CHAR(']'));
		}
		while ((i = **p) != ']') {
			if ((*p)[1] == '-' && i < (j = (*p)[2])) {
				while (i <= j)
					new(CHAR(i++));
				*p += 3;
			} else {
				new(CHAR(i));
				++*p;
			}
		}
		new(STOP);
	} else {
		if (**p == '\\')
			++*p;
		new(CHAR(**p));
	}
	++*p;
}

/*
 *	factor
 *		^
 *		$
 *		literal
 *		( expr )
 *		factor *
 */
void
factor(char **p)
{
	int i = new(PASS);
	if (**p == '^') {
		++*p;
		new(BOL);
	} else if (**p == '$') {
		++*p;
		new(EOL);
	} else if (**p == '(') {
		++*p;
		++nesting;
		expr(p);
		if (**p != ')') {
			fprintf(stderr, "ag: Missing ')'.\n");
			exit(EXIT_ERROR);
		}
		--nesting;
		++*p;
	} else {
		literal(p);
	}
	if (**p == '*') {
		++*p;
		array[i] = JUMP(next);
		new(JUMP(i+1));
	} else if (**p == '?') {
		++*p;
		array[i] = JUMP(next);
	}
}

/*
 *	term
 *		factor
 *		term factor
 */
void
term(char **p)
{
	while (**p != '|' && (0 == nesting || **p != ')')  && **p != '\0')
		factor(p);
}

/*
 *	expr
 *		term
 *		expr | term
 */
void
expr(char **p)
{
	int i, j;
	i = new(PASS);
	term(p);
	while (**p == '|') {
		++*p;
		j = new(PASS);
		new(STOP);
		array[i] = JUMP(next);
		i = new(PASS);
		term(p);
		array[j] = JUMP(next);
	}
}

/*
 * If element pointed to by 'p' is CLASS, return true if 'c' is in
 * the class.  If the element is NCLASS, return true if 'c' is not
 * in the class.  Pass back the end of the character class in 'p'.
 */
int
inclass(int *p)
{
	int i = 0, j = 0;
	if (array[*p] == CLASS || (j = array[*p] == NCLASS)) {
		while (array[++*p] != STOP)
			if (array[*p] == CHAR(chr))
				i = 1;
	}
	return (i ^ j);
}

/*
 * Return true if the end point (final state) can be reached
 * from element 'p' without crossing any labeled elements.
 */
int
isfinal(int p)
{
	return (
		final || p == next || (
			ISJUMP(array[p]) && (
				(array[p] != PASS && isfinal(JUMP(array[p])))
				|| isfinal(p+1)
			)
		)
	);
}

/*
 * Find all labeled elements reachable from element 'p' and add to
 * the global set 'new_set' those that are labeled with global 'chr'.
 * 'final' is true if the final state can be reached.
 */
void
from(int p)
{
	int i = new_set;
	if (next <= p)
		return;
	if (ISJUMP(array[p])) {
		if (array[p] != PASS)
			from(JUMP(array[p]));
		from(p+1);
	} else if (WILD == array[p] || array[p] == CHAR(chr) || inclass(&p)) {
		/* If element 'p' already a member of set 't' then return. */
		while (i < next_set)
			if (set[i++] == p)
				return;
		/* Can we reach the final state from here? */
		final = isfinal(p+1);

		if (ARRAY <= next_set) {
			fprintf(stderr, "ag: Out of space.\n");
			exit(EXIT_ERROR);
		}
		/* Add element 'p' to set 't'. */
		set[next_set++] = p;
	}
}

/*
 * Return true if the given string matches.  The search string must
 * be of the form "\ntext\n\0" in order to handle line anchoring.
 */
int
match(char *p)
{
	int state, i, j, k;
	final = state = 0;
	while (*p != '\0' && 0 <= state) {
		if (0 < (i = dfa[state][*p])) {
			/* Transition on known DFA state. */
			state = i;
		} else {
			/* Perform lazy DFA evaluation from NFA.
			 *
			 * Compute new_set, which represents a transition
			 * from the current state's set on character *p.
			 * dfa[state]['\0'] contains the set[] index for
			 * the current state.
			 */
			chr = *p;
			i = dfa[state]['\0'];
			j = new_set = next_set;
			do
				from(set[i++]+1);
			while (set[i] != MEMBER);

			/* Determine if this is a known set or not. */
			i = k = 0;
			while (i < new_set) {
				if (set[i] == MEMBER) {
					j = new_set;
					++k;
				}
				if (set[i++] == set[j]) {
					if (next_set <= ++j) {
						j = new_set;
						if (set[i] == MEMBER) {
							/* Known set found. */
							next_set = new_set;
							break;
						}
					}
				} else {
					j = new_set;
				}
			}
			if (new_set < next_set)
				/* New set found. */
				dfa[++k]['\0'] = new_set;
			state = dfa[state][*p] = final ? -1 : k;
		}
		++p;
	}
	return (state < 0);
}

int
main(int argc, char **argv)
{
	int error;
	FILE *file;
	char *name, line[BUFSIZ+1];

	if (--argc < 1) {
		fprintf(stderr, "usage:  ag <pattern> [files...]\n");
		return (EXIT_USAGE);
	}

	/* Initialise array[] = [pass][3][wild][1]... */
	new(PASS);
	new(JUMP(next+2));
	new(WILD);
	new(JUMP(next-1));

	expr(&(*++argv));

	*line = BOL;
	next_set = 1;
	error = EXIT_NOMATCH;
	do {
		name = "-";
		file = stdin;
		if (1 < argc && **++argv != '-') {
			if (NULL == (file = fopen(name = *argv, "r"))) {
				fprintf(stderr,
					"ag: Failed to open '%s'.\n", name);
				error = EXIT_ERROR;
				continue;
			}
		}
		while (fgets(line+1, BUFSIZ, file) != NULL) {
			if (match(line)) {
				printf("%s:%s", name, line+1);
				error = EXIT_MATCH;
			}
		}
		fclose(file);
	} while (1 < --argc);
	return (error);
}
