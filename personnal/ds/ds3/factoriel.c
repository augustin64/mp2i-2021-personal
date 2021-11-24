#include <stdio.h>
#include <stdlib.h>

int factoriel(int n) {
    int fact = 1;
    for (int i=1; i<=n; i++) {
        fact *= i;
    };
    return fact;
};

int rec_factoriel(int n) {
    if (n==1) {
        return 1;
    } else {
        return rec_factoriel(n-1) * n;
    };
};

int main() {
    // Template copié par flemme
    printf("%d \n", factoriel(4));
    printf("%d \n", rec_factoriel(4));
    return 0;
}
