assume cs:code, ds:data
data SEGMENT
s1 db 1d,2d,3d,4d 
s2 db 5d,6d,7d
l1 equ ($ - s1)
l2 equ ($ - s2)
d db l1+l2 dup (?)
data ENDS

code SEGMENT
START:
mov ax, data
mov ds, ax
mov es, ax
mov si, offset s1;0
mov di, offset d;0
mov cx, l1;4
rep movsb

mov si, offset s2
add si, l2      ;SI pointeaza la sfarsitul lui s2
dec si                    
mov cx, l2                 

lop:
    std              ;DF = 1          
    lodsb            ;DS:SI -> DS:SI -1    (parcurgem invers s2)  
    cld              ;DF = 0       
    stosb            ;ES:DI -> ES:DI +1      (deci elementele merg in continuarea lui d)         
    loop lop

mov ax, 4C00H
int 21h
