assume cs:code, ds:data
data SEGMENT
a db 1
b dw 7
e1 dw ?
e2 dw ?
sus dw ?
jos dw ?
ef dw ?


data ends

code SEGMENT
start:
mov ax , data
mov ds, ax

mov al , a
mov bl , 5
mul bl ; ax = 5a
mov e1, ax

mov ax , b
mov bl , 7
div bl ; al = b/7
mov ah , 0 ; ax = b/7
sub e1,ax ; sus = 5a-b/7
mov bx , e1
mov sus , bx

mov ax , 3
mov dx , 0
mov bx , b
div bx ; ax = 3/b
mov e2,ax
mov al , a 
mov bl , a
mul bl ; ax = a*a
add ax , e2 ; ax = 3/b + a*a
mov jos , ax

mov ax , sus
mov dx , 0
mov bx , jos
div bx ; ax =(5a-b/7)/(3/b + a*a)
mov ef , ax
mov ax , 4C00h
int 21h

code ends
end start

