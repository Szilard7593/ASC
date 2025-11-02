ASSUME cs:code, ds:data

data segment
    a db 10101100b
    b dw 1011011010101010b
    e dw ?

data ends

code segment
start:
    mov ax,data
    mov ds , ax

;3. Sa se înlocuiasca primii trei biti ai cuvântului B cu ultimii trei biti ai octetului A.
    mov al , a 
    mov ah , 0 ;ax = 000000001010111000
    mov bx , b
    and ax , 0000000000000111b ; ax = 0000000000000'100'
    mov cl , 13
    shl ax , cl ; ax = '100'0000000000000  

    and bx , 0001111111111111b ; bx = 0001 0110 1010 1010 ; curatam biti 15-13 ai lui b

    or  bx, ax 

    ; 0001 0110 1010 1010
    ; 1000 0000 0000 0000
    ; ---------------- or
    ; 1001 0110 1010 1010
    ;or bx , 0000000000000000
    mov e,bx
    mov ax , 4C00h ; 1001 0110 1010 1010b = 38570
    int 21h

code ends
end start





