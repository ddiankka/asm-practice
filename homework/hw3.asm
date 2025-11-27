section .data
    msgPrime     db " - prime", 10, 0
    msgNotPrime  db " - not prime", 10, 0
    numbuf       db 6 dup(0)

section .text
    global _start

print_str:
    mov edx, 0
.len:
    cmp byte [ecx + edx], 0
    je .go
    inc edx
    jmp .len
.go:
    mov ebx, 1
    mov eax, 4
    int 0x80
    ret

int_to_str:
    mov bx, ax
    mov edi, numbuf + 5
.convert:
    mov dx, 0
    mov ax, bx
    mov si, 10
    div si
    add dl, '0'
    mov [edi], dl
    dec edi
    mov bx, ax
    test bx, bx
    jnz .convert
    inc edi
    mov eax, edi
    ret

check_prime:
    mov bx, ax
    cmp bx, 2
    jl .np
    cmp bx, 2
    je .p
    mov cx, 2
.loop:
    mov ax, bx
    xor dx, dx
    div cx
    cmp dx, 0
    je .np
    inc cx
    cmp cx, bx
    jl .loop
.p:
    mov eax, 1
    ret
.np:
    xor eax, eax
    ret

_start:
    mov ax, 37
    call int_to_str
    mov ecx, eax
    call print_str

    mov ax, 37
    call check_prime
    cmp eax, 1
    je .isp

.nisp:
    mov ecx, msgNotPrime
    call print_str
    jmp .end

.isp:
    mov ecx, msgPrime
    call print_str

.end:
    mov eax, 1
    xor ebx, ebx
    int 0x80
