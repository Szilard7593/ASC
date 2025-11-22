assume cs:code, ds:data
data SEGMENT
a db 2d, 1d, 3d, 3d, 4d, 2d, 6d
b db 4d, 5d, 7d, 6d, 2d, 1d
l_a equ $ - a
l_b equ $ - b
r db l_a + l_b dup (?)
data ENDS

code SEGMENT
START:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov si , offset b 
    mov cx, l_b ; punem in cx lungimea lui b
    add si, l_b ; punem soarce indexul la finalul lui b
    dec si ; si ponteaz actre ultima pozitie a lui b , 
            ;pentru ca daca lansam pozitia normala el va fi pointer la un element ca nu exista
    mov di, offset r
 ; di pointeaz actre ultima pozitie a lui r
    ; setam DF = 1 pentru a copia de la sfarsit catre inceput

    loop_b:
    std
        lodsb
        cld
        stosb
        

        loop loop_b
    cld      ; la final setam DF = 0

    mov si, offset a
    mov di, offset r
    add di, l_b ; di pointeaz actre prima pozitie libera din r
    mov cx, l_a ; punem in cx lungimea lui a
    loop_a:; verificam care elemente din a sunt impare, folosind test, care creeaza o operatie de and intre al si o masca
        lodsb; luam urmatorul element din a
        test al,1;verificam daca e par sau impar, echiva;ent cu puteam sa 
        ;mov bl, al
        ;and bl, 1
        ;mov al,bl
        ;jnz skip_par_a
        ;stosb

        jz skip_par_a
        stosb; punem elementul impar in r

    skip_par_a:
        loop loop_a ; facem din nou loop-ul

    mov ax, 4C00H
    int 21h
code ENDS
end START