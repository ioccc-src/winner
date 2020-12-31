//  APOHLIFE : Annotated Partially Obfuscated 64-bit Hash Life program.
//  This program assumes sizeof(long)==8 (64 bits) and little endianess.
//  Also unaligned (mod 8) long loads support.
//  Xlib is evidently used . Should be runnable almost everywhere
//  with gcc command such as:
//  gcc -O3 -std=c99 apholife.c -lX11 -lm
//
//  If you want to understand Hashlife The clearest description  with diagrams of the recursion I found was in:
//  https://jennyhasahat.github.io/hashlife.html
//  You can  also read Tom Rokicki article appearing in DrDobbs
//  http://www.drdobbs.com/jvm/an-algorithm-for-compressing-space-and-t/184406478
//  And of course look it up in wikipedia, etc ...
//
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include <X11/Xlib.h>
#include <strings.h>
#include <math.h>
#include <assert.h>

#define MAXLEV 1024 // Maximal level supported by our universe.
#define W (32*40l)  // Display window size
#define H (32*40l)
#define HBITS 29    // This wil determine our memory usage (hash + cells)

#define HSIZE (1ll<<HBITS)
#define HMASK (HSIZE -1)
#define MAXMEM (HSIZE)
typedef unsigned long ulong;

int g_step;             // log two of our generation step.

// The following two hex constants (mh and m1) will be very useful here.
const unsigned  mh=0xf0f0f0f; // This is the mask for the lower nibble in every byte. We have four of those in a 32bit unsigned.

// Lets start with our leaf routine. Our leaf is always 64 bits ulong 8*8 pattern.
// Crucially,  whenever we need to encode a quarter-leaf (4*4) such as a result here, we do it using lower 4
// nibbles of an unsigned int, rather rhan a 16 bit short. Remember this when trying to understand all following code!
// This routine makes heaviest and nicest use of bit twiddling hackers delight like stuff.
// If you've read chapter 7.1.3 of Knuths 4A you should be OK with that...
ulong q8x8(ulong in)
{
  const ulong m4=0x1111111111111111; // We will work doing 16 ops at a time on the sixteen nibbles in a long.
  for(int j=0;j<2-!g_step;j++){  //We Normaly count to 2 generations here except when g_step=0.
    ulong res=0;
    for(int i=0;i<4;i++) {
      ulong o=in>>i & m4;
      o+= in*2>>i & m4;
      o+= in/2>>i & m4;
      o+=(o << 8)+(o >> 8); // And now we have in 'o' nibbles 16 sums each of a 3*3 neighborhood.
      // This line, implementing Conways GOL rule, is left as an exercise for the reader. Muhahaha...
      res |= (((o+m4 & m4*6 ^ 3*m4)+m4 >> 3) & (in >> i | o) & m4) << i;
    }
    in=res;
  }
  return in>>18 & mh ; // this just returns the middle quarter-leaf as the result.
}

//
// We have the following tricky but efficient way to encode node and leaf data in the same array of longs in
// an econmoical and aligned manner. We use 32bit indices into the array in lieu of pointers which occupy 64bit
// nowdays. This results in almost factor of 2 compression of memory usage.
//
// A node at ptr i will be encoded using three longs as follows:
// g_lmem[i]  : Two upper quads ptrs (each 32 bits of course).
// g_lmem[i+1]: Upper 32bit word : Result ptr. Lower 13 bits: the log2 of step used for calculating result. 14th bit : 1.
// g_lmem[i+2]: Two lower quads ptrs.
//
// A leaf at ptr i will be encoded using two longs as:
// g_lmem[i] :  64 bits of the 8*8 leaf.
// g_lmem[i+1]: Upper 32bit word: Result 4*4 encoded in lower nibble of each byte. Lower 13 bits same as above. 14th bit: 0.
//
// Notice this encoding can support upto 2^32 pointers which would
// mean g_lmem would be 32 Gbytes and together with a hash of a reasonable load factor we would probably
// need more than 48 GBytes of RAM in order to run out of usable encoding space.
//
ulong *g_lmem;
unsigned *g_hash;
//
//  The following functions/Macros are heavily used in the hashlife algorithm which is essentialy all about
//  splitting cells into four quadrants, and then creating new cells by joining four quadrants.
//  We use the term cell to denote *both* leafs and nodes which are stored of course in the same hash.
//  Quads are always stored in an array conviently called q, with an implicit assumption
//  that q is 2D with stride *Four*. I.e. to move vertically in q we need to add/sub 4 ...
//  This way we naturally have a 4*4 array structure on a q[16] vector needed for hashlife recursion.
//  We call the quads of each quad subquads. So we can say in q there are four quads and sixteen subquads.

