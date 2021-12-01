#include <stdio.h>
#include <stdlib.h>

void divmod(int a, int b, int* q, int* r){
    *q = 0;
    *r= a;
    while (*r >= b) {
        (*r) -= b;
        (*q)++;
    };
};

int main() {
    int q = 0;
    int r = 0;
    divmod(14, 3, &q, &r);
    printf("q: %d, r: %d\n", q, r);
    return 0;
}
