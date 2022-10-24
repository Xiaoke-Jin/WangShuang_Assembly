assume cs:code

data segment
	db 11h, 22h
	dw 00ffh
data ends

code segment

start:
	mov ax, data
	mov al, 0eeh
	mov ax, [2]        ; 被编译成 mov ax, 2h
	mov ax, ds:[2]
	mov byte ptr ds:[2], 0eeh
	mov ax, 4c00h
	int 21h
code ends
end start