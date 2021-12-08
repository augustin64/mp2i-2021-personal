#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void print_matrix1(int* m, int n, int p) {
    // affiche une matrice m de taille n*p (linéarisée)
    for(int i = 0; i < n; i++) { // i parcourt les lignes
        for(int j = 0; j < p; j++) // j parcourt les colonnes
            printf("%d ", m[i*p + j]);
        printf("\n");
    }
}

int somme(int** t, int n, int p) {
    int somme = 0;
    for (int i=0; i < n; i++) {
        for (int j=0; j < p; j++) {
            somme += t[i][j];
        };
    };
    return somme;
}

int trace(int* m, int n) {
    int t = 0;
    for (int i=0; i < n; i++) {
        t += m[i*(n+1)];
    };
    return t;
};

bool symetrique(int* m, int n) {
    for (int i=0; i < n; i++) {
        for (int j=0;  j < n; j++) {
            if (m[i*n+j] != m[j*n+i]) {
                return false;
            };
        };
    };
    return true;
};

int* id_matrix1(int n) {
    int *t = (int*)malloc(n*n*sizeof(int));
    for(int i = 0; i < n; i++)
        for(int j = 0; j < n; j++) {
            if(i == j)
                t[i*n + j] = 1;
            else
                t[i*n + j] = 0;
        }
    return t;
}

int** id_matrix2(int n) {
    int **t = (int**)malloc(n*sizeof(int*)); // tableau de pointeurs
    for(int i = 0; i < n; i++) {
        t[i] = (int*)malloc(n*sizeof(int)); // tableau pour la ligne i
        for(int j = 0; j < n; j++) {
            if(i == j)
                t[i][j] = 1;
            else
                t[i][j] = 0;
        }
    }
    return t;
}



int* serpent(int n) {
    int* tab = (int*)malloc(sizeof(int)*n*n);
    for (int i=0; i < n; i++) {
        for (int j=0; j < n; j++) {
            if (i%2 == 0)
                tab[i*4+j] = 4*i+j+1;
            else
                tab[i*4+j] = 4*(i+1)-j;
        };
    };
    return tab;
};

int main() {
    printf("Somme: %d\n", somme(id_matrix2(5), 5, 5));
    printf("Symétrie: %d\n", symetrique(id_matrix1(5), 5));
    print_matrix1(serpent(4), 4, 4);
    return 0;
}