// This QUADLOOP macro is used to shorten many loops in the code that work  on 4 quads/subquads.
#define QUADLOOP(x) {int j; for(int i=0;i<4;i++) {j=i+(i&2); x;} }  // j is quad index in q.

// Get a quad (indexed by i) from a cell pointer.
// The main complication here is the case of leaves that gets splitted to quarters-leaves differenty.
// Notice that here is the single place we actualy assume little endianity, as it affects the expression
// to get two 32bit words out of each long.
unsigned getquad(unsigned cell,int i){
 return g_lmem[cell+1]&8192 ? g_lmem[cell+(i&2)] >> i%2*32 : g_lmem[cell] >> i%2*4+16*(i&2)&mh ;
}

// This mq function does the splitting of a cell  into four quads and stores them in the q array.
void mq(unsigned cell,unsigned *q)  {
  QUADLOOP (q[j]=getquad(cell,i));
}

// This GQ macro is using the q array and generates the union of four cells there using the main
// hget hash lookup/update recursive function. All our recursions are done using this macro.
#define GQ(i,level,flags)  hget(q+(i),(level)*4+flags)

unsigned calc_result(unsigned cell,ulong leaf,ulong lh,unsigned *q,int level,int res_step);

// This single hget routine will do most of the work for us.
// It will get (or create a new) node or leaf from the hash, looking it up from its four quarters.
// The four quarters are passed in the qi array, as usual in places 0,1, 4 and 5.
// In the level argument's 2 low bits we have flags described below.
// level>>2 is the level of the joined node made from the quarters, where 0 is for a leaf.
// Remember that quarter leaf encoding is always an unsigned with low nibbles only containing the 4*4 data.
// level&2: If on, we just return the joined node. If 0 we return the joined node's *Result*.
// level&1: Signals "half" recursion mode, Where we join four middle *quarters* of the 4 inputs, to produce a middle quad,
// In that case we return this middle cell's node (and not the middles result).
unsigned hget(unsigned* qi, int level)
{
  ulong leaf,lh,ll;
  int lv=level>>2;
  unsigned hind=0; // Wil be used to calculate hash function
  unsigned cell;

  ulong *data=(ulong *)qi; // Here we seem to use little endianity but in fact we dont. as we store
                           // and compare the q unsigned array contents to the g_lmem long array.
                           // What we do use is tha fact longs can be loaded and stored from *unaligned*
                           // addresses. So we break pointer punning.
  if(lv>0) {
    if(level&1) {
      unsigned q[6];
      QUADLOOP(q[j]=getquad(qi[j],i^3)); // That ^3 will neatly give us the 4 middle subquads to be joined into middle quad.
      return GQ(0,lv-1,2);
    }
    QUADLOOP(hind=917*hind+qi[j]);  // Our node hash function ...
    leaf=data[0]; // Misleading but used for the hash lookup
    lh=data[2];
  }
  else {
    // Inputs in qi are quarter leaves.
    hind= (ll=qi[0]|qi[1]<<4) + 719*(lh=qi[4]|qi[5]<<4); // Hash calculation and create two longs...
    // A bit tricky but that will be the quarter leaf mid of the joined leaf.
    if(level&1) return (ll>>18)&0xf0f | (lh&0x3c3c)<<14;
    leaf= ll | lh <<32;
  }

  // Do linear hash probing, nice and simple ...
  for(; cell=g_hash[hind&=HMASK]; hind++)
    if (leaf==g_lmem[cell] && (!lv || g_lmem[cell+2]==lh) && !!lv == (g_lmem[cell+1]>>13&1)) break;

  // The last condition above is to avoid a very rare and subtle bug that can happen, for example
  // when searching a leaf,  we might find a node instead whose lower data is identical to the leaf's bits
  // *and* its hash is also similar/close. This is possible but the probablity is very low indeed.
  // The probablity of encountering this bug is so low that the actual obfuscated entry has not got 
  // the fix above but the bug does not seem to happen on the supplied patterns.

  int res_step= lv+1;  // res_step is the maximal timestep we can get result for.
  if(res_step > g_step) res_step=g_step; // Notice that if g_step is small, res_step will not be maximal.
                                         // This will mean we will do half recursion later.
  if (!cell || g_lmem[cell+1]&8191^res_step) {
    // We enter here whenever we need to (re) calculate result, either because g_step changed or
    // if its a new cell. In principle result needs to be recalculated whenever g_step was increased
    // compared to earlier calculation but also upon decrease. Though notice that when g_step is high
    // and the cell is lower level, g_step changing will not affect res_step.
    cell=g_hash[hind]=calc_result(cell,leaf,lh,qi,lv,res_step);
  }
  // Remember the result is always in cell+1 high part ...
  return (level&2) ? cell: g_lmem[cell+1]>>32;
}

