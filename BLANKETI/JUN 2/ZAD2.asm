section .data
    MAT resd NxM      ; Matrica NxM dimenzije (punjenje pre pokretanja)
    NIZ resd NxM + 1  ; Izlazni niz, dovoljne veličine, obeležen sa -1 na kraju

section .text
    global _start

_start:
    ; Pokretanje procedure za izdvajanje pozitivnih elemenata
    mov esi, MAT      ; Pokazivač na početak matrice
    mov edi, NIZ      ; Pokazivač na početak izlaznog niza
    mov ecx, NxM      ; Broj elemenata matrice (NxM)

    call izdvoji_pozitivne

    ; Završavanje programa
    mov eax, 1        ; syscall za izlaz
    int 0x80

izdvoji_pozitivne:
    ; Prolaz kroz sve elemente matrice
loop_start:
    cmp ecx, 0
    je end_loop       ; Kraj ako su svi elementi obrađeni

    ; Provera da li je broj pozitivan
    mov eax, [esi]
    cmp eax, 0
    jle skip          ; Ako je broj ≤ 0, preskoči

    ; Kopiranje pozitivnog broja u izlazni niz
    mov [edi], eax
    add edi, 4        ; Pomeri pokazivač izlaznog niza

skip:
    add esi, 4        ; Pomeri pokazivač matrice na sledeći element
    dec ecx
    jmp loop_start

end_loop:
    ; Završni element -1 na kraj izlaznog niza
    mov dword [edi], -1
    ret
