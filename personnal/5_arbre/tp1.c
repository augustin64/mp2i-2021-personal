#include <stdio.h>
#include  <stdlib.h>

typedef struct tree tree;

struct tree {
    tree* g;
    tree* d;
    int val;
};

int n_leaf(tree* t) {
    if(!t)
        return 0;
    if(!(t->g) && !(t->d))
        return 1;
    return n_leaf(t->g) + n_leaf(t->d);
}

tree* make_node(int r) {
    tree *t = (tree*)malloc(sizeof(tree));
    t->g = NULL;
    t->d = NULL;
    t->val = r;
    return t;
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
}

int main() {
    printf("leafs: %d\n", n_leaf(exemple_tree()));
    return 0;
};
