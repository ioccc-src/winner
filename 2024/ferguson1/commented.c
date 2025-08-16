/*
 * Here I will guide all you sinning Oregon Trailblazers, at least a little bit.
 * Very little as the case seems to be given how much the code changed since I
 * did this one. Can YOU blame me for not trying to keep this updated? If you
 * can try looking at prog.c again.
 *
 * Please note that the order of events (the q = x(0,23)) might be in a
 * different order than the prog.c as some were added quite late and I just
 * pushed them in in prog.c without much thinking (which actually caused some
 * problems that had to be fixed). In prog.c the event numbers are 0,22 (a bug
 * in the submitted code was fixed - the switch was x(0,23) but there is no case
 * 23 there) but here you see it's 0,23 and the order is different. The son
 * mocking you if you eat his frozen body is not tied to an event in prog.c but
 * it is here.
 *
 * Finally this code is from an earlier version so some of it might be missing,
 * not just the events, and not just the gotos, but potentially other things
 * too, possibly bugs that were fixed in prog.c but are not here (and no more
 * bugs remain in prog.c). But I believe this is more than enough to give you an
 * idea though if that is the case. If that's not clear...
 *
 * WARNING: this code and its comments are not up to date. I wrote 116 before
 * filtered through the cpp and 134 after the cpp and I didn't wish to
 * repeatedly revisit this file trying to explain everything. As it is I barely
 * finished this in time. After publication this was updated with the complete
 * version as well.
 */
#include<stdio.h>
#include<string.h>
#include<time.h>
#include<stdlib.h>
#include<unistd.h>
/*
 * this is rand(from, to) and is used strictly to save bytes. This comes
 * before the variables to shut up some compilers warning about 'shadowing
 * variables', despite the fact that would be rather on theme of this program.
 */
long x(long y, long z){ return (rand()%((z)-(y)+1))+(y); }

unsigned m,D,Q,v,l,Y,f,X,z,B,i,h,
/*
 * notice the spelling out of 'rude' and (with the type 'long' and below it
 * ends up spelling out rude long OREGON TRAIL. This is all true and in some
 * senses of the word rude the real thing was too, although I did try and keep
 * it as classy as possible with the parody of 'A Pact With the Devil' (with
 * sometimes dark and biting irony and mostly full of jokes).
 */
            r,u,d,e; long
/*
 * Yes it's perfectly legal to have the same variable more than once as long
 * as it's the same type. This was useful to spell out OREGON TRAIL.
 *
 * The o array, which spells out OREGON used to be TRAIL but to save bytes for
 * something else I undid this. It looks cleaner now anyway.
 *
 * Also notice that the prog.c does not make use of the variable 'I' for
 * bullets. Instead it just manipulates E in a different way. That was added
 * with under two weeks left in the contest to yet again shave off more bytes to
 * get even more gotos in. Yes I am seriously disturbed not only in that I can
 * figure this out but more importantly that I even considered it. Yes this also
 * means that the 'j'' macro is not there either. I don't believe this
 * enhancement is in the alt code either but maybe it is.
 */
    O,R,E,G,O,N, T,R,A,I,L,
    *o[]={ &O,&R,&E,&G,&O,&N,&I} ,a,t[7],q,M, b=666,c,W;
/*
 * y is the data file buffer, K is the data FILE *, J is
 * the length read (which we don't actually care about the J as long as
 * getdelim() does not return < 0).
 */
char *y;
FILE *K;
size_t J;

/*
 * saves bytes - every time bullets are used we have to update how much was
 * spent on them in case one goes to the fort.
 */
#define j E=I/5;
/*
 * Death macro. This is not the same as the winning death macro, however,
 * although one always 'goes to hell' - and as you'll see there is an obscene
 * amount of gotos in this file - just like the original BASIC version. I am not
 * sure if I can explain it all because it's that twisted.
 */
#define w(i) { V(i); V(4); goto hell; }
/*
 * Z determines where in the single char * that holds the (currently) 172 NUL
 * terminated char * strings. These strings are always of the same size but they
 * can have any value as long as it retains its value when XORed with 127.
 *
 * Oh actually the first string is NOT NUL terminated. This is because it's not
 * needed; it's not part of the game but only a padding and part of
 * misdirection.
 *
 * This also saves bytes.
 */
long Z(long x){ return x *1663; }
/*
 * this scanf macro gets past an annoying issue with scanf() where it does not
 * consume input on invalid input which will cause the same input to be read
 * which in this case causes an infinite loop, flooding the screen. Not having
 * this as a macro has led to other problems btw.
 */
#define S(x,z) while(scanf(&y[Z(x)],&z)!=1)while(getchar()!='\n');

/*
 * I am quite proud of the concept here, although it's the encrypted version
 * (not this submission) that is really quite something (and very thematic).
 * Anyway here the nice thing is as briefly mentioned above, near 200 char * can
 * be in a single char *!. As I already explained this in detail
 * in the remarks.md I refer you to it.
 */
