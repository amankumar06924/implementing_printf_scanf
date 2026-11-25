global _start
extern printf

section .data
  formate db "number=",10,0

section .text

_start:
  mov rdi, formate
  mov rsi, 12345
  call printf

  mov edi,0
  jmp end

end:
  mov rax, 60
  syscall
