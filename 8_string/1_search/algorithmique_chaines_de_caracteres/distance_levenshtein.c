#include <stdlib.h>
#include <stdio.h>
#include <string.h>


/* IV.1 */
/*
nuit -> buit -> bruit
*/

/* IV.2 */
/*
d[i][j] = d[i-1][j-1] si s[i] = t[j]
il y a 3 possibilités sinon:
- supprimer s[i]
- ajouter un élément à t[j] à la position i de s
- substituer t[j] en s[i]

On a donc:
Si s[i] != t[j]:
	d[i][j] = 1 + min(d[i-1][j], d[i][j-1], d[i-1][j-1])
*/

/* IV.3 */
int min(int a, int b) {
	return a < b ? a : b;
};

// Complexité O(np)
int distance_levenshtein(char* s, char* t) {
	int n = strlen(s) +1;
	int p = strlen(t) +1;
	int d[n][p];
	
	for (int i=0; i < n; i++) {
		d[i][0] = i;
	}
	for (int j=0; j < p; j++) {
		d[0][j] = j;
	}

	for (int i=1; i < n; i++) {
		for (int j=1; j < p; j++) {
			if (s[i-1] == t[j-1])
				d[i][j] = d[i-1][j-1];
			else
				d[i][j] = 1 + min(d[i-1][j], min(d[i][j-1], d[i-1][j-1]));
		}
	}
	return d[n-1][p-1];
}


int main() {
	printf("distance_levenshtein: %d\n", distance_levenshtein("nuit", "bruit"));
	return 1;
}
