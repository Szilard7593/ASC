assume cs:code , ds: data
data segment
    sir db 'a', 'c', 'r', 'c','a', 'c', 'r', 'c'
    l equ $ - sir
    r dw ?
data ends

code segment
Start:
    mov ax , data
    mov ds, ax
    
    mov si, offset sir
    mov cx,l
    mov bx, 0
    jcxz final

    loop_sir:
        mov al, [si]
        cmp al, 'c'
        jne aici
        inc bx

    aici:
        inc si
        loop loop_sir
 
    final:
        mov r, bx
        mov ax, 4C00h
        int 21h

    code ends
    end start


    

    


