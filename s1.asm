assume cs:code, ds: data
data SEGMENT

a db 1
b db 1
c db 1
d dw 1
sus dw ?
e1 db ?
jos db ?
e db ?

data ends

code SEGMENT
start:
mov ax, data
mov ds , ax

mov al,b
mov bl,c
mul bl ;ax =bc
mov dx ,0
mov cx,d
div cx ; al = bc/d
mov bl , a
sub bl , al ;bl = a -bc/d
mov bh ,0
mov ax , bx
mov sus , ax ; sus = a - bc/d

mov al , c
mov bl , 2
add al , bl ;al = c + 2
mov e1 , al
mov al , a
mov ah , 0
mov cl , b
div cl ; al = a /b
sub e1 , al ; e1 = c+2 - a/b
mov bl , e1
mov jos , bl

mov  ax, sus
mov bl , jos
div jos 
mov cl , 5
add al , cl 
mov e , al
mov ax , 4C00h
int 21h
code ends
end start


