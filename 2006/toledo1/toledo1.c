char    *e,t    [366    ],*f
,*g,    *h,*    i;d,    m  ;
    main    (c,b)   char    **b;{
    for(    ;d[t]   =d%3    ?60<d
&300    >d&6    <d %    30?0 
:32:    d%30    ?32:    10 ,    
    366>    ++d;)   ;for    (g=3*
    atoi    (*++    b) +    34+t;
i=f=    "\1"    "\7"    "(d"
"\177"  "yX"    "\34"   ,e=g
    ;  )    for(    *e++    =++m/
    10 +    48,g    =c=0    ,*e =    
48+m    %10;    h=e-    65+*    
i,d=    *h,*    i++;    f-=8    
    ,g=d    <c?c    =d,h:   g)for
    (; d    -=!!    h[*f    ++-64
    ],*f    ;) ;    puts    (t);}
