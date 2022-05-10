#include <stdio.h>
#include  <stdlib.h>
#include "tree.c"

int n_leaf(tree* t) {
    if(!t)
        return 0;
    if(!(t->g) && !(t->d))
        return 1;
    return n_leaf(t->g) + n_leaf(t->d);
};

tree* exemple_tree() {
    tree *t = make_node(0);
    t->g = make_node(1);
    t->g->g = make_node(2);
    t->g->d = make_node(3);
    t->g->d->g = make_node(4);
    t->d = make_node(5);
    t->d->g = make_node(6);
    t->d->d = make_node(7);
    return t;
};

tree* complet(int n) {
    if (n==0){
        return NULL;
    }
    tree *t = make_node(0);
    t->g = complet(n-1);
    t->d = complet(n-1);
    return t;
};

/*
int main() {
    printf("leafs: %d\n", n_leaf(exemple_tree()));
    printf("leafs complet 4: %d\n", n_leaf(complet(4)));
    return 0;
};
*/
