```c
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>


```

## III.1 Fonction déterminant si s est bien parenthésée
```c
bool bien_parenthese(char* s) {
	int n = strlen(s);
	int ouvertes = 0;
	for (int i=0; i < n; i++) {
		if (s[i] == '(')
			ouvertes++;
		else {
			if (ouvertes == 0) {
				printf("Erreur ligne 1 colonne %d\n", i+1);
				return false;
			} else {
				ouvertes--;
			}
		}
	}
	if (ouvertes == 0)
		return true;
	printf("Erreur ligne 1 colonne %d\n", n-1);
	return false;
}

```

## III.3 Fonction déterminant la longueur maximale bien parenthèsée dans une expression
```c
int longueur_max_sous_mot(char* s) {
	int n = strlen(s);
	int dernier_indice[n];
	int ouvertes = 0;
	int longueur_max = 0;
	bool verif = true;
	int hauteur[n];
	for (int i=0; i < n; i++) {
		dernier_indice[i] = -1;
	}
	for (int i=0; i<n; i++) {
		if (s[i] == '(') {
			ouvertes++;
		} else {
			ouvertes--;
		}
		hauteur[i] = ouvertes;
		if (dernier_indice[ouvertes] == -1)
			dernier_indice[ouvertes] = i;
		if (i-dernier_indice[ouvertes]>longueur_max) {
			verif = true;
			for (int j=dernier_indice[ouvertes]; j<i; j++) {
				verif = verif && hauteur[j] >= ouvertes;
			}
			if (verif)
				longueur_max = i-dernier_indice[ouvertes];
		}
	}
	return longueur_max;
}

```

## III.2
 On utilise une pile contenant les dernières parenthèses ouvrantes   


```c
int main() {
	printf("bien parenthésée: %d ()()\n\n", bien_parenthese("()()"));
	printf("bien parenthésée: %d )()\n\n", bien_parenthese(")()"));
	printf("bien parenthésée: %d ((()())(\n\n", bien_parenthese("((()())()"));
	printf("longueur max: %d\n", longueur_max_sous_mot("(()()(("));
}

```
