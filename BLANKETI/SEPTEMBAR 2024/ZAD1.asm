section .data
    A dd 0               ; 32-bitni broj A
    B dw 0               ; 16-bitni broj B
    C dw 0               ; 16-bitni broj C
    rezultat resd 1      ; Rezultat

section .text
    global _start

_start:
    mov cx, 2            ; m = 2
    xor eax, eax         ; Postavljanje rezultata na 0

loop_start:
    cmp cx, [B]          ; Proveri da li je m <= B
    ja kraj_loop

    ; Računanje 3 * m̃ - A
    mov bx, cx
    not bx               ; m̃ - komplement
    shl bx, 4            ; Zadržavanje viših polubajtova
    imul bx, 3           ; 3 * m̃
    sub bx, [A]          ; 3 * m̃ - A

    ; Računanje 2 * m + A
    mov dx, cx
    shl dx, 1            ; 2 * m
    add dx, word [A]     ; 2 * m + A

    ; Deljenje: (3 * m̃ - A) / (2 * m + A)
    mov ax, bx
    cwd                  ; Proširivanje na DX:AX za deljenje
    idiv dx              ; AX = (3 * m̃ - A) / (2 * m + A)

    add eax, eax         ; Saberi rezultat
    inc cx               ; m++
    jmp loop_start

kraj_loop:
    mov [rezultat], eax  ; Smeštanje rezultata

    ; Završetak programa
    mov eax, 1           ; syscall za izlaz
    int 0x80
