global scanf
global read_input
global string_to_uint

section .bss
    input_buffer resb 128

section .text
read_input:
    xor eax, eax
    xor edi, edi
    lea rsi, [rel input_buffer]
    mov edx, 128
    syscall
    ret

string_to_uint:
    push rbx
    mov r8, rdi
    mov r9, rsi
    xor rax, rax
.convert:
    test r9, r9
    jz .convert_done
    movzx ebx, byte [r8]
    cmp bl, 10
    je .convert_done
    sub ebx, '0'
    imul rax, rax, 10
    add rax, rbx
    inc r8
    dec r9
    jmp .convert
.convert_done:
    pop rbx
    ret

scanf:
    push r12
    push r13
    mov r12, rsi
    mov r13, rdi
    cmp byte [r13], '%'
    jne .scanf_fail
    cmp byte [r13+1], 'u'
    jne .scanf_fail
    call read_input
    test rax, rax
    jle .scanf_fail
    mov rsi, rax
    lea rdi, [rel input_buffer]
    call string_to_uint
    mov [r12], rax
    mov eax, 1
    jmp .scanf_done

.scanf_fail:
    xor eax, eax

.scanf_done:
    pop r13
    pop r12
    ret

