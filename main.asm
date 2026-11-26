global _start
extern scanf
extern printf

section .data
    format_in db "%u", 0
    format_out db "entered: %u", 10, 0

section .bss
    number resq 1

section .text

_start:
    lea rdi, [rel format_in]
    lea rsi, [rel number]
    call scanf
    test rax, rax
    jz .exit
    lea rdi, [rel format_out]
    mov rsi, [rel number]
    call printf
.exit:
    mov eax, 60
    xor edi, edi
    syscall

