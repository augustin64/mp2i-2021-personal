#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct tree tree;

struct tree {
    tree *g;
    tree *d;
    int val;
};

int max(int a, int b){ return a > b ? a : b; };

tree* make_node(int r) {
    tree *t = (tree*)malloc(sizeof(tree));
    t->g = NULL;
    t->d = NULL;
    t->val = r;
    return t;
};

int size(tree *t) {
    if (t == NULL) {
        return 0;
    }
    return 1 + size(t->g) + size(t->d);
};

int height(tree* t) {
    if(t == NULL) {
        return -1;
    }
    return 1 + max(height(t->g), height(t->d));
};

bool complet(tree *t) {
    if(!t) {
        return true;
    };
    return complet(t->g) && complet(t->d) && size(t->g) == size(t->d);
}

int depth(int* pred, int v) {
    int p = -1;
    for(; v != -1; p++)
        v= pred[v];
    return p;
};

int main() {
    return 0;
}
