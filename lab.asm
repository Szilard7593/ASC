ASSUME cs: code, ds: data 
data SEGMENT

a db 1
b dw 7
dreapta dw ?
stanga dw ?
e1 dw ?
e db ? 

data ENDS

code SEGMENT
start:

mov ax, data
mov ds, ax

mov al,a ;bxb = w
mov bl, 5
mul bl ;ax = 5a
mov e1 , ax

mov ax , b
mov cx , 7
mov dx , 0
div cx ; ax = b/7
mov bx , e1
sub bx, ax ;bx = e1 - ax
mov dreapta,bx ; dreapta = ax - bx

mov ax , 3
mov dx, 0
mov bx , b
div bx ; al = 3/b
mov ah , 0 ; ax = 3/b

mov bl , a
mov cl , a
mul cl ;bx = a*a

add ax, bx ; ax = 3/b + a*a
mov stanga, ax

mov ax, dreapta
mov dx, 0
mov bx , stanga
div stanga 

mov e , al
mov ax , 4C00h
int 21h

code ENDS
END start




