#include <stdio.h>
#include <stdlib.h>

struct complexe {
    float reel;
    float imag;
};

typedef struct complexe complexe;

complexe add(complexe z1, complexe z2) {
    complexe z3;
    z3.reel = z1.reel + z2.reel;
    z3.imag = z1.imag + z2.imag;
    return z3;
};

complexe mult(complexe z1, complexe z2) {
    complexe z3;
    z3.reel = z1.reel * z2.reel - z1.imag * z2.imag;
    z3.imag = z1.reel * z2.imag + z2.reel * z1.imag;
    return z3;
};

int main() {
    complexe z1;
    z1.imag = 5.3;
    z1.reel = 3;

    complexe z2;
    z2.imag = 4.6;
    z2.reel = 2.1;
    
    complexe z3 = mult(z1, z2);
    
    printf("%f + %fi\n", z3.reel, z3.imag);
    return 0;
}
