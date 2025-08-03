struct termios{};
void tcsetattr(int,int,void*){};
void tcgetattr(int, void*){};
void* fopen(void*, void*){return 0;};
int fread(void*, int, int, void*);
int write(int, void*, int);
int read(int, void*, int);
int n();
void e() {
    for(int i=0;i<100000;i++) {n();}
}
