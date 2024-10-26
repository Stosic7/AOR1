section .data
    N db 0               ; 8-bitni broj N
    S dw 0               ; Suma prvih N/2 prirodnih brojeva
    C dd 0               ; C = N^4
    rezultat resd 1      ; Rezultat izraza

section .text
    global _start

_start:
    ; Inicijalizacija vrednosti za C = N^4
    movzx eax, byte [N]
    imul eax, eax        ; eax = N^2
    imul eax, eax        ; eax = N^4
    mov [C], eax

    ; Izračunavanje sume S = ∑(1 do N/2)
    movzx eax, byte [N]
    shr eax, 1           ; eax = N/2
    mov ecx, eax         ; Broj do kog sabiramo
    xor eax, eax         ; Reset S
    mov ebx, 1

suma_loop:
    add eax, ebx
    inc ebx
    loop suma_loop
    mov [S], eax         ; Suma S smeštena u memoriju

    ; Računanje izraza Σ(i=1 do N) (i + S) / C
    xor eax, eax         ; Reset za ukupni rezultat
    movzx ecx, byte [N]  ; i = 1 do N
    mov esi, [S]         ; Učitaj S

sum_loop:
    add eax, ecx         ; Dodaj i
    add eax, esi         ; Dodaj S
    div dword [C]        ; Podeli sa C
    add edx, eax         ; Saberi u ukupni rezultat
    dec ecx
    jnz sum_loop

    mov [rezultat], edx  ; Smeštanje rezultata

    ; Završetak programa
    mov eax, 1           ; syscall za izlaz
    int 0x80
