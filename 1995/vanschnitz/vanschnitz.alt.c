#ifndef  INITIALIZED

/*
 *  If n isn't defined, make it 5
 */
#ifndef  n
#define  n 05
#endif

/*
 * Some useful variables
 */
#define  THIS_FILE __FILE__ 
#define  FORMAT_STRING "Move disk %d from peg %d to peg %d\n"
#define  INITIALIZED

/*
 * Translate n into bits
 */
#if      n&01
#define  bit0
#endif
#if      n&02
#define  bit1
#endif
#if      n&04
#define  bit2
#endif
#if      n>>3
#define  bit3
#endif

/*
 * Here's the program!
 */
main(){
printf(
#include THIS_FILE
#define  NOW_DO_THE_NUMBERS
#include THIS_FILE
);}

#else

/*
 * Check to see if the number is zero (bottom of recursion)
 */
#ifdef   bit0
#define  N_IS_NOT_ZERO
#endif
#ifdef   bit1
#define  N_IS_NOT_ZERO
#endif
#ifdef   bit2
#define  N_IS_NOT_ZERO
#endif
#ifdef   bit3
#define  N_IS_NOT_ZERO
#endif

#ifdef   N_IS_NOT_ZERO
#undef   N_IS_NOT_ZERO

/*
 * Decrement n
 */
#ifndef  bit0
#define  bit0
#ifndef  bit1
#define  bit1
#ifndef  bit2
#define  bit2
#ifndef  bit3
#define  bit3
#else
#undef   bit3
#endif
#else
#undef   bit2
#endif
#else
#undef   bit1
#endif
#else
#undef   bit0
#endif

/*
 *  Here's recursion
 */
#include THIS_FILE

/*
 *  Note: Odd numbered disks always cycle from 1 => 2 => 3 => 1 => 2 => 3
 *  Even numbered disks always cycle from 1 => 3 => 2 => 1 => 3 => 2
 */

/*
 * Check to see if n is zero. If so, we're moving disk 1.
 * In general, for any n we're moving disk n+1. That means that
 * when n is odd, we're moving an even disk, and vice versa.
 */
#ifndef  bit0
#ifndef  bit1
#ifndef  bit2
#ifndef  bit3
#define  N_IS_ZERO
#endif
#endif
#endif
#endif

#ifdef   N_IS_ZERO
#undef   N_IS_ZERO

#ifndef  NOW_DO_THE_NUMBERS
FORMAT_STRING
#else

/*
 *  If disk 1 is on peg 2, move it 2 => 3
 */
#ifdef   DISK_ONE_IS_ON_PEG_TWO
,1,2,3
#undef   DISK_ONE_IS_ON_PEG_TWO
#define  DISK_ONE_IS_ON_PEG_THREE
#else

/*
 *  If disk 1 is on peg 3, move it 3 => 1
 */
#ifdef   DISK_ONE_IS_ON_PEG_THREE
,1,3,1
#undef   DISK_ONE_IS_ON_PEG_THREE
#else

/*
 *  Disk 1 must be on peg 1. Move it 1 => 2
 */
,1,1,2
#define  DISK_ONE_IS_ON_PEG_TWO
#endif
#endif
#endif
#else

/*
 *  Here, we handle disks >1. Remember that odds cycle 1 => 2 => 3 => 1,
 *  and evens cycle 1 => 2 => 3 => 1. Combine this with the knowledge
 *  of where disk 1 is, and we can determine how to move any disk.
 */
#ifndef  NOW_DO_THE_NUMBERS
FORMAT_STRING
#else

/*
 *  Print the disk number. Remember, disk number = n+1
 */
,1
#ifdef   bit0
+1
#endif
#ifdef   bit1
+2
#endif
#ifdef   bit2
+4
#endif
#ifdef   bit3
+8
#endif

/*
 *  Disk 1 on peg 2 
 */
#ifdef   DISK_ONE_IS_ON_PEG_TWO
#ifdef   bit0
,1,3    /* Even: 1 => 3  (n is odd, so the disk is even) */
#else
,3,1    /*  Odd: 3 => 1  */
#endif
#else

/*
 *  Disk 1 on peg 3 
 */
#ifdef   DISK_ONE_IS_ON_PEG_THREE
#ifdef   bit0
,2,1    /* Even: 2 => 1 */
#else
,1,2    /*  Odd: 1 => 2 */
#endif
#else

/*
 *  Disk 1 on peg 1 
 */
#ifdef   bit0
,3,2    /* Even: 3 => 2 */
#else
,2,3    /*  Odd: 2 => 3 */
#endif
#endif
#endif
#endif
#endif

/*
 *  More recursion
 */
#include THIS_FILE

/*
 *  Increment n
 */
#ifdef   bit0
#undef   bit0
#ifdef   bit1
#undef   bit1
#ifdef   bit2
#undef   bit2
#ifdef   bit3
#undef   bit3
#else
#define  bit3
#endif
#else
#define  bit2
#endif
#else
#define  bit1
#endif
#else
#define  bit0
#endif

#endif  /* #ifdef N_IS_NOT_ZERO */

#endif  /* #else of #ifndef INITIALIZED */
