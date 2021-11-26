#include <stdio.h>
#include <stdlib.h>

struct darray {
    int* t; // tableau utilisé pour stocker les éléments
    int size; // nombre d'éléments
    int capacity; // taille de t
};

typedef struct darray darray;

darray* empty() {
    darray* d = (darray*)malloc(2*sizeof(int));
    d->t = NULL;
    d->size = 0;
    d->capacity = 0;
    return d;
};

void print_darray(darray* d) {
    printf("[");
    for (int i=0; i<d->size; i++) {
        printf("%d ", d->t[i]);
    };
    printf("]\n");
};

void copy(int* t1, int* t2, int n) {
    for (int i=0; i<n; i++) {
        t2[i] = t1[i];
    };
};

void add(darray* d, int e) {
    if (d->size >= d->capacity) {
        int* t2 = d->t;
        d->t = (int*)malloc(sizeof(int)*d->capacity);
        copy(t2, d->t, d->capacity);
        d->t = t2;
        d->capacity *= 2;
        free(t2);
    };
    d->t[d->size] = e;
    d->size++;
};

void tests() {
    print_darray(empty());

    int t1[] = {0, 1};
    int t2[4];
    copy(t1, t2, 2);
    printf("%d %d %d %d\n", t2[0], t2[1], t2[2], t2[3]);

    darray* d = (darray*)malloc(6*sizeof(int));
    d->t = t2;
    d->size = 2;
    d->capacity = 4;

    printf("%d\n", d->t[2]);
    add(d, 5);
    printf("%d\n", d->t[2]);
};

int main() {
    // Template copié par flemme
    tests();
    return 0;
}
