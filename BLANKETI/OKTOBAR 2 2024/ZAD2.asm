section .data
    MATR resw MxN         ; Matrica dimenzije MxN (punjenje pre pokretanja)
    rezultat resw 1       ; Rezultat za broj brojeva deljivih sa 3

section .text
    global _start

_start:
    ; Postavljanje brojača i pokazivača na početak matrice
    mov ecx, MxN          ; Broj elemenata matrice
    mov esi, MATR         ; Pokazivač na početak matrice
    xor eax, eax          ; Resetovanje brojača deljivih sa 3

prolaz_kroz_matricu:
    mov ax, [esi]         ; Učitavanje elementa matrice
    test ax, 3            ; Provera deljivosti sa 3
    jnz skip              ; Preskoči ako nije deljiv sa 3

    inc eax               ; Ako je deljiv, uvećaj brojač

skip:
    add esi, 2            ; Pomeri pokazivač na sledeći element
    loop prolaz_kroz_matricu

    mov [rezultat], eax   ; Smeštanje broja deljivih sa 3 u rezultat

    ; Završetak programa
    mov eax, 1            ; syscall za izlaz
    int 0x80
