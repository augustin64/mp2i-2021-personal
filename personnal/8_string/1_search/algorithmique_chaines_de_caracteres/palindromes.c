#include <stdio.h>
#include <stdlib.h>

/* VIII.2 */
/* Équation de récurrence:

dp[i][j] : plus longue sous séquence de s[i:j] qui soit un palindrome.

si s[i] = s[j-1]:
	dp[i][j] = 2 + dp[i+1][j-1]
sinon:
	dp[i][j] = max(dp[i+1][j], dp[i][j-1])

Initialisation:
dp[i][i+1] = 1
*/

int main() {
	return 1;
}
