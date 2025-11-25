assume cs: code, ds:data
data SEGMENT

a dd 0110Ah, 1010Dh, 00200003h, 10000004h
l equ ($ - a)/4
d db l dup (? )

data ENDS
code SEGMENT
START:
mov ax, data
mov ds, ax
mov es, ax
cld                         ;DF = 0
mov si, offset a            ;0
mov cx, l                   
mov di, offset d            ;0
jcxz final

repeta:
    lodsw                  ;citim cuvantul inferior
    lodsw                  ;citim cuvantul superior
                           ;punem word-urile in acumulator ca sa putem face operatiile pe ele care le dorim
    test ax, 0000000000000001b     ;verificam daca e par sau impar   
    jnz skip_par_a         ;daca CF = 1 repetam din nou  
    
    test ax, 1000000000000000b     ;verificam daca e negativ, uitandune la bitul de semn 
    jz skip_par_a          ;daca e zero, repetam din nou loop-ul   
    stosb                  ;acum putem sa-l stocam in destinatie
    
skip_par_a:
    loop repeta   
            

final:
mov ax, 4C00H
int 21h
code ENDS
end START
