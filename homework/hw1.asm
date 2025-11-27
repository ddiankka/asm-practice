section .data
    msg db "Hello from Assembly!", 0Ah

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 22
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
