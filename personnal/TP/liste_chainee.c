#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

typedef struct list list;

struct list {
    list* next;
    int elem;
};

//typedef struct list list;

list* add(list* l, int e) {
    list* l_new = (list*)malloc(sizeof(int)+sizeof(list*));
    l_new->next = l;
    l_new->elem = e;
    return l_new;
};

list* range(int n) {
    list* l = NULL;
    for (int i=n-1; i>=0; i--) {
        l = add(l, i);
    };
    return l;
};

void print_list(list* l) {
    printf("[");
    while (l != NULL) {
        printf("%d, ", l->elem);
        l = l->next;
    };
    printf("]\n");
};

bool has(list *l, int e) {
    while (l != NULL) {
        if (l->elem==e) {
            return true;
        };
        l=l->next;
    };
    return false;
};

int size(list* l) {
    int n = 0;
    while (l!= NULL) {
        n++;
        l = l->next;
    };
    return n;
};

list* reverse(list* l) {
    list* l2 = NULL;
    while (l!=NULL) {
        l2 = add(l2, l->elem);
        l = l->next;
    }
    return l2;
};

void tests() {
    list* l = NULL;
    list* l2 = add(l, 2);
    printf("liste: %d\n", l2->elem);
    print_list(range(5));
    print_list(l2);
    printf("has(l2, 5): %d, has(range, 3): %d\n", has(l2, 5), has(range(5), 1));
    printf("len(l2): %d, len(range10): %d\n", size(l2), size(range(10)));
    print_list(reverse(range(10)));
    free(l2);
};

int main() {
    tests();
    return 0;
};
