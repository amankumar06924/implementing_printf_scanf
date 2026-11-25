global printf
global uint_to_string

section .bss
 buffer resb 32

section .text

printf:
 push rbx
 push r12
 push r13
 push r14
 mov r12, rdi
 mov r13, rsi
 mov r14, rdx
 xor ebx, ebx ; argument counter
.parse:
 mov al,[r12]
 test al,al
 jz .finish
 cmp al,'%'
 je .specifier
 mov [rel buffer],al
 mov eax,1
 mov edi,1
 lea rsi,[rel buffer]
 mov edx,1
 syscall
 inc r12
 jmp .parse
.specifier:
 inc r12
 mov al,[r12]
 cmp al, 'u'
 je .unsigned
 inc r12
 jmp .parse
.unsigned:
 cmp ebx,0
 je .arg1
 cmp ebx,1
 je .arg2
 xor eax,eax
 jmp .convert
.arg1:
 mov rdi,r13
 jmp .convert
.arg2:
 mov rdi,r14
.convert:
 inc ebx
 lea rsi, [rel buffer]
 call uint_to_string
 mov rdx,rax
 mov eax,1
 mov edi,1
 lea rsi,[rel buffer]
 syscall
 inc r12
 jmp .parse
.finish:
pop r14
pop r13
pop r12
pop rbx
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






























