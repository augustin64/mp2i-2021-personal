#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int somme(int tab[], int n) {
    // printf("%d, %d\n", sizeof(tab), sizeof(int));
    int s = 0;
    for (int i=0; i < n; i++) {
        s += tab[i];
    };
    return s;
};

void swap(int* tab, int i, int j) {
    int tmp = tab[i];
    tab[i] = tab[j];
    tab[j] = tmp;
};

void reverse(int* tab, int n) {
    for (int i=0; i < n/2; i++) {
        swap(tab, i, n-i-1);
    };
};

int* copy(int t[], int n) {
    int* t2 = (int*)malloc(n * sizeof(int));
    for (int i=0; i < n; i++) {
        t2[i] = t[i];
    };
    return t2;
}

int main() {
    int t[] = {64, 4, 12, 6};
    printf("somme: %d\n", somme(t, 4));
    swap(t, 0, 1);
    printf("tab[0]: %d\n", t[0]);
    reverse(t, 4);
    printf("tab[0]: %d\n", t[0]);
    int t2[] = {6.4, 8, 12.1, 7};
    printf("t2[]:    %d %d %d %d\n", t2[0], t2[1], t2[2], t2[3]);
    int* t2_cp = copy(t2, 4);
    printf("t2_cp[]: %d %d %d %d\n", t2_cp[0], t2_cp[1], t2_cp[2], t2_cp[3]);
    return 0;
}
