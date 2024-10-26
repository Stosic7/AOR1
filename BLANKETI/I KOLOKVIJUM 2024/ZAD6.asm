section .data
    A1 dw 5, 6, 7         ; Definicija za A1 niz
    A2 dw 0xB2, 8         ; Definicija za A2 niz
    A3 dw 0xA5            ; Definicija za A3
    B1 resw 3             ; Rezervacija prostora za B1
    B2 resb 6             ; Rezervacija prostora za B2, širine 6 bajtova

section .text
    global _start

_start:
    ; Učitavanje podataka A1 i A2
    mov ax, [A1]          ; Učitaj A1
    add ax, [A2]          ; Dodaj A2 sa prenosom
    jo overflow           ; Provera prelivanja

    ; Deljenje rezultata sa A2
    mov bx, [A2]
    div bx                ; Deljenje AX sa A2; rezultat u AL (količnik), AH (ostatak)
    mov [B1], ax          ; Smeštanje količnika u B1
    mov dl, ah            ; Sačuvaj ostatak

    ; Množenje ostatka sa A3
    mov al, dl
    mov bl, [A3]
    mul bl                ; Množenje DL sa A3; rezultat u AX
    mov [B2], ax          ; Smeštanje proizvoda u B2

    ; Završetak programa
    mov eax, 1            ; syscall za izlaz
    int 0x80

overflow:
    ; U slučaju prelivanja
    mov eax, 1
    int 0x80
