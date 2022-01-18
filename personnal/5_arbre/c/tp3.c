#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "tp1.c"

int somme(tree* t) {
    if (!t)
        return 0;
    return somme(t->g) + somme(t->d) + t->val;
}

bool appartient(int n, tree* t) {
    if (!t)
        return false;
    if (t->val==n)
        return true;
    return appartient(n, t->g) || appartient(n, t->d);
}

bool egal(tree *t1, tree *t2) {
    if (!t1 && !t2)
        return true;
    if (!t1 || !t2)
        return false;
    return egal(t1->g, t2->g) && egal(t1->d, t2->d) && t1->val==t2->val;
}

bool strict(tree* t) {
    if (!t->g && !t->d)
        return true;
    if (!t->g && t->d)
        return false;
    if (!t->d && t->g)
        return false;
    return strict(t->g) && strict(t->d);
}

int main() {
    printf("somme: %d\n", somme(exemple_tree()));
    printf("appartient: %d\n", appartient(8, exemple_tree()));
    printf("strict: %d\n", strict(complet(4)));
    return 0;
}
