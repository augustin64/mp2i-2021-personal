#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool prefix(const char* pref, const char* s) {
    int n = strlen(pref);
    if (n > strlen(s)) {
        return false;
    };
    for (int i=0; i < n; i++) {
        if (pref[i] != s[i]) {
            return false;
        };
    };
    return true;
};

bool subword(const char* c1, const char* c2) {
    int n1 = strlen(c1);
    int n2 = strlen(c2);
    bool val;
    for (int i=0; i < n2-n1; i++) {
        val = true;
        for (int j=0; j < n1; j++) {
            if (c1[j] != c2[i+j]) {
                val = false;
            };
        };
        if (val) {
            return true;
        };
    };
    return false;
};

bool contains(const char* s, const char c) {
    int n = strlen(s);
    for (int i=0; i < n; i++) {
        if (c == s[i]) {
            return true;
        };
    };
    return false;
};

bool anagramme(const char* c1, const char* c2) {
    int n1 = strlen(c1);
    int n2 = strlen(c2);
    int* t1[26];
    int* t2[26];
    if (n1 != n2) {
        return false;
    };
    for (int i=0; i < 26; i++) {
        t1[i] = 0;
        t2[i] = 0;
    };
    for (int i=0; i < n1; i++) {
        t1[(int)c1[i]-96]++;
        t2[(int)c2[i]-96]++;
    };
    for (int i=0; i < 26; i++) {
        if (t1[i] != t2[i]) {
            return false;
        };
    };
    return true;
};

int hash(const char c) {
    return (int)c-96;
};

int h(const char* s, int p, int n) {
    int len = strlen(s);
    int somme = 0;
    int po = 1;
    for (int i=0; i < len; i++) {
        somme = (somme + hash(s[i]) * po)%n;
        po*=p;
    };
    return somme%n;
};

int main() {
    printf("true: %d\n", prefix("info", "informatique"));
    printf("true: %d\n", subword("for", "informatique"));
    printf("true: %d\n", anagramme("sacres", "casser"));
    printf("hash: %d\n", hash('d'));
    printf("hash: %d\n", h("patates", 31, 11867));
    return 0;
}
