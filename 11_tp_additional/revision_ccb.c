#include <stdlib.h>
#include <stdio.h>

typedef struct list list;
struct list {
    int val;
    list* next;
};

typedef struct queue queue;
struct queue {
    struct list* list;
    struct list* last;
};

void add(queue* q, int n) {
    list* l = (list*)malloc(sizeof(list));
    l->next = q->last;
    l->val = n;
    q->last = l;
};

queue* empty_queue(int n) {
    queue* q = (queue*)malloc(sizeof(queue));
    list* l = (list*)malloc(sizeof(list));
    q->list = l;
    q->last = l;
    l->val = n;
    l->next = NULL;
    return q;
};

int pop(queue* q) {
    int val = q->last->val;
    list* last = q->last;
    q->last = q->last->next;
    free(last);
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
    print_list(q->last);
    printf("Last elem: %d\n", pop(q));
    print_list(q->last);
    return 0;
}