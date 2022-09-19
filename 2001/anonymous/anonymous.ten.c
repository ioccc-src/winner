#define PLURAL(bottles) bottles==1?"bottle":"bottles"

void sing(int bottles) {
  printf("%d green %s, standing on the wall.\n", bottles, PLURAL(bottles));
}

int main() {
  int bottles = 10;

  while(bottles) {
    sing(bottles);
    sing(bottles);
    printf("And if one green bottle should accidently fall,\nThere'd be ");
    sing(--bottles);
    printf("\n");
  }

  return 0;
}
