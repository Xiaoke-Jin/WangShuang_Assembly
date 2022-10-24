
code segment
; start:                   ; 如果要使用标号，需要加上 assume cs:code
    add byte ptr [bx], 1h

    mov ax, 4c00h
    int 21h
code ends

end