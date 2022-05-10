#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int exp_rapide(int a, uint n) {
    if (n==1) {
        return a;
    };
    int a_n = exp_rapide(a, n/2);
    if (n % 2 == 0) {
        return a_n * a_n;
    };
    return a_n * a_n * a;
};

int main() {
    int a=5;
    uint n=2;
    //scanf("a: \n", &a);
    //scanf("n: \n", &n);
    printf("%d^%d = %d\n", a, n, exp_rapide(a, n));
    return 0;
}
