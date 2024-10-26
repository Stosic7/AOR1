#include <stdio.h>

#define MAX_SIZE 100

short matrica[MAX_SIZE][MAX_SIZE];
short niz[MAX_SIZE * MAX_SIZE + 3];

int main() {
    int m, n;
    printf("Unesite dimenzije matrice M i N: ");
    scanf("%d %d", &m, &n);

    printf("Unesite elemente matrice:\n");
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%hd", &matrica[i][j]);
        }
    }

    // Kopiranje elemenata matrice u niz po kolonama
    int idx = 0;
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < m; i++) {
            asm (
                "movw (%1), %%ax;"
                "movw %%ax, (%0);"
                : "=r" (niz[idx])
                : "r" (&matrica[i][j])
                : "ax"
            );
            idx++;
        }
    }

    // Dodavanje tri uzastopne nule na kraj niza
    niz[idx++] = 0;
    niz[idx++] = 0;
    niz[idx++] = 0;

    // Prikaz niza pre tri uzastopne nule
    printf("Elementi niza pre tri uzastopne nule:\n");
    for (int i = 0; i < idx - 3; i++) {
        printf("%hd ", niz[i]);
    }
    printf("\n");

    return 0;
}
