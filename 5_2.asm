; assume cs:code

code segment
    mov ax, cs:[1]   ; CS  2E
    mov ax, [bx]
    mov ax, es:[2]   ; ES  26
    mov ax, ss:[3]   ; SS  36

    mov ax, 4c00h
    int 21h

code ends

end