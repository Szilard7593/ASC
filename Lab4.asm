assume cs:code ,ds:data
data segment
    nrMax db 100
    lungime db ?
    a db 100 dup (?)
    r db 100 dup (0)

data ends
code segment
Start:

    mov ax, data
    mov ds, ax
    mov es,ax

    citim_sir:
        mov ah,0Ah
        lea dx,nrMax
        int 21h

    adaugare_linie_noua:
        mov ah, 02h
        mov dl, 0Dh     ; CR(cariedge return) - revine la începutul liniei
        int 21h
        mov dl, 0Ah     ; LF(line feed) - coboară o linie
        int 21h
    
    mov si, offset a 
    mov di, offset r 
    mov cl, [lungime] 
    mov ch, 0
    jcxz final
    cld

    loop_par:
        mov al, [si]
        test al,1
        jnz impar
        mov [di] , al
        inc di

    impar:
        inc si
        loop loop_par

    mov byte ptr [di], '$' ;creeaza outpul random, de ce?
    ;1234 -> 2434, de unde 34?
    ;dadea overwrite la linia introdusa ceeea ce crea numai
    ;sa apara schimbate primele elemente
    printam_sir:
        mov ah,09h
        mov dx, offset r
        int 21h

    final:
        mov ax,4C00h
        int 21h

code ends
end start