section     .text
global      _start                              ;must be declared for linker (ld)

_start:                                         ;tell linker entry point

		mov     eax,1
		add     eax,6
		sub     eax,5                               ;system call number (sys_exit)
		
    int     0x80                                ;call kernel

