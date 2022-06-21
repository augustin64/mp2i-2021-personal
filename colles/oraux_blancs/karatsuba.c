#include <stdlib.h>
#include <stdio.h>

/* I.1 */
/*
xy = (a.2^n + b)*(c.2^n + d)
	 = ac.2^2n + (ad+bc).2^n + bd
	 = ac.2^2n + [ac + bd - (a - b)(c - d)].2^n + bd
*/

/* I.2 */
int taille(int x) {
	if (x < 2)
		return 1;
	return 1 + taille(x >> 1);
}

/* I.3 */
int max(int a, int b) {
	return a < b ? b : a;
}

/* Ne fonctionne pas, boucle infinie */
int karatsuba(int x, int y, int n) {
	if (n == 0)
		return 0;
	if (n == 1)
		return 1;
	int k = n >> 1;
	int p = 1 << k;
	int a = x >> k;
	int b = x - (a << k);
	int c = y >> k;
	int d = y - (c << k);

	int ac = karatsuba(a, c, k);
	int bd = karatsuba(b, d, k);
	int abcd = karatsuba(a - b, c - d, k);

	return (ac << n) - ((ac + bd - abcd) << k) + bd;
}

/* I.5 */
/*
Soit C(n) la complexité de karatsuba(.., .., n).  
karatsuba(.., .., n) appelle 3 fois karatsuba(.., .., n/2).  

C(n) = 3*C(n/2) + K
		 = 3*(3*C(n/4)+K)+K
		 = 9*C(n/4) + 3K + K
		 = 3^p*C(n/2^p) + K*∑(i=0 à p-1 de 3^i)

C(n) = (3^log2(n))*C(1) + K*(3^log2(n) - 1)/2
		 = O(3^log2(n))
		 = O(n^log2(3))


*/

int main() {
	return 0;
}
