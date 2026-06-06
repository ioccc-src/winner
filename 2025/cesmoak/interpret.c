/* Annotate punchcard decks: decode punch patterns and write text on cards */
/* Usage: ./interpret < code.deck > code-ann.deck                         */
#include <stdio.h>
#include <string.h>

/* Character to 6-bit 9-code encoding (IBM 7040) */
int char_to_idx(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'I') return 17 + (c - 'A');
    if (c >= 'J' && c <= 'R') return 33 + (c - 'J');
    if (c >= 'S' && c <= 'Z') return 50 + (c - 'S');
    if (c == ' ') return 48;
    if (c == '=') return 11;
    if (c == '+') return 16;
    if (c == '-') return 32;
    if (c == '*') return 44;
    if (c == '/') return 49;
    if (c == '(') return 60;
    if (c == ')') return 28;
    if (c == ',') return 59;
    if (c == '.') return 27;
    if (c == '$') return 43;
    return 48;
}

/* 6-bit 9-code to 12-bit H-code */
int to12(int s) {
    if (s == 48) return 0;
    return s/16 + (s > 47) + !s*4 |
           (s%16 == 9 ? 2048 :
            s/8%2 << 10 | (s & 7 ? 4 << (s & 7) : 0));
}

/* Reverse lookup: 12-bit H-code -> character */
char h12_to_char[4096];

void build_table(void) {
    const char *all = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ=+-*/(),.$";
    memset(h12_to_char, ' ', sizeof(h12_to_char));
    for (int i = 0; all[i]; i++) {
        int h = to12(char_to_idx(all[i]));
        h12_to_char[h] = all[i];
    }
    h12_to_char[0] = ' ';
}

void usage(const char *name) {
    fprintf(stderr, "\nUsage: %s < code.deck > annotated.deck\n\n", name);
    fprintf(stderr, "Reads a punchcard deck and decodes the punch patterns to produce\n");
    fprintf(stderr, "an annotated deck with the Fortran source printed on each card.\n");
}

int main(int argc, char **argv) {
    if (argc > 1) { usage(argv[0]); return 1; }
    char lines[16][1024];
    int card[80][12];
    int nlines = 0, in_card = 0;

    build_table();

    char buf[1024];
    while (fgets(buf, sizeof(buf), stdin)) {
        if (!in_card && strstr(buf, ".---")) {
            /* Start of card: store top border, reset */
            strcpy(lines[0], buf);
            nlines = 1;
            memset(card, 0, sizeof(card));
            in_card = 1;
            continue;
        }

        if (in_card && buf[0] == '\'') {
            /* Bottom border: decode punches and emit annotated card */

            /* Decode text from punch pattern */
            char text[81];
            for (int col = 0; col < 80; col++) {
                int h = 0;
                for (int r = 0; r < 12; r++)
                    if (card[col][r]) h |= (1 << r);
                text[col] = h12_to_char[h & 4095];
            }
            text[80] = 0;

            /* Output top border */
            fputs(lines[0], stdout);

            /* Output text row with decoded annotation */
            printf("  / ");
            for (int i = 0; i < 80; i++) putchar(text[i]);
            printf(" |\n");

            /* Output data rows (lines[2..13]) */
            for (int i = 2; i < nlines; i++)
                fputs(lines[i], stdout);

            /* Output bottom border */
            fputs(buf, stdout);

            in_card = 0;
            continue;
        }

        if (in_card) {
            /* Store line and parse punch data */
            if (nlines < 16)
                strcpy(lines[nlines], buf);
            nlines++;

            int data_row = nlines - 3;  /* lines[0]=border, [1]=text, [2..13]=data */
            if (data_row >= 0 && data_row < 12) {
                int i = 4;
                int col = 0;
                while (col < 80 && buf[i] && buf[i] != '\n') {
                    if ((unsigned char)buf[i] == 0xe2) {
                        card[col][data_row] = 1;
                        i += 3;
                    } else {
                        card[col][data_row] = 0;
                        i++;
                    }
                    col++;
                }
            }
        } else {
            /* Outside card (blank lines between cards) */
            fputs(buf, stdout);
        }
    }

    return 0;
}
