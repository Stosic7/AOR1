section .data
    A1 dw 7, 6, 5, 4         ; Definicija za A1 niz
    A2 dw 0x2B, 8            ; Definicija za A2 niz
    A3 dw 0xA5               ; Definicija za A3
    B1 resw 3                ; Rezervacija prostora za B1
    B2 resw 3                ; Rezervacija prostora za B2

section .text
    global _start

_start:
    ; Učitavanje podataka A1 i A2
    mov ax, [A1]          ; Učitaj A1
    add ax, [A2]          ; Dodaj A2, ne vodeći računa o prenosu

    ; Deljenje rezultata sa A2
    mov bx, [A2]
    div bx                ; Deljenje AX sa A2; rezultat u AX, ostatak u DX
    mov [B1], ax          ; Smeštanje količnika u B1
    mov dx, dx            ; Čuvanje ostatka u DX

    ; Množenje ostatka sa A3
    mov ax, dx
    mov bx, [A3]
    mul bx                ; Množenje AX sa A3; rezultat u DX:AX
    mov [B2], ax          ; Smeštanje proizvoda u B2

    ; Završetak programa
    mov eax, 1            ; syscall za izlaz
    int 0x80
