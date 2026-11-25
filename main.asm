global _start

extern printf
extern uint_to_string
section .bss
 buffer resb 32

section .data
  message db "hello bitch",10
  length equ $ - message

section .text

_start:
 ; mov rdi, message
 ; mov rsi, length
 ; call printf
 mov rdi, 18446744073709551615
 lea rsi, [rel buffer] ;buffer address
 call uint_to_string
 mov rsi,rax ;uint_to_string return length so we store in rsi
 lea rdi,[rel buffer]
 call printf
  mov edi,0
  jmp end

end:
  mov rax, 60
  syscall
