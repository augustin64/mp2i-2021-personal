#include <stdlib.h>
#include <stdio.h>


typedef struct list {
	int element;
	struct list* next;
	struct list* prev;
} list;

typedef struct deque {
	list* left;
	list* right;
} deque;


void add_right(deque* q, int x) {
	list* l = (list*)malloc(sizeof(list));
	l->next = NULL;
	l->prev = q->right;
	l->element = x;
	if (!q->right) {
		q->left = l;
	} else {
		q->right->next = l;
	}
	q->right = l;
}

int peek_right(deque* q) {
	return q->right->element;
}

int peek_left(deque* q) {
	return q->left->element;
}

deque* empty_deque() {
	deque* q = (deque*)malloc(sizeof(deque));
	q->left = NULL;
	q->right = NULL;
	return q;
}

void pop_right(deque* q) {
	list* r = q->right;
	q->right = q->right->prev;
	q->right->next = NULL;
	free(r);
}

void pop_left(deque* q) {
	q->left = q->left->next;
	free(q->left->prev);
	q->left->prev = NULL;
}

int* minimum_sliding(int* a, int n, int k) {
	int* a_min = (int*)malloc(sizeof(int)*n);
	deque* q = empty_deque();
	for (int i=0; i < k-1; i++) {
		while (q->right && peek_right(q) > a[i])
			pop_right(q);
		add_right(q, i);
	}
	for (int i=k-1; i < n; i++) {
		while (q->right && peek_right(q) > a[i])
			pop_right(q);
		while (peek_left(q) < i-k)
			pop_left(q);
		a_min[i-k+1] = a[peek_left(q)];
	}
	return a_min;
}


int main() {
	deque* q = empty_deque();
	add_right(q, 42);
	printf("%d\n", peek_right(q));
	add_right(q, 5);
	printf("%d\n", peek_right(q));
	pop_right(q);
	printf("%d\n", peek_right(q));
	return 0;
}