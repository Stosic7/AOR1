section .data
    A dd 0               ; 32-bitni broj A
    D dw 0               ; 16-bitni broj D
    E dd 0               ; 32-bitni broj E

section .text
    global _start

_start:
    mov ecx, 16          ; Brojač petlji (najviše 16 puta)

loop_start:
    ; E = 5 * A
    mov eax, [A]
    imul eax, 5
    mov [E], eax

    ; D = [A / 4] - [E / 8]
    mov ax, [A]
    shr ax, 2            ; A / 4
    mov bx, [E]
    shr bx, 3            ; E / 8
    sub ax, bx
    mov [D], ax

    ; Provera uslova D > E
    mov eax, [D]
    cmp eax, [E]
    jle kraj             ; Prekini ako D nije veće od E

    ; E = E + 1
    inc dword [E]

    ; A = 2 + [E / 3]
    mov eax, [E]
    mov ebx, 3
    div ebx              ; E / 3
    add eax, 2
    mov [A], eax

    dec ecx
    jnz loop_start

kraj:
    ; Završetak programa
    mov eax, 1           ; syscall za izlaz
    int 0x80
