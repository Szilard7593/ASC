assume cs:code , ds:data
data SEGMENT
a dw 1
b db 1
e1 dd ?
sus dd ?
jos dw ?
e3 dw ?
e4 dw ?
ef dw ?



data ends

code SEGMENT
start:
mov ax , data
mov ds, ax

mov ax , 5
mov bx , a
mul bx ; dx:ax = 5a
mov word ptr [e1 + 2] , dx
mov word ptr [e1] , ax

mov al , b
mov bl , b
mul bl ; ax = b*b
mov bx , 5
mul bx ; dx:ax = 5b^2

add ax , word ptr [e1];dx:ax = 5a + 5b*b
adc dx , word ptr [e1 + 2]
mov word ptr [sus] , ax
mov word ptr [sus+2] , dx

mov al , b
mov bl , 2
mul bl ; ax = 2b
mov jos , ax ; jos = 2b

mov dx , word ptr [sus + 2]
mov ax , word ptr [sus]
mov bx , jos
div bx ; ax = sus/jos
mov e3 , ax

mov ax ,a
mov bl , b
mov bh , 0
add bx , ax ; bx = a + b
mov e4 , bx

mov ax , e3
mov bx , e4
sub ax , bx
mov ef , ax

mov ax , 4C00h
int 21h

code ends
end start