// This g_ptr variable is the pointer to the g_lmem nodes/leaf array where we will allocate the next cell.
unsigned  g_ptr=2; // skip the 0 which is null ptr in the hash. Start from 2 in order to leave space
                   // at zero used by the getin leaf reading code.
//
// Finaly we reached the most intersting part of result calculation / hashlife recursion. 
// After all the ground work we've layed before, it becomes surprsingly short, heck the
// comments are longer than the code !
//
unsigned calc_result(unsigned cell,ulong leaf,ulong lh,unsigned *qi,int level,int res_step)
{
  if(!cell) {  // Create a new one ...
    g_lmem[cell=g_ptr]=leaf;
    g_lmem[g_ptr+=2]=lh; // This will write some junk in case of leaf but we dont care
    g_ptr+= level>0;
  }
  if(!level) {
    g_lmem[cell+1]=res_step|(q8x8(leaf)<<32);
  }
  else {
    int j;
    unsigned q[16];
    // Finaly we have reached Hashlifes glorious recusion: make new node from four quadrants and calculate its result.
    // A neat obfuscation/compression trick here is that q can be updated in-place shrinking from 4*4 to 3*3 to 2*2,
    // all during the sub-steps in the hashlife recursion calculation. Its recommended looking at the link above for
    // some diagrams describing this recursion.
    // 'hr' flag will indicates half recursion. All it does is, that in the second sub-step the 4 recursive calls just join
    // cells to calculate middle cell, rather then calculate result forward in time.
    //
    // This QUADLOOP wil create the 16 subquads data in q.
    // Notice that rather conveniently 2*j here is just 0,2,8,10 which are indices of the quads we want inside the 4*4 q.
    QUADLOOP(mq(qi[j],q+2*j));
    unsigned hr = level>g_step-1;

    // The whole recursion stuff just becomes the two innocently looking loops below, and hopefuly gcc is decent
    // enough to unroll them under -O3 so its also rather efficient as well...
    for(int i=0;i<11;i++) if((i+1)&3)  q[i]=GQ(i,level-1,0); // Neatly do the first step. 9 recursive calls.
    QUADLOOP(q[j]=GQ(j, level-1, hr)); //Second step. four recursive calls, and QUADLOOP can be used....

    // We get our final result from q by a simple quads join...
    ulong result= GQ(0,level-1,2);
    g_lmem[cell+1]=res_step|8192|(result<<32);
  }
  return cell;
}

// Create the empty space cells/empty universe. Must happen before getin.
void init_empty_space(int maxlev)
{
  unsigned q[16];
  unsigned cell=0;
  for(unsigned i=0;i<maxlev;i++) {
     QUADLOOP(q[j]=cell);
     cell=GQ(0,i,2);
     // This mystery line below is needed because first cell is the empty leaf. It make the formula for the empty cell
     // at a given level to be simply 3*level+2.
     g_ptr+=!i; 
  }
}

// We will use this variable to freeze the state whenever we run out of memory,
// So as to avoind core dumps, etc ...
int g_freeze=0;

//
// This will advance in time the given cell at the given level by current 2^g_step generations.
// the trick here is first expanding enough so the time step will be just looking at the expanded result
// and then shrinking back if neccessary.
//
unsigned adv(unsigned cell,int *ilevel)
{
  unsigned q[16];
  int level=*ilevel;
  //
  // We first need to expand input cell with enough free space to be at a bigger target level,
  // then we can be sure the correct result would be calculated. We need to go at least two levels higher:
  // one, because we may grow during the timestep, and one more because result calculation is
  // itself shrinking.
  //
  int target=level+2;
  if(target >= MAXLEV) {
    g_freeze=1;
    return cell;
  }
  if(target<g_step) target=g_step;
  do {
    for(int i=0;i<16;i++) q[i]=3*level-1; // This is all empty cells sub quads for the given level
    mq(cell,q+5); // 5 is the quad in the middle of 16
    QUADLOOP(q[j]=GQ(2*j,level,2)); // Calculate the 4 quadrants of the expanded cell.
    cell= GQ(0,++level,2); // Then join them to get expanded cell.
  } while (level < target);

  cell=g_lmem[cell+1]>>32;  // Thats the expanded cell's result which does the actual timestep!
  //
  // Now we need to see if the result can be shrunk (i.e. is at a too high level).
  //
  while(--level > 0) {
    mq(cell,q+10); // Split cell into 4 quads at index 10 (the bottom right quad)
    QUADLOOP(mq(q[10+j],q+2*j));  // after this we are back with 16 subquads of original cell.
    // Thats rather condensed but if the loop below finds one of the external 12 quads
    // is nonempty it just returns with the current cell value.
    for(int i=0;i<16;i++)  if((i^i/2)&5^5 && q[i] != 3*level-4) {*ilevel=level; return cell;}
    cell=GQ(5,level-1,2); // Shrink by one level to the middle quad.
  }
}

