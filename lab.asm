ASSUME cs: code, ds: data 
data SEGMENT

a db 5
b db 7
dreapta dw ?
stanga dw ? 
e dw ? 

data ENDS

code SEGMENT
start:

mov ax, data
mov ds, ax

mov al,[a]
mov ah,0
mov bl, 5
mul bl ; ax = a * 5
mov [stanga], ax

mov al,[b]
mov ah,0
mov bl, 7
div bl ; al = b / 7
mov ah,0;poate ramane rest,dar il consider 0
sub [stanga], ax ; stanga = stanga - (b / 7)

mov al,[a]
mov ah,0
mul al ; ax = a * a
mov bx, ax

mov al,3
mov ah,0
div byte ptr [b] ; al = 3 / b
mov ah,0
add ax, bx ; ax = (a * a) + (3 / b)
mov [dreapta], ax ; dreapta = (a * a) + (3 / b)

mov ax, [stanga]
xor dx, dx

mov [e], ax ; e = stanga / dreapta

mov ax, 4C00h
int 21h

code ENDS
END start




