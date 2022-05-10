#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
dp[i][j] : longueur max d'une sous-séquence commune à s[:i] et t[:j].

Si s[i] = t[j]: dp[i][j] = 1 + dp[i-1][j-1]
Sinon : dp[i][j] = max(dp[i-1][j], dp[i][j-1])
dp[0][j] = dp[i][0] = 0
*/
int max(int a, int b) {
	return a < b ? b : a;
}

int longuest_subsequence(char* s, char* t) {
	int n = strlen(s);
	int p = strlen(t);
	int* dp[n];
	for (int i=0; i < n; i++) {
		dp[i] = malloc(sizeof(int)*p);
		dp[i][0] = 0;
	}
	for (int i=0; i < p; i++) {
		dp[0][i] = 0;
	}
	for (int i=1; i < n; i++) {
		for (int j=1; j < p; j++) {
			if (s[i-1] == t[j-1]) {
				dp[i][j] = 1 + dp[i-1][j-1];
			} else {
				dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
			}
		}
	}
	return dp[n-1][p-1];
}

int main() {
	printf("plus long: %d\n", longuest_subsequence("this is a test", "another try"));
	return 1;
}
