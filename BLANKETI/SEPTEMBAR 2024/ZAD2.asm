section .data
    TEKST db "Primer teksta za testiranje k-te reci.", 0 ; Tekst sa 0 na kraju

section .bss
    pocetak resw 1        ; Početak k-te reči
    kraj resw 1           ; Kraj k-te reči

section .text
    global _start

_start:
    mov esi, TEKST        ; Adresa teksta u ESI
    mov ecx, 3            ; K = 3, tražimo treću reč
    call nadji_rec

    ; Završetak programa
    mov eax, 1            ; syscall za izlaz
    int 0x80

nadji_rec:
    xor ebx, ebx          ; Brojač reči
    mov edi, esi          ; Početak reči u EDI

pronadji_pocetak:
    cmp byte [esi], 0
    je kraj               ; Kraj teksta

    cmp byte [esi], ' '
    jne provera_reci      ; Ako nije praznina, počni novu reč
    inc esi               ; Preskoči praznine
    jmp pronadji_pocetak

provera_reci:
    inc ebx               ; Brojač reči
    cmp ebx, ecx
    je zapamti_pocetak    ; Ako je to k-ta reč, sačuvaj početak

skip_reci:
    cmp byte [esi], ' '
    je pronadji_pocetak
    inc esi
    jmp skip_reci

zapamti_pocetak:
    mov [pocetak], esi    ; Sačuvaj početak reči
pronadji_kraj:
    cmp byte [esi], ' '
    je kraj_pronadjen     ; Ako je kraj reči
    inc esi
    jmp pronadji_kraj

kraj_pronadjen:
    mov [kraj], esi       ; Sačuvaj kraj reči
    ret

kraj:
    mov [pocetak], 0      ; Ako re
