sys_exit        equ     1
sys_write       equ     4
stdout          equ     1

SECTION .bss
lpBuffer    resb    4

SECTION .text
GLOBAL _start
_start:
    xor     esi, esi

.NextNum:
    call    PrintNum
    inc     esi
    cmp     esi, 100
    jna     .NextNum

.Exit:                                 
    mov     eax, sys_exit                
    xor     ebx, ebx                      
    int     80h                           

;~ #####################################################################
PrintNum:   
    push    lpBuffer
    push    esi 
    call    dwtoa

    mov     edi, lpBuffer
    call    GetStrlen
    inc     edx
    mov     ecx, lpBuffer

    mov     eax, sys_write
    mov     ebx, stdout
    int     80H     
    ret     

;~ #####################################################################    
GetStrlen:
    push    ebx
    xor     ecx, ecx
    not     ecx
    xor     eax, eax
    cld
    repne   scasb
    mov     byte [edi - 1], 10
    not     ecx
    pop     ebx
    lea     edx, [ecx - 1]
    ret

