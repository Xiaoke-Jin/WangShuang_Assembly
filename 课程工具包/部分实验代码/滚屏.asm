assume cs:code,ds:data,ss:stack

data segment
	db	128 dup (0)
data ends

stack segment stack
	db	128 dup (0)
stack ends



code segment

	start:	mov ax,stack
		mov ss,ax
		mov sp,128

		call sav_old_int9
		call cpy_new_int9
		call set_new_int9


testA:		mov ax,1000H
		jmp testA

		mov ax,4C00H
		int 21H


;===================================================
new_int9:	push ax

		in al,60H
		pushf
		call dword ptr cs:[200H]

		cmp al,3EH
		je isF4

		cmp al,3BH
		jne int9Ret
		call change_screen_color


int9Ret:	pop ax
		iret


isF4:		mov di,160* 10 + 40*2
		mov bx,0B800H
		mov es,bx
		mov word ptr es:[di],5535H
		call change_screen
		jmp int9Ret

;==================================================
change_screen:	push bx
		push cx
		push dx
		push ds
		push es
		push si
		push di


		mov bx,0B800H
		mov ds,bx
		mov es,bx

		mov si,160*23 + 158
		mov di,160*24 + 158

		mov cx,160*23

		std
		rep movsb

		pop di
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		ret
;==================================================
change_screen_color:
		push bx
		push cx
		push dx
		push ds
		push es
		push si
		push di


		mov bx,0B800H
		mov ds,bx
		mov es,bx

		mov si,160
		mov di,0

		mov cx,160*23

		cld
		rep movsb

		call clear_row

		pop di
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		ret

;==============================================================
clear_row:	mov dx,0700H
		mov cx,80
		mov bx,160*24

clearRow:	mov es:[di],dx
		add di,2
		loop clearRow

		ret

int9_end:	nop


;===================================================
set_new_int9:	mov bx,0
		mov es,bx

		cli
		mov word ptr es:[9*4],OFFSET new_int9 - OFFSET new_int9 + 7E00H
		mov word ptr es:[9*4+2],0
		sti
		ret
;===================================================
sav_old_int9:	mov bx,0
		mov es,bx

		push es:[9*4]
		pop es:[200H]
		push es:[9*4+2]
		pop es:[202H]

		ret
;===================================================
cpy_new_int9:
		mov bx,cs
		mov ds,bx
		mov si,OFFSET new_int9

		mov bx,0
		mov es,bx
		mov di,7E00H

		mov cx,OFFSET int9_end - OFFSET new_int9
		cld
		rep movsb

		ret

code ends



end start

