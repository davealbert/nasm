sys_exit        equ     1
sys_write       equ     4
stdout          equ     1

section .bss
	outputBuffer    resb    4

section .text
	global _start

_start:
	mov  ecx, 1  							; Number 1
  add  ecx, 30h 						; Add 30 hex for ascii
	mov  [outputBuffer], ecx 	; Save number in buffer
	mov  ecx, outputBuffer 		; Store address of outputBuffer in ecx

	mov  eax, sys_write 			; sys_write
	mov  ebx, stdout      		; to STDOUT
	mov  edx, 1      					; length = one byte
	int  0x80

	mov eax, sys_exit    			; system exit
	mov ebx, 0           			; exit 0
	int 80h             			; call the kernel again

