#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void encrypt(char* s, int k) {
    int i=0;
    while (s[i] != '\0'||s[i] == ' ') {
        s[i] = (char)((int)s[i]+k);
        i++;
    };
};

void encrypt_file(const char* filename, int k) {
    FILE *f = fopen(filename, "r");
    if(!f) { // si f = 0, il y a eu une erreur
        printf("Le fichier n'a pas pu être ouvert");
        return;
    }

    char s[50];
    fscanf(f, "%50s", s); // lit au plus 50 charactères, stockés dans s
    fclose(f);
    encrypt(s, k);
    
    FILE *f2 = fopen(filename, "w");
    if(!f2) {
        printf("Erreur\n");
        return;
    };
    fprintf(f2, s);
}

void decrypt_file(const char* filename, int k) {
    encrypt_file(filename, -k);
}

int nth(int n) {
    FILE *f = fopen("pi10M.txt", "r");
    int d;
    if(!f) {
        printf("%d", n);
        printf("Erreur\n");
        fclose(f);
        return 0;
    };
    for (int i=0; i < n; i++) {
        fscanf(f,"%1d", &d);
    }
    fclose(f);
    return d;
}

void count_pi() {
    FILE *f = fopen("pi10M.txt", "r");
    int tab[10];
    int d;
    for (int i=0; i < 10; i++) {
        tab[i] = 0;
    }
    for (int i=0; i < 9999998; i++) {
        fscanf(f, "%1d", &d);
        tab[d]++;
    }
    for (int i=0; i < 10; i++) {
        printf("%d ", tab[i]);
    }
    printf("\n");
    fclose(f);
}

int pos(int n) {
    int len = 0;
    int p = n;
    bool valid;
    while (p>0) {
        len++;
        p = p/10;
    }
    int tab[len];
    p = n;
    for (int i=0; i < len; i++) {
        tab[len-i-1] = p%10;
        p /= 10;
    };
    for (int i=0; i < 9999998; i++) {
        valid = true;
        for (int j=0; j < len; j++) {
            valid = valid && tab[j]==nth(i+j);
        };
        if (valid) {
            return i;
        };
    };
    return -1;
};

int main() {
    char s[4] = "mp2i";
    encrypt(s ,3);
    printf("%s\n", s);
    encrypt(s, -3);
    printf("%s\n", s);
    //decrypt_file("random_data", 4);
    printf("nth: %d\n", nth(939));
    count_pi();
    printf("pos: %d\n", pos(12012004));
    return 0;
}
