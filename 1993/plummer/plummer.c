char*_,*O;main(S,l)char**l;{if(S<3)exit(1);*(O=*(l+++S-1)-1)=13,*l[1]=0;for(;;)for(printf(*l),_=O-1;_>=*l&&++*_>(S+*O+S)*S;*_--=(S+*O)*S);}
