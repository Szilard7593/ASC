assume cs:code ,ds:data
data segment
    a db 1d,3d,-2d,-5d,3d,-8d,5d,0d
    l equ $-a 
    d1 db l dup (?)
    d2 db l dup (?)
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov si, offset a 
    mov di, offset d1
    mov cx, l
    jcxz final

    loop_d1:
        mov al, [si]
        test al, 10000000b
        jnz ii-neagtiv
        mov [di], al
        inc di
        inc si

    ii_neagtiv:
        inc si
        loop loop_d1

    mov si, offset a
    mov di, offset d2
    mov cx, l

    loop_d2:
        mov al, [si]
        test al, 10000000b
        jz ii_positiv
        mov [di], al
        inc di
        inc si
    
    ii_positiv:
        inc si
        loop loop_d2
    
    final:
        mov ax, 4C00H
        int 21h

code ends
END start