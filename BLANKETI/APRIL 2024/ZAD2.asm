section .data
    matrica resd 16      ; Matrica 4x4, 32-bitni elementi
    rezultat resd 1      ; Smeštanje rezultata procedure

section .text
    global _start

; Procedura za sumiranje dve vrednosti
suma:
    mov eax, [esi]       ; Prva vrednost u EAX
    add eax, [edi]       ; Dodaj drugu vrednost
    mov [rezultat], eax  ; Smeštanje rezultata
    ret

_start:
    ; Inicijalizacija pokazivača za matricu
    mov esi, matrica
    mov ecx, 4           ; Dimenzija matrice (4x4)

outer_loop:
    mov ebx, ecx
inner_loop:
    test bl, 1           ; Proverava da li je indeks neparan
    jz skip

    ; Postavi pokazivače i pozovi proceduru za sumiranje
    lea esi, [matrica + ebx*4] ; Element sa neparnim indeksom
    lea edi, [matrica + (ebx-1)*4] ; Susedni element
    call suma             ; Poziva proceduru
    mov [esi], eax        ; Zamenjuje element sumom

skip:
    dec ebx
    jnz inner_loop
    dec ecx
    jnz outer_loop

    ; Završetak programa
    mov eax, 1            ; syscall za izlaz
    int 0x80
