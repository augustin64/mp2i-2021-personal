#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

bool is_zero(int* t, int n) {
    bool is_zero = true;
    for (int i=0; i<n; i++) {
        is_zero = is_zero && t[i]==0;
    };
    return is_zero;
};

unsigned b_to_10(unsigned* t, unsigned size, unsigned b) {
    unsigned number = 0;
    unsigned lv = 1;
    for (int i=0; i<size; i++) {
        number += lv*t[i];
        lv *= b;
    };
    return number;
};

int size_b(int n, int b) {
    return (int)(log(n)/log(b)) + 1;
};

unsigned* convert_10_to_b(int n, int b) {
    int size = size_b(n, b);
    unsigned* tab = (unsigned*)malloc(size*sizeof(unsigned));
    for (unsigned i=0; i<size; i++) {
        tab[i] = n%b;
        n /= b;
    };
    return tab;
};

void tests() {
    /*
    int tab[] = {1, 4, 5, 1, 0};
    printf("false: %d\n", is_zero(tab, 5));

    int tab2[] = {0, 0, 0 , 0};
    printf("true: %d\n", is_zero(tab2, 4));

    unsigned tab3[] = {0, 0, 1, 0, 1};
    printf("b_to_10: %d\n", b_to_10(tab3, 5, 2));

    printf("size(20): %d\n", size_b(20, 2));

    unsigned* twenty = convert_10_to_b(20, 2);
    printf("\n10_to_b: %d %d %d %d %d\n", twenty[0], twenty[1], twenty[2], twenty[3], twenty[4]);
    */
};

int main() {
    // Template copié par flemme
    tests();
    return 0;
}
