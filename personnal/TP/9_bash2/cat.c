#include <stdio.h>
#include <stdlib.h>

void show(char* filename) {
    char c;
    FILE *f = fopen(filename, "r");
    while((c=fgetc(f))!=EOF)
        printf("%c", c);
    printf("\n");
    fclose(f);
}

int main(int argc, char* argv[]) {
    if (argc == 1) {
        printf("cat: opérande manquante\n");
    };
    for (int i=1; i < argc; i++) {
        if (argc > 2)
            printf("--- File %s ---\n", argv[i]);
        show(argv[i]);
    };
    return 0;
}