void V(long x) { printf("%s",&y[Z(x)]); }
/*
 * shoot success function. I is number of bullets, Y is the number of times you
 * shot (so it gets better as you shoot more though it's still chance). 'a' is
 * non-zero if you got sick and could afford the doctor (a is if you got
 * dysentery but can't afford the doctor). 'f' is injured (and can't afford
 * the doctor). What that means is that if you get injured or sick a second time
 * if you can't afford the doctor you will be penalised. NO: there is no flag for
 * injured but saw the doctor; that was a choice I had to make even if in some
 * cases it might not make sense (keep in mind that depending on the type of
 * wound it might not affect your ability to hunt or shoot at all but with
 * dysentery if you are sick you're sick).
 */
long k(void) { ++Y; return I > 0 ? x(1, 101) + Y > 53 + a ? 9 : 0 + f ? 9 : 0 : 0; }

int main(void)
{
    srand(time(0));

/*
 * the DATA macro allows for portability for systems that do not have emoji
 * support (like one system of mine - yes even modern systems might not,
 * console only especially). It could also be used to place the original
 * strings but that would ruin the theme of parody - but it could work as
 * long as the order and blocksize is the same (padded with addpadding.c).
 */
    K = fopen(DATA, "r");
/*
 * getdelim() with EOF is the magic point: it allows for NUL bytes to be in a
 * single char *. This is how I managed it and with the macro (S) and function
 * (V) above as well as printf (which I use in a couple places) everything is
 * set up perfectly to not go beyond the valid contents of the string. Yes the
 * fact printf and scanf are used does mean that some strings are not encrypted:
 * those that start with a BEL byte ('\a') or those that start with '%'.
 */
    if (!K || getdelim(&y, &J, EOF, K) < 0) goto hell;
/*
 * yes basically immediately goto hell beings.
 *
 * Please don't ask a tortured soul to try and parse all the jumping. There
 * are 60 gotos in this file (well as part of the code - not the comments
 * obviously). I will try explaining the code as we get there but not the
 * gotos themselves. Obviously I'm a tortured soul having done what I have
 * done and I don't want to torture myself more.
 */
    goto s;
    /*
     * this label is devious - a huge chain that goes from the beginning of
     * main() to the end to the beginning to the ..to the middle (or somewhere
     * between the two ends).
     */
    aa:goto dd;

    u:
    goto M;
    /*
     * this is actually part of the 'aa' above
     */
    ee:goto ff;
    jj:goto kk;
/*
 * this is the purchasing code, either at the fort or original purchasing
 * (if z != 0 it's at the fort)
 */
    N:
    for (X = 1; X < 6; ++X)
    {
/*
 * this funny construct evaluates to X+5. The reason we need + 5 is the
 * string location in the data file. Remember that V() is based on a
 * blocksize and the NUL byte (that stops it from going beyond the data
 * we care about). It so happens that the strings we need are +5 in the
 * file. That means that instead of printing by byte location we print
 * by string number.
 */
        x:
        V(X+--(int) { 6 }
        );
/*
 * z == at fort
 */
        if (z)
        {

/*
 * 3 is %ld
 */
            S(3, t[X])
/*
 * no negative numbers and no number > 666 (playing into the theme
 * more)
 */
                if (t[X] < 0 || t[X] > 666)
            {
/*
 * 14 is the error message with a joke at the end: 'Or 0, if you
 * trust the Devil'.
 */
                V(14);
/*
 * x shows the prompt again and wants valid input
 */
                goto x;
/*
 * no this is not a mistake although I believe in parts of this
 * code this is kind of done anyway where two gotos are next to
 * each other and they actually both jump, due to a label in
 * between.
 *
 * Instead this is a joke: heaven is unobtainable for someone
 * who 'signed the Devil's book' (we know this because that's
 * what those in the past have said). But as you'll see later
 * the heaven label is actually in between a 'while' and the
 * death macro. The point is you never can 'goto' heaven and you
 * ALWAYS go to hell (though sometimes implicit goto).
 */
                goto heaven; l:goto C; JJ:goto W; qq:goto rr;
            }
/*
 * T == how much money you started out with (1666, also thematic)
 * and L is the temporary value of that so we can verify you don't
 * overspend at the fort
 */
            L = T;
/*
 * u is a temporary value here: t is the array that corresponds to
 * o. We have to do it this way as otherwise we'd mess up the original values
 * (O,R,E,G,O,N). This loop just subtracts the amount spent per item and if it
 * ever goes below < 0 you overspent.
 */
            for (u = 0; u < 6; ++u) L -= t[u];
            if (L < 0)
            {
/*
 * overspent at fort message
 */
                V(46);
/*
 * we have to clear out the array for them to try again
 */
                memset(&t, 0, sizeof t);
                goto v;
                ZZ:goto II;
            }
        }                                         /* end fort */

/* initial purchases */
        else
        {
/*
 * not at the fort: original purchase. Again 3 is %ld and o[X]
 * (yes it's fun it spells out 'ox' with an upper case X as one of
 * the things you can buy are oxen. Anyway X (see above) just is the
 * index into the array so we can verify values (and set them of
 * course).
 */
            S(3, *(o[X]))
                if (*o[X] < 0 || *o[X] > 666)
            {
                V(14); goto x;
            }
/*
 * 1666 is the start value of money (well actually 6666 but you have
 * to read the first string or play to figure out what happens) so
 * this just checks that you don't overspend. The -0 takes two extra
 * bytes but it's totally worth it to be thematic.
 */
            T=1666-O-R-E-G-0-N;
/*
 * overspent, start over
 */
            if (T < 0)
            {

/*
 * right away there is a message that not only questions the
 * morality (or 'morality') of the PC (player character) but ALSO
 * the narrator: in ambiguous ways of course.
 */
                V(46);
/*
 * I wanted to do:
 *
 *      O=R=E=G=O=N=0
 * but this is multiple unsequenced modifications which is
 * undefined behaviour (UB). And although it would be
 * fitting in theme for the character it is not a good idea
 * to invoke UB so I did not (and it allowed yet another
 * goto).
 */
                O=R=E=G=N=0;

/*
 * nasty gotos here
 */
                goto v;
                c:
                goto d;
                oo:goto pp;
            }
        }
    }                                             /* end purchasing code */
/*
 * z == at fort - simply return to where we started (the prompt or rather
 * right after it). This was the first goto in the code when I programmed
 * this and it was very early on.
 */
    if (z) goto A;
/*
 * in this case we have to set I to a value based on E but that's only
 * done when purchasing. Yes this means that I/E modify each other
 * depending on where we are in the code
 */
    B:
    I = E * 5;

/*
 * tell player how much money left after spending
 */
    printf(&y[Z(12)], T);

/*
 * go back to 'fort' choice.
 *
 * Yes we get here even though the if (z) above might suggest it
 * otherwise.  I'll explain what that code does when we're there. On the other
 * hand...there is some code you might want to carefully analyse when we do get
 * to F:.
 */
    if (z) goto F;

/*
 * bastardised Duff's device
 */
    switch(1)
    {
/*
 * with a number of twists including a label before the case (you'll see
 * this again). No this does not mean that when the switch starts we
 * goto cc first; that only happens when the code does a goto dd;!
 */
        dd:goto cc;
        I:
        goto R;
        default:
            do
            {
/*
 * b == hp/stamina, M == mileage. The Oregon Trail was 2170 miles
 * (the original game had it at 2040 but this is historically
 * inaccurate). If it goes below 0 you also are done, just like the
 * original game.
 */

                if (b < 1 || M < 0 || M > 2169) break;
/*
 * Yes I'm probably disturbed. But can you blame me after looking at
 * the BASIC? Perhaps you would like to 'pray for me'? No. Don't. But
 * you get the idea. If you don't yet you will!
 */
                goto i;
                e:
                goto D;
                P:
                for (X = 1; X < 7; ++X) if (*o[X] < 0) * o[X] = 0;
/*
 * print stats: food, ammo, clothing, oxen, supplies, money,
 * hp/stamina, miles
 */
                printf(&y[Z(11)],R,I,G,O,N,T,b,M);

/*
 * this range might be smaller than the original: not sure if it
 * is even part of the original.
 */
                if (x(0, 1)) goto Q;
/*
 * it's merely coincidence that the label R is checking if R <
 * 14.
 *
 * Anyway R is food. If < 14 it tells you you better do some
 * hunting or buy some food soon before you starve. Or don't.
 * Because let's face it, you'd deserve it. The character in the
 * game obviously!
 */
                R:
                if (R < 14) V(37);
                if (z)
                {
/*
 * make choices at fort
 */

/*
 * do you want to hunt or continue? (2 == %u).
 *
 * Somewhere here I noted how F: will goto f; which will set z to 0. So the
 * question is can this actually be reached? Another question: what is the point
 * of it? Why ask in one place if you want to hunt or continue and another place
 * if you want to hunt, stop at the next fort or continue? The latter makes more
 * sense but in order for this code to be reached we have to invert the logic of
 * the if above (make it !z). One compiler thinks this is reached but the
 * question you have to ask yourself is: is it? Or perhaps: can you figure out
 * how to trigger it? What I am doing is intentional but it's very confusing.
 */
                    r:
                    V(43); S(2, r)
                        switch (r)
                    {
/*
 * yes a label before a case again. If memory serves me
 * right this is the nasty one that is 8 levels of gotos (I
 * think 8).
 */
                        H:
                        goto G;
/*
 * black cat, case 13!
 */
                        case 1:
                            goto T;               /* hunt */
/*
 * what, a label between the case statements before a
 * break that actually does not exist (see below, no
 * break but two gotos, counting the above goto T!)? Yup.
 */
                            i:
/*
 * if oxen < 1 and you haven't seen the message yet (will
 * reset it if oxen are brought above 0 again), tell the
 * player that they have run out of oxen and they must
 * walk the rest of the way (or else they can buy some if
 * they have any money left). In the original game I
 * think no oxen == you lose but in reality one might be
 * able to buy (or in this case - though it's not done I
 * don't think unfortunately as I only just thought of it
 * and it's too late now, unless it is done - steal).
 * Plus the will to survive is something that you might
 * not really understand (and this is a theme later on)
 * where you'll (until you lose all hope) do anything
 * even crawl.
 */
                            if (O < 1)
                            {
                                if (!v) V(v=15);
                                O = 0;
                            } else v = 0;
                            goto e;
/*
 * Yes there's a goto after the label before the next case
 * outside of the if!
 */
                        case 2:
                            goto X;
                            nn:goto oo;
/*
 * yes another label.
 */
                            F:
                            /*
                             * so here we go to f. What does that do? It sets
                             * z=0; so the question is can the if(z) check that
                             * does S(2,r) (after V(43), label r) can be
                             * reached. At least one compiler got confused by
                             * what does or does not happen, warning about it.
                             * I'll say more there too.
                             */
                            goto f;
                            a:
                            goto c;
                        default:
                            goto r; O:goto E;
                    }
                }
                else
                {
/* outside the fort: do you want to stop at the next fort, hunt
 * or continue (1, 2, 3)
 */
                    y:
                    V(42);
/*
 * 2 == %u and r is an unsigned int
 */
                    S(2,r)
                        switch (r)
                    {
/*
 * yup another label inside a switch that's not a case
 */
                        M:
                        V(1);
/*
 * t is the array that is used for purchasing but I'm not sure
 * now how we got here because it's so messed up. The labels are
 * below us and above us.
 */
                        v:
                        memset(&t, 0, sizeof t);
                        goto N;
/*
 * why case 3 first? It's not needed now admittedly but at first
 * it might have been for a fall through; not sure. It seems
 * unlikely as I think I always had a goto but I don't know.
 */
                        case 3:                   /* continue */
                            goto X;
                        case 1:                   /* go to fort */
                            z = 1;
                            M -= 45;              /* remove 45 miles (yes I think it's a strange system too but one of the few carry-overs) */
/*
 * L is below us but it just jumps to v which is above
 * us, kind of like hell and heaven (purportedly)
 */
                            goto L;
                            A:
/*
 * Remember the if(z) goto A; ? Well that's after purchasing at
 * the fort (no rest in the original game, nothing else, just
 * purchasing). What we're doing here is updating the amount
 * spent (at the fort we already verified they had enough money
 * and it's almost the same logic as initial purchases)
 */
                            for (X = 1; X < 7; ++X)
                            {
/*
 * o == the array of values spent plus how many bullets (I == how many bullets,
 * E == how much spent on them; in the prog.c E is both). The t array is how
 * much spent at the fort on each item which is why we add to the cost spent
 */
                                *o[X] += t[X];
/*
 * T is total money left and X[t] is how much was spent at
 * the fort
 */
                                T -= X[t];
                            }
/*
 * this will update how many bullets one has. If you go
 * back to the B label you'll then see how and why we had
 * two checks of if (z) even with a goto for each. You
 * can also figure out that the stats are printed prior
 * to jumping back into the Duff's device (the
 * bastardised one) loop (game loop). It does (I think) a
 * goto F; which then does a goto f;
 */
                            goto B;
                        case 2:                   /* hunting */
                            goto T;
                        default:                  /* invalid input, try again */
                            goto y;
                    }
                }
/*
 * when choosing fort option we goto L; and that does a goto v;
 * and v is at the top of the function (very early on)
 */
                L:
                goto v;

/*
 * when l == 1 the character is hunting.
 */
                T:
                l = 1;
/*
 * require 9 bullets; if < 9 it's a (as often is the case) a
 * mocking message.
 */
                if (I < 9) V(16);
                else
                {
/*
 * otherwise: enough bullets; remember k() is the success of
 * hunting
 */
                    if (k())
                    {
                        if (x(1,10) > 5)
                        {
/*
 * 52 == best shot in hunting. But it also is a chance
 * of poisoning by the devil.
 */
                            V(52);
/* increase food
 */
                            R += 23;
                            if (!x(0, 9))
/*
 * poisoned. But why 17? Because that's the
 * message number for it. I'll say more when we
 * get there. You'll notice that other times I
 * also do something like V(a=...); to save
 * bytes and to compact code.
 */
                                i = 17;
                        }
                        else
                        {
/*
 * 51 is a reference to a scene (episode 2 I think)
 * of Miracle Workers: The Oregon Trail. You can
 * read it in strings.loc.txt or play until it
 * happens.
 */
                            V(51); R += 18;
                        }
                    }
                    else
/*
 * mock user for missing a helpless animal standing
 * still
 */
                        V(53);
/*
 * take 9 bullets either way
 */
                    I -= 9;
/*
 * j updates E based on I
 */
                    j
/*
 * lose 45 miles. Yes that means that if one were low on
 * food they would have to go quite a distance in order to
 * get food which means they would have a hard time to get
 * it which makes the jokes more ironic.
 */
                        M -= 45;
                }
/*
 * no longer hunting
 */
                l = 0;
/*
 * no longer at fort
 */
                f:
                z = 0;

/*
 * if no food we do something that many people might not want to
 * think about but the character would have no qualms about it
 * either way. Assuming of course that they have any oxen left...
 */
                X:
                if (R < 1)
                {
                    /*
                     * if 40+ oxen (spent on, not amount) left...
                     */
                    if (O > 39)
                    {
                    /*
                     * eat an ox and show the message of its ghost. Over time the
                     * ghost of the ox(or in some cases the ghosts of oxen) will
                     * taunt the character as they progress. There are two
                     * different messages though: one vengeful over a petty thing
                     * and one for food. The vengeful one happens as another
                     * event in the alt code though; I put it here too because it
                     * was good enough to have in the main prog.c and I could not
                     * fit it in otherwise. As it is I had to change some code
                     * about to fit it in.
                     */
                        V(e=x(0,1)?18:19);
                    /*
                     * remove oxen amount
                     */
                        O -= 40;
                    /*
                     * hold on: no food added? Well one might argue it was all eaten
                     * but check out q. Note it adds 40 but during the feeding stage
                     * of the loop some food will be taken away. Notice too how q
                     * is inside a nested switch's case!
                     */
                        goto q;

                        o:
                        goto Y;
                        ii:goto l;
                    }
                    /*
                     * starve to death message. Yes I know people don't starve right
                     * away. I also know that if one has not eaten in a certain amount
                     * of time then eating too much right away can kill you. But this
                     * is how it ends up being in the original. Actually in the
                     * original you don't even get the chance to eat an oxen and if you
                     * run out of oxen I think you also die even though that's totally
                     * unrealistic.
                     */
                    w(24)
                }
                else
                    goto K;
/*
 * regular events outside of the mountains
 */
                Y:
                switch (q = x(0, 23))
                {
/*
 * yes more goto labels inside a switch not connected to a
 * case.
 *
 */
                    s:
                    goto h;

                    case 23:
    /*
     * a dark one: if your son gets lost and freezes to death
     * you have free food. Yeah I know. But it happened (if
     * not exactly this way) on the trail. The ghost of the
     * son mocks you at this point.
     */
                        if (d) V(39);
    /*
     * e == ate an ox, the ghost mocks you
     */
                        if (e) V(25);
                        break;
                    case 1:
    /*
 * Indians show you where to find...a heart attack
 * on a plate. Fast food. Something that did not
 * exist at the time (at least not like this).
 */
                        V(95); R += 5;
                    break;
S:
/*
 * if you have too much ammo and this event is triggered
 * you're going to die. Yes the event is at S but we goto S via
 * goto g; to get to the actual code so that the code for the
 * event is not at the case itself but where it jumps back to.
 * The 'g' is past the return 666; of main().
 *
 * Yes an event from a case is not in that case but at a
 * label inside a switch. This event is a fire but your wagon
 * train has so much ammo it blows up.
 */
                    if (I > 1999) w(27)
/*
 * if there isn't too much ammo just report a fire and
 * reduce certain things like mileage, supplies and food.
 */
                            V(82);
                    M -= 9;
                    N -= 5;
                    R -= 20;
/*
 * okay this is devious. Where is Z? Right after the goto g
 * (which does goto S;) and the Z is simply 'break' so that it
 * goes back to the switch only to go to the next part of the
 * code!
 */
                    goto Z;


/*
 * Casper!
 */
                    case 18:V(26); break;
                    case 13:V(28); break;        /* black cat */
                    case 2:
/*
 * if O > 0 and no flat oxen yet a flat oxen (like a flat
 * tyre - a reference to Miracle Workers: The Oregon Trail).
 * Actually though - it's not quite that. Even if you don't have
 * any oxen it still shows a message. You have to check it out to
 * understand why.
 */
                        O -= 40;
                        V(71);
                        break;
                        mm:goto nn;
                    case 3:
/*
 * unpotable water == dysentery
 */
                        V(a = 76);
                        b -= 70;
/*
 * yes this skips the mountains part. They go straight to the
 * doctor. There is a thematic joke with it but this means they lose
 * a turn. They will have to 'continue' on their journey on the next
 * turn. I think I bring this up a bit more in the remarks.md.
 */
                        goto W;
                    case 4:
/*
 * ironic joke with heavy rains
 */
                        V(77);
/*
 * lose supplies and miles
 */
                        N -= 7;
                        M -= 7;
                        break;
                    case 5:
                    case 10:

/*
 * yes q is one of two values (or at least two, in some cases in
 * this switch I believe there are other values it can be as well,
 * including one nested switch setting the value again for more
 * confusion) and this determines the event
 */
                        if (q < 6)
                        {

/*
 * Blackbeard attacks
 */
                            V(78); if (k())
                            {
/*
 * drive off Blackbeard, gain food and supplies
 */
                                V(81);
                                R += 9;
                                N += 3;
                            }
                            else
                            {
/*
 * got injured due to lousy shot.
 *
 * Lose money and lose all bullets.
 */
                                V(f = 79); b -= 80;
                                T /= 3;
                                I = E = 0;
                            }
                        }
                        else
                        {
/*
 * riders ahead - they don't look hostile. Why don't you rob
 * them blind?
 */
                            V(56);
                            if (k())
                            {
/*
 * a really ironic and somewhat dark joke occurs here
 */
                                V(a = 29);
/*
 * gain some money
 */
                                T += 70;
                                goto W;
                                cc:goto ee;
                            }
                            else
                            {
/*
 * well it was foolish to try and rob them apparently. 'f' is
 * injury but we set it to 62 (non-zero) in 'V()' because 62 is
 * the message to print.
 */
                                V(f=62);
/*
 * lose miles and health/stamina
 */
                                M -= 50;
                                b -= 35;
                            }
                        }
                        break;

                    case 9:case 19:V(30); break;
/* ox just kicked a bucket */
                    case 20:V(32);  break;
/* devil in mirror */
                    case 21: V(31); break;
                    case 6:
/*
 * yes the entire event is at label S which is in another switch (partly for
 * obscurity and partly as I was running out of places to put them). Then it
 * jumps back to Z for the break so that the mountains code can happen! That's
 * assuming you don't have too much ammo of course... If you do the wagon train
 * blows up from the flames. Otherwise you just lose bullets, food, mileage and
 * maybe something else (or maybe something else than these entirely - not
 * sure).
 */
                        goto g;
                        Z:
                        break;

                    case 22:V(49);               /* Elf event */
/* ox stuck in a hole - thankfully not a donkey! */
                    case 17: V(72); break;
                    case 7:

                        V(83);
/*
 * lost your way in heavy fog but due to a strange map in the last book you read
 * you didn't lose much time.
 */
                        M -= 10;
                        break;

/*
 * label between cases. It seems that this is a chain of gotos but which one I
 * do not know. It does seem like it's early in the game loop and resets stats <
 * 0 back to 0 prior to printing them but how many gotos are involved I do not
 * know. Anyway it'll go back to P which is at the beginning of
 * the loop and it'll reset the stats and print them.
 */
                        D:goto P;
                    case 8:

/*
 * wagon train gets swamped fording river - but with a reference to a historical
 * event (72 or so years after this game takes place) as well as a nod to
 * Jurassic Park(not the only one)
 */
                        V(86);
/*
 * food
 */
                        R -= 30;
/*
 * clothing
 */
                        G -= 20;
/*
 * oxen
 */
                        O -= 40;
/*
 * this one is devious: the goto V comes outside and after this switch. I think
 * it first sets 'q' (the switched value) to another value first. It is then
 * abused in nested switches. Please do not ask me to parse these. It's a
 * nightmare and I've had enough of that. I already explained a lot of this in
 * the remarks.md and I also am disturbed enough to write it; isn't that enough?
 */
                        break;
                        V:
                        switch (x(1, 9))
                        {
                            case 2:
                                if (q > 9)
                                {
                                    switch (x(1,2))
                                    {
                                        q:
                                        R += 40;
                                        goto o;
                                        case 1:
                                            switch (x(2,3))
                                            {
                                                case 2:
                                                    V(a = 54);
                                                    goto m;
                                                    b:w(48)
                                                    case 3:
                                                    goto J;
                                            }
                                        case 2:
                                            V(5);
                                    }
                                    goto E;
                                    ll:goto mm;
                                    J:
                                    V(a=54);
                                }
                                goto O;
                                KK:goto JJ;
                                m:
                                goto E;
                            default:
                                if (q > 10) goto E;
                                if (q > 7)
                                {
                                        if (N < 5)
                                /*
                                 * death due to lack of medical supplies and
                                 * Devil on holiday/business in Heaven.
                                 */
                                        w(99)
                                /*
                                 * mild illness, meds used
                                 */
                                            V(13); N -= 5;
                                }
                                break;
                        }

/*
 * mileage lost. Why? I'm afraid I haven't the foggiest clue now except to say
 * it is supposed to happen. Remember this is (I think) in several nested
 * switches.
 */
                        M -= 17;
                        break;
                        C:goto k;
/*
 * eat!
 */
                        K:
                        R -= R > 23 ? 23 : R > 18 ? 18 : R > 13 ? 13 : R;
                        goto Y;
/*
 * Barghest
 */
                    case 14: V(74); break;

/*
 * Werewolf scare.
 */
                    case 15: V(x(0,1)?69:68);
                    break;
/*
 * no clue where goto d comes from
 */
                    d:
                    goto I;
                    case 11:

/*
 * not enough clothing check
 */
                        if (G < 25)
/*
 * V is above the nested switches
 */
                            goto V;
                        break;
                        kk:goto ll;
                    case 12:
/*
 * hail storm - and another ironic joke
 */
                        V(94);
/*
 * lose mileage, hp/stamina, supplies
 */
                        M -= 5;
                        b -= 19;
                        N -= 5;
                        break;
/*
 * yes again another label inside a switch that's not a case
 */
                        G:
                        goto a;
                    case 0:
/*
 * another joke that is only a message and has no need to check for it
 * again: this is one of the reasons I made it extended family and wagon
 * trains, besides historically large groups travelled and in wagon trains
 */
                        V(20);
                }                                 /* end outer switch - well this switch that has the nested switches */

/*
 * ox looks at you funny. Yes that means both could in theory
 * happen. Wait. How is it possible the above one could trigger?
 * Well I leave you to figure that one out!
 */
                if(O>39){ V(e = 19); O -= 40; R+=40; }

/*
 * mountains check.
 *
 * BTW: for all I know the distance is wrong; the original game had 2040 miles I
 * think and that is incorrect: the real trail was a fair bit longer than that.
 * But I only made the game make you travel further and did not try and make
 * geography better (or worse)
 */
                if (M < 951)
/*
 * W is medical related things - I mentioned some of this before
 */
                    goto W;
/*
 * clothing check in mountains
 */
                if (G < 36)
                    goto b;

                    if (x(0,9)>4) goto n;         /* skip rugged mountains */
/*
 * rugged mountains: an event that at one point happened a lot on my
 * system due to the old calculation. Now it's much more simplified
 * but I'm not sure exactly what difference it makes other than it
 * does give me more bytes which I used for better gameplay.
 */
                    V(96);
/* lost? */
                    if (x(0,1))
                        goto p;
/*
 * lose time asking the Devil for directions to the crossroads; yes a
 * cultural reference to a famous legend about an amazing guitarist
 * who supposedly 'went to the crossroads' and sold his soul to the
 * Devil for musical talent. Robert Johnson of course! But there is
 * also a historical joke (about the Oregon Trail itself - from a
 * historian on how you had to be a complete moron to lose your way
 * on the trail) in this besides the crossroads joke.
 */
                    V(97);
                    M -= 60;
                    goto n;
                    p:
                    if (x(0,9) < 5)
                        goto t;
/* wagon train damaged - lose time resupplying from the Devil */
                    V(21);
                    M -= 99;
                    goto n;
                    t:
/*
 * time stops - another reference to the Great Molasses Flood (which
 * happens when you get stuck fording a river). This event happened 72 years
 * after this game takes place and also not even close to the Oregon Trail
 * (far as I know). Apparently this is where the Americanism 'slow as
 * molasses' comes from, though there were tragic deaths as well.
 */
                    V(22);
                    M -= 85;
                    n:
                    if(m)
                        goto z;
                    m = 1;
                    if (x(0, 9) < 5)
                        goto w;
/*
 * made it safely through South Pass - no snow (this was a real place on the
 * trail)
 */
                    V(23);
                    z:
                    if (M < 1951 || W)
                        goto U;

/*
 * cleared Blue Mountains
 */
                    W = 1;

                    if (!d && !x(0,9))
                    {
/*
 * rather ironic joke and the ghost mocks you (and not the only time it might
 * happen)
 */
                        V(75); d = 1;
/*
 * I don't know if I should say this but as it's part of the joke and this type
 * of thing did happen: yes this is food
 */
                        R += 50;
                    }
                    if (!x(0, 4))
/*
 * yes dragons exist. Oh and the Earth is flat and the Sun is crazy... A
 * reference to Miracle Workers: Dark Ages (except that the dragons is in
 * there the devil). Anyway: 84 == dragon eats you, 34 ==
 * runaway bed rhyme death, 33 == Tyrannosaurs attack. Doing it
 * this way saves bytes - it used to be case 16 in the events but
 * it was too frequent so I changed it to here - which only
 * happens if !x(0,7).
 */

                        w(x(0,5)?84:x(0,3)?33:34)
                        if (x(0,9) < 5)
                            goto w;
                    U: goto W;
                    w:
/*
 * blizzard in mountain pass - waste time asking Devil for help restocking.
 * Unfortunately the unfaithful monster only gives you one measly bullet.
 */
                    V(35);
                    c = 1;
                    M -= 101;
                    I += 1;
                    j
                        k:
/*
 * miles lost
 */
                    M -= 10;

                goto U;
                W:
                if (d && x(0,1))
/*
 * ghost of frozen son
 */
                    V(39);
/*
 * yes this is legal. And 'i' is set to the right value earlier on. Devil
 * poisoned you. The 'heaven' reference is a joke especially as the only way
 * you go there (and not really) is when poisoned. The 'goto heaven;' is
 * never reached. Compilers whine about this because they don't like code
 * like this.
 */
                while(i)heaven:w(i)
/*
 * B non zero == can't afford doctor. This is so the player is not flooded
 * with the message. Once is enough
 *
 * 'f' is injury; 'a' is illness; 'Q' is treated for illness but you're not
 * completely better. Arguably this should happen with injuries too but I
 * decided against it.
 */
                    if (!B && (f || a ))
                {
                    if (d && a)
/*
 * food poisoning, maybe. Well no but it's part of the joke
 */
                        V(91);
                    if (T < 666)
/*
 * doctor's bill is $666 and you can't afford it.
 */
                        V(B=38);
                    else
                    {
/*
 * record whether the person is sick
 */
                        Q = a ? 1 : Q;
/*
 * record if injured
 */
                        h = f ? 1 : h;
/*
 * injury and illness back to 0
 */
                        f = a = 0;
/*
 * doctor bill is $666
 */
                        V(93); T -= 666;
                    }
                }
/*
 * if injured and no medical care lose 15 hp, else if injured and got
 * care lose 5, else 0.
 */
                b -= f ? 15 : h ? 5 : 0;
/*
 * if you were sick (and not completely recovered) lose only 5hp;
 * otherwise if sick 15 and otherwise 0
 */
                b -= a ? 15 : Q ? 5 : 0;
/*
 * usual mileage gain in the round: way higher than they travelled
 * in real life but this has to be the case
 */
                M += 170;
/*
 * if oxen > 99 add 30 miles, otherwise subtract 99. Yes this is
 * arbitrary but it forces one to be careful with what they have
 * spent on oxen (and whether or not they need to not spend as much
 * on something else).
 *
 * Remember: the original game gives you only $700 and you must spend
 * >= 200 && <= 300 on oxen and you do not get a chance to buy any
 * more after that; if they die you're out of luck. But in my
 * parody: you start with $1666 after your vague and ambiguous
 * 'sinful night' and you can buy oxen on the way (more realistic). I
 * don't have the option to steal oxen from riders because I deem
 * them as horse riders and the player character is too reckless
 * anyway, choosing to eat the body rather than a horse.
 *
 * This parody as the remarks.md say has 'flat oxen'. Originally
 * this set them to 0 but this was not good; it slows you down but
 * you can always get more just as if you lost them all (or ate them
 * all).
 *
 * With these bonuses and penalties it is possible to both win and
 * lose. I have even on an occasion won with no oxen and that's why I
 * made this more severe (this way if you don't have > 99 you only
 * go at the very most 71 per turn, at least as far as the end of the
 * game loop goes and before other penalties). Whether one can still
 * win on 0 oxen is beyond me. I subtracted 100 if < 200 but that
 * seemed really harsh given some of the events that can be
 * devastating to oxen and other penalties to mileage.
 */
                M += O > 99 ? 30 : -99;
/*
 * lose 10 hp every turn.
 */
                b -= 10;
            }
/*
 * A == turn. I went beyond the number of weeks than the original.
 * If I were to do it again I would have actually removed the
 * message about 5-6 months and let it go longer: but that would
 * mean another joke could not land and also it's less realistic.
 * Still could be fun if that joke could be integrated somehow (and
 * I don't see how it could be due to what the message is). So
 * perhaps I would not do it again. Still I believe this is one or
 * two more turns than the original BASIC game - by design.
 */
            while (A++ < 21);
    }
/*
 * outside the game loop finally
 */
    if (b < 1)
    {
/*
 * death by dysentery.
 *
 * why not die of dysentery if you were treated but still sick?
 * Well that has to be because of string 45. Another joke.
 */
        if (a) { w(40) XX:goto ZZ; }
/*
 * death of injuries
 */
                if (f) w(41)
/*
 * death from boredom. This is why I did not have the
 * character die if they had been treated.
 */
                    w(45)
    }
/*
 * yup, always die even at the end. The alt code has a more
 * ironic twist if you make it the whole way
 */
    w(M>2169?47:36)
/*
 * welcome to your new forever home: hell!
 */
        hell:
/*
 * couldn't do without this, could we?
 */
    return 666;
/*
 * this might seem like dead code but of course it's not. It is an actual
 * case: the fire in wagon train one. It first does a 'goto g;' and then here
 * at 'g:' we do 'goto S;' which does the event and then, assuming that the
 * death doesn't happen, after the fire, it does a goto Z; and Z is right
 * after the goto g;. In other words the event jumps out of the loop and then
 * to another unusual place, the event is performed and then it jumps back to
 * the break!
 */
    g:goto S;
    h:goto u;

/* this one is quite sneaky as it does goto l; but there are other places
 * that go directly to l! That in turn goes somewhere else which in turn
 * goes somewhere else - the final destination!
 */
    g:goto S;
    h:goto u; E:goto aa; Q: goto H; ff:goto ii;  pp: goto qq; rr:goto XX;
}
