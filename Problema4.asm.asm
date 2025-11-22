assume cs:code, ds:data
data SEGMENT
    a db 1d, 2d, 3d, 4d, 5d, 6d, 7d, 8d
    l equ ($ - a)
    d db l dup (?)
data ENDS

code SEGMENT
START:
    mov ax, data
    mov ds , ax
    mov es , ax

    mov si, offset a
    mov di, offset d
    mov cx, l
    mov bx, 0
    jcxz final

    loop_a_par:
        mov al, [si]
        test bl, 1
        jnz skip_a_impar
        stosb
    skip_a_impar:
        inc si
        inc bl
        loop loop_a_par

    mov si, offset a
    mov cx, l
    mov bx, 0

    loop_a_impar:
        mov al, [si]
        test bl,1
        jz skip_a_par
        stosb

    skip_a_par:
        inc si
        inc bl
        loop loop_a_impar

    final:
        mov ax, 4C00H
        int 21h
code ENDS
END START