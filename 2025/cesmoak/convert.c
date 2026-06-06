/* Convert between Fortran source (.f) and punchcard decks (.deck) */
/* Usage: ./convert -f < code.f > code.deck   (Fortran to deck)   */
/*        ./convert -d < code.deck > code.f   (deck to Fortran)   */
#include <stdio.h>
#include <string.h>
#include <ctype.h>

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

/* --- Fortran to deck (-f) --- */

void output_card(char *line, int show_text) {
    int card[80][12] = {0};

    for (int col = 0; col < 80; col++) {
        int h = to12(char_to_idx(line[col]));
        for (int r = 0; r < 12; r++)
            card[col][r] = (h >> r) & 1;
    }

    printf("   .");
    for (int i = 0; i < 81; i++) putchar('-');
    printf(".\n");

    printf("  / ");
    if (show_text) {
        for (int i = 0; i < 80; i++) putchar(line[i]);
    } else {
        for (int i = 0; i < 80; i++) putchar(' ');
    }
    printf(" |\n");

    for (int row = 0; row < 12; row++) {
        if (row == 0) printf(" /  ");
        else printf("|   ");

        for (int col = 0; col < 80; col++) {
            if (card[col][row])
                printf("\xe2\x96\x8c");
            else
                putchar(' ');
        }
        printf(" |\n");
    }

    printf("'");
    for (int i = 0; i < 84; i++) putchar('-');
    printf("'\n\n");
}

void fortran_to_deck(int show_text) {
    char raw[256];

    while (fgets(raw, sizeof(raw), stdin)) {
        int len = strlen(raw);
        while (len > 0 && (raw[len-1] == '\n' || raw[len-1] == '\r'))
            raw[--len] = 0;

        for (int i = 0; i < len; i++)
            raw[i] = toupper(raw[i]);

        char line[81];
        int line_len = 0;

        for (int j = 0; j < len && line_len < 80; j++)
            line[line_len++] = raw[j];

        while (line_len < 80) line[line_len++] = ' ';
        line[80] = 0;

        output_card(line, show_text);
    }
}

/* --- Deck to Fortran (-d) --- */

void deck_to_fortran(void) {
    char line[1024];
    int card[80][12];
    int row, in_card = 0;

    build_table();

    while (fgets(line, sizeof(line), stdin)) {
        if (!in_card && strstr(line, ".---")) {
            memset(card, 0, sizeof(card));
            row = -1;
            in_card = 1;
            continue;
        }

        if (in_card && line[0] == '\'') {
            char out[81];
            int len = 80;
            for (int col = 0; col < 80; col++) {
                int h = 0;
                for (int r = 0; r < 12; r++)
                    if (card[col][r]) h |= (1 << r);
                out[col] = h12_to_char[h & 4095];
            }
            while (len > 0 && out[len-1] == ' ') len--;
            out[len] = 0;
            printf("%s\n", out);
            in_card = 0;
            continue;
        }

        if (in_card) {
            row++;
            if (row == 0) continue;
            int data_row = row - 1;
            if (data_row >= 0 && data_row < 12) {
                int i = 4;
                int col = 0;
                while (col < 80 && line[i] && line[i] != '\n') {
                    if ((unsigned char)line[i] == 0xe2) {
                        card[col][data_row] = 1;
                        i += 3;
                    } else {
                        card[col][data_row] = 0;
                        i++;
                    }
                    col++;
                }
            }
        }
    }
}

int main(int argc, char **argv) {
    int mode = 0;  /* 0=unset, 'f'=fortran->deck, 'd'=deck->fortran */
    int show_text = 0;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-f") == 0) mode = 'f';
        else if (strcmp(argv[i], "-d") == 0) mode = 'd';
        else if (strcmp(argv[i], "-t") == 0) show_text = 1;
        else mode = -1;
    }

    if (mode <= 0) {
        fprintf(stderr, "\nUsage: %s -f [-t] < code.f > code.deck\n", argv[0]);
        fprintf(stderr, "       %s -d < code.deck > code.f\n\n", argv[0]);
        fprintf(stderr, "Converts between Fortran source and visual punchcard decks.\n");
        fprintf(stderr, "Cards use IBM 7040 character encoding (6-bit to 12-bit H-code).\n");
        fprintf(stderr, "  -f   Convert Fortran source to punchcard deck\n");
        fprintf(stderr, "  -d   Convert punchcard deck to Fortran source\n");
        fprintf(stderr, "  -t   Show ASCII text on cards (with -f)\n");
        return 1;
    }

    if (mode == 'f')
        fortran_to_deck(show_text);
    else
        deck_to_fortran();

    return 0;
}
