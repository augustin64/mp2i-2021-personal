#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

uint singleton(uint);
uint union2(uint, uint);
bool has(uint, uint);
uint card(uint);

int main() {
    printf("singleton de 4: \t%d\n", singleton(4));
    printf("union {0,1} et {1,2}: \t%d\n", union2(3, 6));
    printf("{2, 4} possède 4: \t%d\n", has(20, 4));
    printf("cardinal de 17: \t%d\n", card(17));
    return 0;
}

uint singleton(uint i) {
      return 1 << i;
};

uint union2(uint s1, uint s2) {
    return s1 & s2;
};

bool has(uint s, uint e) {
    return union2(s, singleton(e)) != 0;
};

uint card(uint s) {
    uint c = 0;
    while (s != 0) {
        c++;
        s = s & (s-1);
    };
    return c;
};
