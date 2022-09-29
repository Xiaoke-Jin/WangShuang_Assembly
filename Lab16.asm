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

		mov al,4
		mov ah,1

		call cpy_new_int7CH   ; 安装
		call set_new_int7CH   ; 设置中断向量

		int 7CH

		mov ax,4C00H
		int 21H


;===================================================================== 需要安装的程序的开头
new_int7CH:	jmp int7CH_START

FUNCTION_ADDRESS dw	OFFSET clear_screen 		    - OFFSET new_int7CH + 200H
			dw	OFFSET set_pre_screen_color 	- OFFSET new_int7CH + 200H
			dw	OFFSET set_back_screen_color	- OFFSET new_int7CH + 200H
			dw	OFFSET roll_screen_up 		    - OFFSET new_int7CH + 200H
; 01 23 45 67
int7CH_START:
		push ax
		push bx
		push es

; ah 存储功能号：0 清屏、1 设置前景色、2 设置背景色、3 表示向上滚动一行
; 对于 1、2 号功能，用 al 传递颜色值
		mov bx,0
		mov es,bx

		mov bl,ah
		mov bh, 0
		add bx,bx
		add bx,OFFSET FUNCTION_ADDRESS - OFFSET new_int7CH + 200H

		call word ptr es:[bx]


		; call clear_screen
		; call set_pre_screen_color
		; call set_back_screen_color
		; call roll_screen_up

		; mov ax,4C00H
		; int 21H

		pop es
		pop bx
		pop ax
int7CHRet:	iret




;=====================================================================
; 向上滚动一行
roll_screen_up:	push bx
		push cx
		push ds
		push es
		push si
		push di

		mov bx,0B800H
		mov ds,bx
		mov es,bx

		mov di,0				;es:[di] = ds:[si]
		mov si,160

		mov cx,23*80

		cld
		rep movsw

		pop di
		pop si
		pop es
		pop ds
		pop cx
		pop bx
		ret
;=====================================================================
; 设置背景色
set_back_screen_color:
		push ax
		push bx
		push cx
		push es

		mov bx,0B800H
		mov es,bx

		mov cl,4
		shl al,cl


		mov bx,1
		mov cx,2000

setBackScreenColor:
		and byte ptr es:[bx],10001111B
		or es:[bx],al
		add bx,2
		loop setBackScreenColor

		pop es
		pop cx
		pop bx
		pop ax
		ret
;=====================================================================
; 设置前景色
set_pre_screen_color:
		push ax
		push bx
		push cx
		push es

		mov bx,0B800H
		mov es,bx

		mov bx,1
		mov cx,2000

setPreScreenColor:
		and byte ptr es:[bx],11111000B
		or es:[bx],al
		add bx,2
		loop setPreScreenColor

		pop es
		pop cx
		pop bx
		pop ax
		ret
;=====================================================================
; 清屏
clear_screen:	push bx
		push cx
		push es

		mov bx,0B800H
		mov es,bx

		mov bx,0
		mov dx,0700H
		mov cx,2000

clearScreen:	mov es:[bx],dx
		add bx,2
		loop clearScreen

		pop es
		pop cx
		pop bx
		ret


int7CH_end:	nop
;===================================================================== 需要安装的程序的末尾



;=====================================================================
set_new_int7CH:
		mov bx,0
		mov es,bx

		cli
		mov word ptr es:[7CH*4],200H     ; 设置 中断 7CH 的中断向量
		mov word ptr es:[7CH*4+2],0
		sti
		ret
;=====================================================================
cpy_new_int7CH:	mov bx,cs
		mov ds,bx
		mov si,OFFSET new_int7CH

		mov bx,0
		mov es,bx
		mov di,200H     ; 安装到 0000:0200

		mov cx,OFFSET int7CH_end - OFFSET new_int7CH
		cld
		rep movsb

		ret

code ends

end start

