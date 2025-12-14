assume cs:code, ds:data

data segment
    nrMax db 6 
    lungime db ?
    sir_intermediar db 6 dup (?)

    sir_final db 8 dup (?) 

    nr_1 dw ?
    nr_2 dw ?
    
    fisier db 'nr.txt',0
    file_handle dw ?      

    v1 dw 10              
    v2 dw 2

    mesaj_eroare db 'Eroare la fisier$'
    mesaj2 db 'numar de 4 cifre obligaoriu, introfuceti din nou: $'

data ends

code segment

eroare PROC
    mov ah, 09h
    mov dx, offset mesaj_eroare
    int 21h
    ret
eroare ENDP

eroare_2 PROC
    mov ah, 09h
    mov dx, offset mesaj2
    int 21h
    ret
eroare_2 ENDP

linieNoua PROC
    mov ah, 02h
    mov dl, 0Dh     
    int 21h
    mov dl, 0Ah     
    int 21h
    ret
linieNoua ENDP

Start:

    mov ax, data
    mov ds, ax

    inceput:

        mov ah, 0Ah
        lea dx, nrMax
        int 21h

        mov si, offset sir_intermediar
        xor cx, cx
        mov cl, [lungime]
        
        xor ax, ax          
        xor bx, bx         
        
        loop_str_to_int:
            mul v1     
            
            mov bl, [si]    
            sub bl, '0'     
            add ax, bx      
            
            inc si
            loop loop_str_to_int

        cmp ax, 10000
        ja mesaj_2

        mul v2              
        mov nr_2, ax 

        mov ax, nr_2        
        mov bx, 10
        mov si, offset sir_final
        xor cx, cx          

        convert_loop:
            xor dx, dx      
            div bx          
            push dx         
            inc cx         
            cmp ax, 0       
            jne convert_loop

        mov [lungime], cl   
        mov di, offset sir_final
        
        pop_loop:
            pop dx        
            add dl, '0'     
            mov [di], dl
            inc di
            loop pop_loop
        
    
        mov ah, 3Ch
        mov cx, 0
        mov dx, offset fisier
        int 21h

        jc mesaj_1          
        mov file_handle, ax 

        mov ah, 40h
        mov bx, file_handle
        xor cx, cx
        mov cl, [lungime]   
        mov dx, offset sir_final
        int 21h
        jc mesaj_1


        mov ah, 3Eh
        mov bx, file_handle
        int 21h

        jmp final

mesaj_1:
    call eroare

mesaj_2:
    call eroare_2
    adaugare_linie_noua:
        call linieNoua
    jmp inceput

final:
    mov ax, 4C00h
    int 21h

code ends
end start