section     .data

	msg1     		db  	'One',0xa                 ;our dear string
	len1     		equ 	$ - msg1                  ;length of our dear string
	msg2     		db  	'Two',0xa                 ;our dear string
	len2     		equ 	$ - msg2                  ;length of our dear string
  sys_write 	equ 	0x04
	stdout 			equ 	0x01


section     .text
	global      _start                              ;must be declared for linker (ld)

_start:                                         ;tell linker entry point
	xor  rdx,rdx
	mov  rax, 15
	mov  ebx, 5
	div  ebx               ; 10 / 2
	cmp  rax, 2
	je   _msg2	
	

_msg1:
	mov  edx, len1                            ;message length
	mov  ecx, msg1                            ;message to write
	mov  ebx, stdout                          ;file descriptor (stdout)
	mov  eax, sys_write                       ;system call number (sys_write)
	int  0x80                                ;call kernel
	jmp  _exit


_msg2:
	mov  edx, len2                            ;message length
	mov  ecx, msg2                            ;message to write
	mov  ebx, stdout                          ;file descriptor (stdout)
	mov  eax, sys_write                       ;system call number (sys_write)
	int  0x80                                ;call kernel
	jmp  _exit

_exit:
	mov     eax, 1                               ;system call number (sys_exit)
	int     0x80                                ;call kernel


