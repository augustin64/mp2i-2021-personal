#include <stdlib.h>
#include <stdio.h>

typedef struct list list;
struct list {
    int val;
    list* next;
};

/*
* Définit simplement un pointeur vers une liste chaînée
*/
typedef struct queue queue;
struct queue {
    struct list* list;
};

void add(queue* q, int n) {
    list* l = (list*)malloc(sizeof(list));
    l->next = q->list;
    l->val = n;
    q->list = l;
};

queue* empty_queue(int n) {
    queue* q = (queue*)malloc(sizeof(queue));
    list* l = (list*)malloc(sizeof(list));
    q->list = l;
    l->val = n;
    l->next = NULL;
    return q;
};

int pop(queue* q) {
    int val = q->list->val;
    list* first = q->list;
    q->list = q->list->next;
    free(first);
    return val;
}

void print_list(list* l) {
    printf("[");
    while (l->next != NULL) {
        printf("%d, ", l->val);
        l = l->next;
    }
    printf("%d]\n", l->val);
}

int main () {
    queue* q = empty_queue(0);
    add(q, 5);
    add(q, 2);
    print_list(q->list);
    printf("First element: %d\n", pop(q));
    print_list(q->list);
    return 0;
}