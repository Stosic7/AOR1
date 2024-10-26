section .data
    S dw 0                ; S zadata vrednost
    M resd 1              ; Rezultat za Mi
    N resd 1              ; Rezultat za Ni
    P resd 1              ; Rezultat za Pi

section .text
    global _start

_start:
    ; Inicijalizacija početnih vrednosti
    mov eax, 1            ; M0 = 1
    mov [M], eax
    mov dword [N], 0      ; N0 = 0
    mov dword [P], 0      ; P0 = 0
    mov ecx, 1            ; i = 1

loop_start:
    ; Izračunavanje Mi = Mi-1 + ⌈S / 8⌉
    mov eax, [M]
    mov bx, [S]
    shr bx, 3             ; S / 8
    add eax, bx           ; Mi = Mi-1 + (S / 8)
    mov [M], eax

    ; Provera da li je Mi veće od S
    cmp eax, [S]
    ja kraj

    ; Izračunavanje Ni = 5 * Mi-1 - i^2
    mov ebx, 5
    imul ebx, [M]
    sub ebx, ecx
    imul ebx, ecx         ; Ni = 5 * Mi-1 - i^2
    mov [N], ebx

    ; Izračunavanje Pi = Mi + Ni + 1
    mov eax, [M]
    add eax, [N]
    inc eax
    mov [P], eax          ; Pi = Mi + Ni + 1

    ; Uvećavanje i i ponavljanje petlje
    inc ecx
    jmp loop_start

kraj:
    ; Završetak programa
    mov eax, 1            ; syscall za izlaz
    int 0x80
