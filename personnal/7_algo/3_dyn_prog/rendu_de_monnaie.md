```c
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
```

# I Rendu de monnaie

## I.1 

Soit neN et soit (a,...,ak)  
Si ak>n alors r(n,k)=r(n,k-1)  
Sinon: r(n,k) = min(r(n,k-1), r(n-ak,k)+1)  


## I.2 

```c
int min(int a, int b) {
	return a < b ? a:b;
}

int rendu(int n, int* a, int k) {
	int** r = (int**)malloc((n+1)*sizeof(int*));
	for (int i=0; i<=n; i++) {
		r[i] = (int*)malloc((k+1)*sizeof(int));
		r[i][0] = INT_MAX;
	}
	for (int j=0; j<=k; j++) {
		r[0][j] = 0;
	}
	
	for (int i=1; i<=k; i++) {
		for (int j=1; j<=n; j++) {
			if (a[j]>i) {
				r[i][j] = r[i][j-1];
			} else {
				r[i][j] = min(r[i][j-1], r[i-a[j]][j] +1);
			}
		}
	}
	return r[n][k];
}

```
Complexité : O(nk)
