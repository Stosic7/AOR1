section .data
    N db 0 ; 8-bitna vrednost za N
    A db 0 ; Početna vrednost A0
    B db 0 ; Početna vrednost B0
    S dw 0 ; Suma prvih ⌊N/2⌋ prirodnih brojeva
    C dq 0 ; Vrednost C = N^4

section .text
    global _start

_start:
    ; Inicijalizacija vrednosti za C = N^4
    movzx eax, byte [N]
    imul eax, eax, eax ; eax = N^2
    imul eax, eax, eax ; eax = N^4
    mov [C], eax

    ; Izračunavanje sume S = ∑(1 do ⌊N/2⌋)
    movzx eax, byte [N]
    shr eax, 1 ; eax = ⌊N/2⌋
    mov ecx, eax ; Broj do kog sabiramo
    xor eax, eax ; Postavljanje S na 0
    mov ebx, 1

suma_loop:
    add eax, ebx
    inc ebx
    loop suma_loop
    mov [S], eax ; Suma S smeštena u memoriju

calc_loop:
    ; Računanje A_i = (B_i + S) / C
    movzx eax, byte [B]
    add eax, [S]
    div dword [C] ; eax = (B_i + S) / C
    mov [A], eax ; Smeštanje A_i u memoriju

    ; Provera uslova A_i mod B_i == N
    movzx eax, byte [A]
    movzx ebx, byte [B]
    div ebx
    movzx ecx, byte [N]
    cmp edx, ecx
    je kraj ; Ako je uslov zadovoljen, kraj

    ; Ažuriranje vrednosti B_i = B_i-1 + 1
    movzx eax, byte [B]
    inc eax
    mov [B], al
    jmp calc_loop

kraj:
    ; Završetak programa
    mov eax, 1          ; syscall za izlaz
    int 0x80
