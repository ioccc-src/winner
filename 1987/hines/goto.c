int main(void)
{
    goto x;
    x: goto y;
    y: goto z;
    z: goto a;
    a: goto end;
    end: return 0;
}
