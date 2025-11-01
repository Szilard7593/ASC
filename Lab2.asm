ASSUME cs:code, ds:data

data segment
    a db 10101111b
    b dw 1011011010101010b
    e dw ?

data ends

code segment
start:
    mov ax,data
    mov ds , ax

;3. Sa se înlocuiasca primii trei biti ai cuvântului B cu ultimii trei biti ai octetului A.
    mov al , a 
    mov ah , 0 ;ax = 0000000010101111
    mov bx , b
    and ax ,0000000000000111 ; ax = 0000000000000111 
    mov cl , 13
    shl ax , cl ; ax = 1110000000000000    1110000000000000
    or  bx, ax ;  bx = 1111011010101010    1011011011011011
                ;                          ------------------ or
                ;                          1111011011011011
    
    mov e,bx
    mov ax , 4C00h ;1111011010101010 sau 63141
    int 21h

code ends
end start





