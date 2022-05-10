#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int to_set(int n) {
    return 1 << n;
}

int to_int(int n) {
    return n & -n;
};

bool full(int n) {
    return n == 511;
};

int line(int m[9][9], int i) {
    int total = 0;
    for (int j=0; j < 9; j++) {
        if (m[i][j] != -1) {
            total += to_set(m[i][j]);
        };
    };
    return total;
};

int column(int m[9][9], int j) {
    int total = 0;
    for (int i=0; i < 9; i++) {
        if (m[i][j] != -1) {
            total += to_set(m[i][j]);
        };
    };
    return total;
};

int square(int m[9][9], int k) {
    int total = 0;
    int l, c;
    for (int i=0; i < 3; i++) {
        for (int j=0; j < 3; j++) {
            l = i + (k/3)*3;
            c = j + (k%3)*3;
            if (m[l][c] != -1) {
                total += to_set(m[l][c]);
            };
        };
    };
    return total;
};

bool valid(int m[9][9]) {
    for (int i=0; i < 9; i++) {
        if (        !(full(line(m, i)) && 
                    full(column(m, i)) && 
                    full(square(m, i)))) {
            return false;
        };
    };
    return true;
};

void print_grid(int m[9][9]) {
    for (int i=0; i < 9; i++) {
        for (int j=0; j < 9; j++) {
            if (m[i][j]!=-1)
                printf(" %d ", m[i][j]);
            else
                printf("-1 ");
        };
        printf("\n");
    };
};

bool backtrack(int m[9][9], int i, int j) {
    if (i==7 && j==7)
        return true;
    if (m[i][j] != -1) {
        //if (j==8)
            //printf("%d %d -> %d %d\n", i, j, i+(j/8), (j+1)%9);
        return backtrack(m, i+(j/8), (j+1)%9);
    }
    int c = column(m, i);
    int l = line(m, j);
    int s = square(m, (i/3)+(j/3)*3);
    bool poss[9];
    for (int k=0; k < 9; k++) {
        if ((to_set(k)&c)==0&&
            (to_set(k)&l)==0&&
            (to_set(k)&s)==0) {
            poss[k] = true;
        } else {
            poss[k] = false;
        }
    }
    for (int k=0; k < 9; k++) {
        if (poss[k]) {
            m[i][j] = k;
            if (backtrack(m, i+(j/8), (j+1)%9)) {
                return true;
            }
        }
    }
    m[i][j] = -1;
    //printf("%d %d term\n", i, j);
    return false;
};

int main() {
    //printf("to_set: %d\n", to_set(4)); 
    //printf("full: %d\n", full(511));
    int m_ex[9][9] = {
    { -1, 3, -1, -1, -1, -1, 0, 6, 8 }, 
    { -1, -1, 1, -1, -1, 7, -1, 4, 3 }, 
    { -1, -1, 5, -1, -1, 4, -1, -1, 7 }, 
    { -1, 7, -1, -1, 6, -1, 8, 0, -1 }, 
    { -1, 4, -1, -1, 8, -1, -1, 2, -1 }, 
    { -1, 0, 8, -1, 5, -1, -1, 3, -1 }, 
    { 2, -1, -1, 3, -1, -1, 6, -1, -1 }, 
    { 4, 6, -1, 0, -1, -1, 1, -1, -1 }, 
    { 8, 1, 7, -1, -1, -1, -1, 5, -1 }
    };
    int m_ex_solved[9][9] = {
    { 7, 3, 4, 5, 2, 1, 0, 6, 8 },
    { 6, 2, 1, 8, 0, 7, 5, 4, 3 },
    { 0, 8, 5, 6, 3, 4, 2, 1, 7 },
    { 5, 7, 2, 4, 6, 3, 8, 0, 1 },
    { 3, 4, 6, 1, 8, 0, 7, 2, 5 },
    { 1, 0, 8, 7, 5, 2, 4, 3, 6 },
    { 2, 5, 0, 3, 1, 8, 6, 7, 4 },
    { 4, 6, 3, 0, 7, 5, 1, 8, 2 },
    { 8, 1, 7, 2, 4, 6, 3, 5, 0 }
    };
    int m_vide[9][9] = {
    { -1, 3, -1, 5, 2, 1, 0, 6, 8 },
    { 6, 2, 1, 8, 0, 7, 5, 4, 3 },
    { 0, 8, 5, 6, 3, 4, 2, 1, 7 },
    { 5, 7, 2, 4, 6, 3, 8, 0, 1 },
    { 3, 4, 6, 1, 8, 0, 7, 2, 5 },
    { 1, 0, 8, 7, 5, 2, 4, 3, 6 },
    { 2, 5, 0, 3, 1, 8, 6, 7, 4 },
    { 4, 6, 3, 0, 7, 5, 1, 8, 2 },
    { 8, 1, 7, 2, 4, 6, 3, 5, 0 }
    };
    /*printf("line: %d\n", line(m_ex, 0));
    printf("column: %d\n", column(m_ex, 0));
    printf("square: %d\n", square(m_ex, 1));
    printf("invalid: %d\n", valid(m_ex));
    printf("valid: %d\n", valid(m_ex_solved));
    */
    print_grid(m_vide);
    printf("backtrack: %d\n", backtrack(m_vide, 0, 0));
    print_grid(m_vide);
    return 0;
}