#define MAXMOVES 500000
unsigned g_cells[MAXMOVES]; // Will be use to hold input cells and then later to hold moves history
double   g_gens[MAXMOVES]; // Will be use to hold gens history

// We even have some minimal error handling here :)
void error(char *s) {printf("%s\n",s);exit(1);}
//
//  This is our input routine, reading marocell (.mc) golly format.
//  Its quite pedantic but hopefuly does not dump cores on bad input :)
//
int getin(FILE *f,int *lv)
{
  char c,line[100];
  static int lev,skip; // Skip is needed to skip Gollys header line.
  unsigned cell,q[16];
  unsigned iptr=1; // Start input counter from 1 as defined by .mc format.
  while(fgets(line,100,f)) {
    if(skip++ && line[0]!='#') {
      if(sscanf(line,"%d%d%d%d%d",&lev,q,q+1,q+4,q+5)==5){
        lev-=3;
        // Put the Referenced nodes into q array. Notice that 0 uses the formula for the empty cell...
        QUADLOOP(if(q[j]>=iptr)error("Bad node input data"));
        QUADLOOP(q[j]=q[j]?g_cells[q[j]]:lev*3-1);
      }
      else {
        // Put 64 bits leaf pattern into g_lmem[0].
        lev=g_lmem[0]=0;
        int l=0,j=0,i=0;
        while(c=line[i++]){
          if(c=='*') {
            if(l*8+j>64) error("Bad leaf input data");
            g_lmem[0]|=1l<<l*8+j;
          }
          j++;
          if(c=='$')l++,j=0;
        }
        mq(0,q); // This divides g_lmem[0] leaf data into four quarters and puts them into  q.
      }
      cell=g_cells[iptr++]=GQ(0,lev,2);  //This joins the 4 quads in q and puts them to the hash
      if(iptr==MAXMOVES) error ("Input too big! increase MAXMOVES please\n");
    }
  }
  g_cells[0]=cell; *lv=g_cells[1]=lev;  // Initial move history state ...
  return cell;
}

// Thats our output image pixmap. We allocate it with some convenient bundaries.
unsigned g_area[(16*16+H)*(16*8+W)+16*8];
unsigned *g_out=g_area+16*8*(W+16*8);
unsigned g_stride=W+16*8;

// Viewport parameters. g_pscale is the log2 scale of a pixel in the image + 4.
// We add the 4 above to have a maximal zoom where a single life cell will be 16*16 pixels in the display.
// g_mx and g_my are the coordinates of the middle of viewport.
double g_mx,g_my;
int g_pscale;
//
// Output support : draw our cells/universe in the output array viewportr.
// Here we use the fact that the array has a padding of 8*16 pixles between lines and 8*16 lines before and after
// so that  8x8 leaf drawing becomes simpler (and more importantly shorter!) as there is no clipping check needed...
// sx and sy are just the coordinates of the top left of the cell. cx and cy are used to get the nice
// color background pattern.
void draw(unsigned cell,int level,double sx, double sy,int cx,int cy)
{
  double sz=ldexp(8,level);
  // The if below checks for  empty space however we dont return if we
  // are in small enough scale so as to draw the colored backgroud...
  if(cell<MAXLEV*3+2 && g_pscale > 6) return;
  double width2=ldexp(W,g_pscale-5);
  double height2=ldexp(H,g_pscale-5);
  if(sx >= g_mx+width2  || sx+sz<=g_mx-width2) return;
  if(sy >= g_my+height2 || sy+sz<=g_my-height2) return;
  double ox=(sx-g_mx+width2);
  double oy=(sy-g_my+height2);
  unsigned *pout=g_out+lround(ldexp(oy,4-g_pscale))*g_stride + lround(ldexp(ox,4-g_pscale));
  if(level <= g_pscale-7) { // Our cell is smaller than a single pixel, its non empty though, so we set it.
    *pout=-1;  //Yes Virginia, -1 is needed here to get white color ....
    return;
  }
  if(level) {
    level--; sz*=0.5;
    // Notice QUADLOOP macro is also usefull for this quadrants draw loop recursion.
    unsigned q[6];
    mq(cell,q);
    QUADLOOP(draw(q[j],level,sx+i%2*sz,sy+i/2*sz,cx*2+i%2,cy*2+i/2));
  }
  else {
    int z0=0,z=4-g_pscale;
    if(z<0) {
      z0=-z;
      z=0;
    }
    // Generate color background pattern, another nice? coding riddle..
    cx^=cy; unsigned background=0x22<<(cx&8?8:cx&64?16:24);
    // Leaf drawing here supports both positive zoom of upto 4 and negative ofcourse.
    ulong in=g_lmem[cell];
    for(int i=0;i<8<<z;i++) {
      for (int j=0;j<8<<z;j++) {
        pout[(i>>z0)*g_stride+(j>>z0)] |= 
            (!i|!j && g_pscale<4) ? 0x80 : // This is the condition to draw leaf borders
            (in>>((i>>z)*8+(j>>z)))&1 ? -1 : background; 
      }
    }
  }
}

