#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int count(const char* s, char c) {
    int r = 0;
    for (int i=0; s[i] != '\0'; i++) {
        if(s[i] == c) {
            r++;
        };
    };
    return r;
};

int size(const char* s) {
    int i = 0;
    while(s[i] != '\0')
        i++;
    return i;
};

bool palindrome(char* s) {
    int n = size(s);
    for (int i=0; i< n/2; i++) {
        if (s[i] != s[n-1-i]) {
            return false;
        };
    };
    return true;
};

void copy(char* dest, const char* src) {
    int n = size(src);
    for (int i=0; i < n; i++) {
        dest[i] = src[i];
    };
};

int main() {
    for (int i=65; i<65+26; i++) {
        printf("%c", (char)i);
    };
    printf("\n");
    printf("len: %d \n", size("mp2i"));
    printf("count: %d\n", count("augustin lucas", 'u'));
    printf("palindrome: %d\n", palindrome("nonacecanon"));
    char dest[4];
    copy(dest, "mp2i");
    printf("copy: %s\n", dest);
    return 0;
}
