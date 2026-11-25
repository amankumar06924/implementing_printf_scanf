global printf
global uint_to_string

section .text 
printf:
 mov rdx, rsi
 mov rsi, rdi
 mov rax, 1
 mov rdi, 1
 syscall
 ret

uint_to_string:
 mov rax, rdi    ;store value in rax
 mov r8,  rsi    ;buffer starting address
 mov r9,  rsi    ;current writting position
 xor r10d, r10d  ;character count
.convert:
 xor edx, edx
 mov ecx, 10
 div rcx
 add dl,'0'
 mov [r9] ,dl
 inc r9
 inc r10
 test rax, rax
 jnz .convert
 mov byte [r9], 0 ;add null terminator
 mov rsi, r8
 lea r11, [r9-1]

 .reverse:
 cmp rsi,r11
 jae .done
 mov al,[rsi]
 mov dl,[r11]
 mov [rsi], dl
 mov [r11], al
 inc rsi
 dec r11
 jmp .reverse

.done:
mov rax,r10
ret


