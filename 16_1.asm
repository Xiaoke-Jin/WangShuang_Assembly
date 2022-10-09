assume cs:code, es:data1

data1 segment
    a db 1, 2, 10
    b db 1, 2, 10
data1 ends
code segment
start:
    mov ax, data1
    mov es, ax

    mov al, a      ; 使用 es 作为段寄存器

    mov ah, 4ch
    int 21h
code ends


end start