section .data
    niz dw 1, 2, 3, 0, 5, 6, 7, 0, 9, 10, 0 ; Niz sa nulom kao završnim elementom
    rezultat resw 1                         ; Rezultat sabiranja

section .text
    global _start

; Procedura za sumiranje dve vrednosti
suma:
    mov ax, [esi]        ; Prva vrednost u AX
    add ax, [edi]        ; Dodaj drugu vrednost
    mov [rezultat], ax   ; Smeštanje rezultata
    ret

_start:
    ; Postavljanje pokazivača i iteriranje kroz niz
    mov esi, niz
    xor ecx, ecx         ; Brojač za indeksiranje

niz_loop:
    ; Provera kraja niza
    mov ax, [esi + ecx*2]
    cmp ax, 0
    je kraj_niza         ; Kraj ako je element nula

    ; Ako je element na svakoj trećoj poziciji, saberi sa susedima
    mov ebx, ecx
    mov edx, 3
    div edx              ; Proverava da li je indeks deljiv sa 3
    cmp dx, 0
    jne skip

    ; Postavi pokazivače i pozovi proceduru za sumiranje
    lea edi, [esi + ecx*2 - 2] ; Levi sused
    lea esi, [esi + ecx*2 + 2] ; Desni sused
    call suma                  ; Poziv procedure za sumiranje

    mov [esi + ecx*2], ax      ; Zamenjuje element sumom

skip:
    add ecx, 1
    jmp niz_loop

kraj_niza:
    ; Završetak programa
    mov eax, 1           ; syscall za izlaz
    int 0x80
