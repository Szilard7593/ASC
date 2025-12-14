assume cs:code, ds:data

data segment
    nrMax db 6 
    lungime db ?
    sir_intermediar db 6 dup (?)

    sir_polisat db 6 dup (?)
    sir_final db 6 dup (? )

    nr dw ?
    nr_2 dw ?
    nr_3 db ?

    fisier db 'nr.txt',0

    v1 db 10
    v2 dw 2

    identificator_creare dw ?
    identificator_deschidere dw ?
    identificar_inchidere dw ?
data ends

code segment

creare_fisier PROC
    mov ah, 3Ch
    mov cx, 0
    mov dx, offset fisier
    int 21h
    mov identificar_creare, ax
    RET
creare_fisier ENDP

deschidere_fisier PROC
    mov ah, 3Dh
    mov al, 1
    mov dx, offset fisier
    int 21h
    mov identificator_deschidere, ax
    RET
deschidere_fisier ENDP

inchidere_fisier PROC
    mov ah, 3Eh
    mov bx, identificator_deschidere
    int 21h
    RET
inchidere_fisier ENDP

scriere_fisier PROC
    mov ah, 40h 
    mov cx, 2
    mov bx, identificator_deschidere
    mov dx, offset sir_final
    int 21h
    RET
scriere_fisier ENDP


Start:

    mov ax, data
    mov ds, ax

    mov ah, 0Ah
    lea dx, nrMax
    int 21h

    mov si, offset sir_intermediar
    mov di, offset sir_polisat
    mov cl, [lungime]
    mov ch, 0
    ;mai intai cream numarul si-l pune in ax
    loop_sir_polisat:
        mov al , [si]
        sub al ,'0'
        mov [di] , al
        inc si
        inc di
        loop loop_sir_polisat

    mov si, offset sir_polisat
    mov cl, [lungime]
    mov ch, 0
    xor ax,ax
    loop_peste_sir_polisat:
        mul v1
        add ax,[si]
        inc si
        loop loop_peste_sir_polisat

    ;transformare din caractere in numar
    mov nr, ax
    mov ax , nr
    mul v2
    mov nr_2,ax
    
    call inchidere_fisier

    mov ax,4C00h
    int 21h

code ends
end start