int g_adv=0, g_dir=0, g_sstep=0;

void processEvent(Display *d, Window win, XImage *xi)
{
  XEvent ev;
  if(XCheckWindowEvent(d,win,1,&ev)&&ev.type==KeyPress) {
    int N=XLookupKeysym(&ev.xkey,0)&255;
    // The keys ui is documented in the IOCCC entry remarks...
    if     (N==27) { exit(0);} // Use escape key to exit ...
    if     (N==83) { g_mx+=5l<<g_pscale;}
    else if(N==81) { g_mx-=5l<<g_pscale;}
    else if(N==82) { g_my-=5l<<g_pscale;}
    else if(N==84) { g_my+=5l<<g_pscale;}
    else if(N==61) { g_pscale-=!!g_pscale;}
    else if(N==45) { g_pscale++;}
    else if(N==93) { g_step++;}
    else if(N==91) { g_step-=!!g_step;}
    g_adv^= N==32;
    g_dir^= N==8;
    g_sstep^= N==48;
  }
}

unsigned main(int ac,char **av)
{
  g_lmem=(ulong *)malloc(MAXMEM*8);
  g_hash=(unsigned *)calloc(HSIZE,4);
  init_empty_space(MAXLEV);
  int lev;
  if(ac!=2) error("Usage: apholife input.mc");
  FILE *f=fopen(av[1],"r");
  if(!f) error("Could not open input file!");
  unsigned cell=getin(f,&lev);

  double gen=0;
  bzero(g_out,(W+8*16)*H*4);
  Display *d=XOpenDisplay(NULL);
  Window win=XCreateSimpleWindow(d, RootWindow(d, 0), 0, 0, W, H, 1, 0, 0);
  XImage *xi= XCreateImage(d, DefaultVisual(d,0),24,2,0,(char *)g_out,W,H,32,g_stride*4);
  XMapWindow(d, win);
  XSelectInput(d, win, KeyPressMask|ButtonPressMask|ExposureMask);
  int curr=1;
  while(1)
  {
    bzero(g_out,(W+8*16)*H*4);
    draw(cell,lev,ldexp(-4,lev),ldexp(-4,lev),0,0);
    XPutImage(d, win, DefaultGC(d, 0), xi, 0, 0, 0, 0, W, H);
    processEvent(d, win, xi);
    if(g_adv) {
      if(!g_dir) {
        if(!g_freeze) {
          int prev=g_ptr;
          cell=adv(cell,&lev);
          gen+=ldexp(1,g_step);
          g_cells[curr+1]=cell; g_cells[curr+=2]=lev; g_gens[curr/2]=gen;
          // This heuristics will quite probably avoid crashing when memory runs out.
          if(3*(g_ptr-prev) >= MAXMEM-g_ptr || curr>=MAXMOVES-3) {
            g_freeze=curr;
          }
        }
        else if(curr<g_freeze) {
          cell=g_cells[curr+1]; lev=g_cells[curr+=2]; gen=g_gens[curr/2];
        }
      }
      else {
        if(curr>2) {
          lev=g_cells[curr-=2]; cell=g_cells[curr-1]; gen=g_gens[curr/2];
        }
      }
      if(curr>2) {
        printf("G: %g  M: %d L%d S%d%s\n",gen,g_ptr,lev,g_pscale,g_freeze?" (Frozen)":"");
      }
    }
    if(g_sstep)g_adv=0;
  }
}
