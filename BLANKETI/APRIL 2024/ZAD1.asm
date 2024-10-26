section .data
    A dd 0               ; 32-bitni broj A
    B dw 0               ; 16-bitni broj B
    C dw 0               ; 16-bitni broj C
    rezultat resd 1      ; Rezultat izraza

section .text
    global _start

_start:
    ; Inicijalizacija: 1 / (B + C)
    mov ax, [B]
    add ax, [C]
    mov bx, ax           ; B + C u BX
    mov ax, 1
    cwd                  ; Proširivanje na DX:AX za deljenje
    div bx               ; AX = 1 / (B + C)

    ; Priprema za sumu
    mov si, 2            ; m = 2
    xor edx, edx         ; Rezultat za sumu

sum_loop:
    cmp si, [B]          ; Proveri da li je m <= B
    ja end_sum           ; Ako je m > B, završava se suma

    ; Računanje izraza (3 * m̃ - A) / (2 * m + A)
    mov ax, si           ; m
    not ax               ; m̃ - komplement
    imul ax, 3           ; 3 * m̃
    sub ax, [A]          ; 3 * m̃ - A

    ; Računanje 2 * m + A
    mov cx, si
    shl cx, 1            ; 2 * m
    add cx, word [A]     ; 2 * m + A

    ; Deljenje (3 * m̃ - A) / (2 * m + A)
    cwd                  ; Proširivanje na DX:AX za deljenje
    idiv cx              ; AX = (3 * m̃ - A) / (2 * m + A)
    add dx, ax           ; Dodavanje rezultata u sumu

    inc si               ; m++
    jmp sum_loop

end_sum:
    imul dx, bx          ; Množenje rezultata sa 1 / (B + C)
    mov [rezultat], dx   ; Smeštanje rezultata

    ; Završetak programa
    mov eax, 1           ; syscall za izlaz
    int 0x80
