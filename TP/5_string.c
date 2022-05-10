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
        po=(po*p)%n;
    };
    return somme%n;
};

void add(char* k, int v, int* t){
    t[h(k, 31, 11867)] = v;
};

int get(char* k, int* t) {
    return t[h(k, 31, 11867)];
};

char* sub(char* s, int i, int j) {
    char* t = (char*)malloc(sizeof(char)*(j-i));
    for (int k=i; k <= j; k++) {
        t[k-i] = s[k];
    };
    return t;
};

char* most_frequent_word(char* s, int l) {
    int t[11867];
    int n = strlen(s);
    int freq_max = 0;
    char* most_word;
    int val;
    char* word;
    for (int i=0; i < 11867; i++) {
        t[i] = 0;
    };
    for (int i=0; i < n-l; i++) {
        word = sub(s, i, i+l-1);
        val = get(word, t);
        val++;
        add(word, val, t);
        if (val > freq_max) {
            freq_max = val;
            most_word = word;
        };
    };
    return most_word;
};

int main() {
    printf("true: %d\n", prefix("info", "informatique"));
    printf("true: %d\n", subword("for", "informatique"));
    printf("true: %d\n", anagramme("sacres", "casser"));
    printf("hash: %d\n", hash('s'));
    printf("hash: %d\n", h("patates", 31, 11867));
    int t[11867];
    add("patates", 5, t);
    printf("patates: %d\n", get("patates", t));
    printf("sub: %s\n", sub("patates", 2, 4));
    printf("most_freq: %s\n", most_frequent_word("abcbcaabc", 2));
    return 0;
}
