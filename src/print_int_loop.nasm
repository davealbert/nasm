section .data
	sys_exit        equ     1
	sys_write       equ     4
	stdout          equ     1
	endOfLine				db  		0x0A
	endOfLineLen 		equ 		$-endOfLine


section .bss
	outputBuffer    resb 		4


section .text
	global _start


_start:
	mov  esi, -9  						; Number 1
	call loop
	call _exit


loop:
	inc  esi
	add  esi, 0x30 						; Add 30 hex for ascii
	mov  [outputBuffer], esi 	; Save number in buffer
	sub  esi, 0x30
	call _print
	cmp  esi, 10
	jl   loop 
	ret


_print:	
	mov  ecx, outputBuffer 		; Store address of outputBuffer in ecx
	mov  edx, 1      					; length = one byte
	mov  eax, sys_write 			; sys_write
	mov  ebx, stdout      		; to STDOUT
	int  0x80
	call _newLine
	ret


_newLine:
	mov  ecx, endOfLine
	mov  edx, endOfLineLen		; length = one byte
	mov  eax, sys_write 			; sys_write
	mov  ebx, stdout      		; to STDOUT
	int  0x80
	ret


_exit:
	mov eax, sys_exit    			; system exit
	mov ebx, 0           			; exit 0
	int 0x80             			; call the kernel again


