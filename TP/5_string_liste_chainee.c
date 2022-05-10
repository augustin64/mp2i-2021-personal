#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct list list;

struct list {
    list* next;
    int val;
    char* key;
};

int hash(const char c) {
    return (int)c-96;
};

int h(const char* s, int p, int n) {
    int len = strlen(s);
    int somme = 0;
    int po = 1;
    for (int i=0; i < len; i++) {
        somme = (somme + hash(s[i]) * po)%n;
        po=(po*p)%n;
    };
    return somme%n;
};

void print_list(list* l) {
    printf("[");
    while (l != NULL) {
        printf("(%s, %d), ", l->key, l->val);
        l = l->next;
    };
    printf("]\n");
};

list* add_to_list(list* l, char* k, int v) {
    list* l_new = (list*)malloc(sizeof(int)+sizeof(list*)+sizeof(char*));
    l_new->next = l;
    l_new->key = k;
    l_new->val = v;
    return l_new;
};

list** new_hashtable() {
    list** t = (list**)malloc(sizeof(list*)*11867);
    for (int i=0; i < 11867; i++) {
        t[i] = NULL;
    };
    return t;
};

void add(char* k, int v, list** t) {
    t[h(k, 31, 11867)] = add_to_list(t[h(k, 31, 11867)], k, v);
}

int get(char* k, list** t) {
    list* l = t[h(k, 31, 11867)];
    while (l != NULL) {
        if (l->key==k) {
            return l->val;
        };
        l = l->next;
    };
    return 0;
}

int main() {
    list** t = new_hashtable();
    add("patates", 5, t);
    printf("patates: %d\n", get("patates", t));
    return 0;
}
