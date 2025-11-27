section .data
    star db "*",0
    nl   db 10,0

section .text
    global _start

print:
    mov edx,0
a0:
    cmp byte[ecx+edx],0
    je a1
    inc edx
    jmp a0
a1:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

print_star:
    mov ecx,star
    call print
    ret

print_nl:
    mov ecx,nl
    call print
    ret

_start:
    mov bl,AH
    mov bh,AL

    mov dl,0
row_loop:
    mov cl,0
col_loop:
    mov al,cl
    cmp dl,0
    je border
    cmp dl,bh
    je border
    cmp cl,0
    je border
    cmp cl,bl
    je border

    cmp cl,dl
    je diag1
    mov al,bl
    sub al,cl
    cmp al,dl
    je diag2

    jmp space

border:
    call print_star
    jmp next

diag1:
    call print_star
    jmp next

diag2:
    call print_star
    jmp next

space:
    mov ecx,nl
    mov byte[nl],32
    call print
    mov byte[nl],10
next:
    inc cl
    cmp cl,bl
    jbe col_loop

    call print_nl
    inc dl
    cmp dl,bh
    jbe row_loop

    mov eax,1
    xor ebx,ebx
    int 0x80
