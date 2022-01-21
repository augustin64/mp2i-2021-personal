#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool is_heap(int* t, int n) {
    for (int i=1; i < n; i++) {
        if (t[i] > t[(i-1)/2])
            return false;
    }
    return true;
}

int main() {
    return 0;
}
