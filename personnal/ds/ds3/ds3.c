#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>



/* I Petites questions */
double absolue(double x) {
    return x<0 ? -x : x;
};

void swap(int* a, int* b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
};

bool premier(int x) {
    for (int i=2; i<x; i++) {
        if (x%i == 0){
            return false;
        };
    };
    return true;
};

void tests_petites_questions() {
    printf("abs: %f %f\n", absolue(5), absolue(-5));

    int a = 5;
    int b = 10;
    swap(&a, &b);
    printf("a: %d, b: %d\n", a, b);

    printf("premiers: %d %d %d\n", premier(1), premier(6), premier(7));
};



/* II Fractions */
typedef struct fraction fraction;

struct fraction {
    int num;
    int denom;
};

fraction add(fraction a, fraction b) {
    fraction c;
    c.num = a.num*b.denom + b.num*a.denom;
    c.denom = a.denom*b.denom;
    return c;
};

void tests_fractions() {
    fraction x;
    x.num = 3;
    x.denom = 2;
    printf("fraction: %d/%d\n", x.num, x.denom);

    fraction y;
    y.num = 5;
    y.denom = 7;
    
    fraction z = add(x, y);
    printf("fraction: %d/%d\n", z.num, z.denom);
};



/* II Mélange de Knuth */
int randn(int n) {
    return (int)((float)rand()*(float)n/(float)UINT_MAX);
    // Renvoie constamment le même résultat
};

void swap_t(int* t, int i, int j) {
    int tmp = t[j];
    t[j] = t[i];
    t[i] = tmp;
};

void shuffle(int* t, int n) {
    for (int i=0; i<n; i++) {
        swap_t(t, randn(i), i);
    };
};

void tests_melange_de_knuth() {
    printf("randn: %d\n", randn(1050));

    int t[] = {0, 1, 4, 6, 8};
    shuffle(t, 5);
    printf("shuffled: %d %d %d %d %d\n", t[0], t[1], t[2], t[3], t[4]);
};



/* IV Tri par insertion (dichotomique) */
int position(int* t, int n, int e) {
    for (int i=0; i<n; i++) {
        if (t[i]>e) {
            return i;
        };
    };
    return n;
};


void tests_tri_insertion() {

};



/* V Implémentation d'une file par une liste chaînée */
void tests_implementation_file() {

};


/* VI Fusion de listes triées */
void tests_fusion_listes() {

};



int main() {
    // tests_petites_questions();
    // tests_fractions();
    // tests_melange_de_knuth();
    tests_tri_insertion();
    tests_implementation_file();
    tests_fusion_listes();
    return 0;
};

