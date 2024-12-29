#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <stdio.h>
#include <math.h>
#include <time.h>
#define _ float

                  _ CRUSH(_*LEG,int ARM,_*FINGER) {
         _ GORE; for(GORE=0,--ARM; ARM>=0; --ARM)GORE+=FINGER[ARM]*ARM
     [LEG]; return GORE; } _*BITE(){ _*BRAIN=calloc(sizeof(_),1<<17);int TOE
  =getc(stdin),EYE,SKULL=0; while((EYE=getc(stdin))!=EOF){ ++BRAIN[(TOE<<8) +
 EYE]; ++SKULL; TOE=EYE; } if(SKULL)for(TOE=0; TOE<8<<13; ++ TOE)BRAIN [TOE]/=
 SKULL; return BRAIN; } _ CHEW(_*GUT,_ BONE[][1<<16]){ int GRR; for(GRR=0; GRR<
 6; ++GRR){ GUT[GRR+256*256]=powf(1+expf(-CRUSH(BONE[GRR],1<<16,GUT)),-1); BONE
 [6][50+GRR]=GUT[256*256+GRR]*(1.-GUT[(8<<13)+GRR]); } BONE[6][81]=1/(1 +expf(-
 CRUSH(GUT+(1<<16),6,BONE[6]))); return BONE[6][82]=BONE[6][81]*(1.-BONE[6][81]
 ),BONE[6][81]; } _ GNAW(_ FLESH,_ LEG[][2<<15],_*EYE){ int UG,MMM; LEG[6][13]=
 FLESH-CHEW(EYE,LEG); LEG[6][14]=LEG[6][ 82]*LEG[6][13]; for(UG=0; UG<6; ++UG){
 LEG[6][34]=LEG[6][UG+(1<<7)-14]*LEG[6][7<<1]*LEG[6][UG]; for(MMM=0; MMM<4<<14;
 ++MMM)LEG          [UG][MMM]+=LEG[6][34]*.3*EYE[MMM]; LEG[6][UG]+=.3*LEG[6][14
  ]*EYE[               256*256+UG]; } return powf(LEG[6]          [13],2); } _
  **EAT(               char*TOMB){ DIR*BONE = opendir(               TOMB); int
  BRAIN=               0; struct dirent*TOOTH; _**BODY               =0; while
 (BONE?(TOOTH=        readdir(BONE)):0){ if(  TOOTH->                d_name[0]
 !=46){ char*MOAN=malloc(strlen(TOMB)+strlen(TOOTH->d_name       )+1); sprintf(
 MOAN, "%s%s",TOMB,TOOTH ->d_name); if(freopen(MOAN, "r",stdin)){ BODY=realloc(
 BODY,sizeof(_*)*(BRAIN+1)); BRAIN ++ [BODY]=BITE(); } } } return BODY=realloc(
 BODY,(1+BRAIN)*sizeof(_*)),BODY[BRAIN]=0,BODY; } int main(int GRR,char **UGH){
 _ BRAINS[7][1<<16],***CORPSES; int PUS,OOZE,UG; for(srand(time(0)),PUS=0; PUS<
  7; ++PUS)for(OOZE=0; OOZE<4<<14; ++OOZE)BRAINS[PUS][OOZE]=rand()/(_)RAND_MAX
   -.5;fread(BRAINS,sizeof(BRAINS),1,stdin); if(*UGH[1]==45){ GRR-=2; CORPSES
    =malloc(                                                         sizeof(_
    **)*GRR                                                           ); for(
     PUS=0;                                                             PUS<
    GRR; ++             PUS)CORPSES[PUS]=EAT(UGH[2+PUS]);             for(UG=
     0; UG<atoi       (&(UGH[1][1])); ++UG){ BRAINS[6][97]=       0; for(PUS
      =0; PUS<GRR; ++PUS)for(OOZE=0; CORPSES[PUS][OOZE]; ++OOZE)BRAINS [6][
        97]+=GNAW(1.-(_) PUS/(GRR-1),BRAINS,CORPSES[PUS][OOZE]); fprintf(
         stderr,"%d: %f\n",UG,BRAINS[6][97]); } fwrite( BRAINS, sizeof(
          BRAINS),1,stdout); } else for(UG=1; UG<GRR; ++UG)if(freopen(
              UGH[UG],"r",stdin))fprintf(stderr,"%s %f\n",UGH[UG],
                       CHEW(BITE(),BRAINS)); return 0; }
