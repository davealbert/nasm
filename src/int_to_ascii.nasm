section .bss
our_int resb 30
new_int resb 30
int_len resd 1
newint_len resd 1

section .data
welcome_msg db "Welcome to program 2.",13,10
len1 equ $ - welcome_msg
prompt_int db "Please enter an integer."
len2 equ $ - prompt_int

section .text

global _start

_start:
  ;write welcome message
  mov edx, len1
  mov ecx, welcome_msg
  mov ebx, 1
  mov eax, 4
  int 0x80

;write prompt for int
  mov edx, len2
  mov ecx, prompt_int
  mov ebx, 1
  mov eax, 4
  int 0x80

;now read int
  mov edx, 30
  mov ecx, our_int
  mov ebx, 2
  mov eax, 3
  int 0x80

;now save size of string input
  dec eax
  mov dword [int_len], eax

;now convert number
  mov edi, 10
  mov ecx, [int_len]
  mov esi, our_int
  xor eax, eax
  xor ebx, ebx

mov bl, [esi]
  cmp bl, '-'
  jne next_check
  inc eax
  inc esi
  dec ecx
  jmp done_sign
next_check: cmp bl, '+'
  jne done_sign
  inc esi
  dec ecx
done_sign: push eax

l1: mov bl, [esi]
;  cmp bl, 30h
;  jb error
;  cmp bl, 39h
;  ja error
  sub bl, 30h
  mul edi; eax = eax * 10
  mov bh, 0
  add eax, ebx
  inc esi
  loop l1

pop ebx
  cmp ebx, 1
  jne done
  neg eax

done: ;now tripple eax
  mov edi, 3
  mul edi

;convert int to string
  mov esi, new_int
  mov ebx, 10
  xor ecx, ecx
  cmp eax, 0
  jge skip_negate
  neg eax
  push dword 1; remember neg
  jmp start_convert
skip_negate: push dword 0
start_convert: xor edx, edx
  div ebx
  add dl, 30h; convert ascii
  push edx
  inc ecx
  cmp eax, 0
  jne start_convert
  mov eax, ecx
  inc eax
  inc esi
lp2: pop edx
  mov [esi], dl
  inc esi
  loop lp2
  pop edx
  cmp edx, 1
  jne positive
  mov esi, new_int
  mov [esi], byte '-'
  jmp finish
positive: mov esi, new_int
  mov [esi], byte '+'
finish:
mov [newint_len], eax

;print out new int

mov edx, dword [newint_len]
mov ecx, new_int
mov ebx, 1
mov eax, 4
int 0x80

error:
mov ebx, 0
mov eax, 1
int 0x80
