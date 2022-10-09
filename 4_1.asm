; assume cs:code

data segment
    a db 16 dup(0)
data ends

code segment
; start:                   ; 如果要使用标号，需要加上 assume cs:code
    mov ax, 123h

    mov ax, 4c00h
    int 21h
code ends

end