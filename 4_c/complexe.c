#include <stdio.h>
#include <stdlib.h>
#include <math.h>

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

complexe diff(complexe z1, complexe z2) {
    complexe z3;
    z3.reel = z1.reel - z2.reel;
    z3.imag = z1.imag - z2.imag;
    return z3;
}

complexe mult(complexe z1, complexe z2) {
    complexe z3;
    z3.reel = z1.reel * z2.reel - z1.imag * z2.imag;
    z3.imag = z1.reel * z2.imag + z2.reel * z1.imag;
    return z3;
};

complexe divise(complexe z1, complexe z2) {
    float denom = z2.reel*z2.reel + z2.imag*z2.imag;
    complexe z3;
    z3.reel = (z1.reel*z2.reel + z1.imag*z2.imag)/denom;
    z3.imag = (z1.imag*z2.reel - z1.reel*z2.imag)/denom;
    return z3;
};

float dist(complexe z1, complexe z2) {
    complexe d = diff(z1, z2);
    return sqrtf(d.reel*d.reel + d.imag*d.imag);
}

float module(complexe z) {
    complexe orig;
    orig.reel = 0;
    orig.imag = 0;
    return dist(z, orig);
};

int main() {
    complexe z1;
    z1.reel = 2;
    z1.imag = 3.2;

    complexe z2;
    z2.reel = 1.2;
    z2.imag = 0.4;
    
    complexe z3 = divise(z1, z2);
    
    printf("%f + %fi\n", z3.reel, z3.imag);
    printf("distance: %f\n", dist(z1, z2));
    return 0;
}
