#include <stdio.h>

char *bed[] = { "TEN", "NINE", "EIGHT", "SEVEN", "SIX", "FIVE", "FOUR", "THREE", "TWO", "ONE" };

void sing(int persons) {
    printf("There %s %s in the bed and the little one said, '%s'\n",
	    persons==9?"was":"were",
	    bed[persons],persons==9?"Good night!":"Roll over, roll over!");
    if (persons != 9)
	printf("So they all rolled over and one fell out...\n");
}

int main() {
  int persons = 0;

  while(persons<10) {
    sing(persons++);
    puts("");
  }


  return 0;
}
