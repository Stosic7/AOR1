#include <stdio.h>

#define MAX_SIZE 10
int matrica[MAX_SIZE][MAX_SIZE];

extern void reverse_array(short* arr, int n);

int main() {
    int n;
    printf("Unesite dimenziju matrice (n): ");
    scanf("%d", &n);

    printf("Unesite elemente matrice:\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%d", &matrica[i][j]);
        }
    }

    // Okreće redosled elemenata u drugoj polovini svake vrste
    for (int i = 0; i < n; i++) {
        reverse_array((short*) &matrica[i][n/2], n/2);
    }

    printf("Transformisana matrica:\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", matrica[i][j]);
        }
        printf("\n");
    }

    return 0;
}


//----------------- ASSEMBLER DEO ------------------------//
section .text
    global reverse_array

; Procedura za okretanje niza u obrnutom redosledu
; Parametri:
;   ESI - adresa niza
;   ECX - broj elemenata u nizu
reverse_array:
    push ebx
    mov ebx, ecx
    shr ecx, 1            ; Sredina niza
reverse_loop:
    mov ax, [esi + ecx*2] ; Učitaj element sa kraja
    xchg ax, [esi + ebx*2 - 2 - ecx*2] ; Zameni elemente
    mov [esi + ecx*2], ax ; Zapiši obrnuti element
    dec ecx
    jnz reverse_loop
    pop ebx
    ret
