section .data
    buf db 10 dup(0)
    resbuf db 12 dup(0)

section .text
    global _start

print:
    mov edx,0
p1:
    cmp byte[ecx+edx],0
    je p2
    inc edx
    jmp p1
p2:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

tostr:
    mov bx,ax
    mov edi,buf+9
t0:
    mov dx,0
    mov ax,bx
    mov si,10
    div si
    add dl,'0'
    mov [edi],dl
    dec edi
    mov bx,ax
    test bx,bx
    jnz t0
    inc edi
    mov eax,edi
    ret

to64:
    mov esi, resbuf + 11
t64:
    mov dx,0
    mov ax,cx
    mov bx,10
    div bx
    add dl,'0'
    mov [esi],dl
    dec esi
    mov cx,ax
    test cx,cx
    jnz t64
    inc esi
    mov eax,esi
    ret

_start:
    mov ax,5
    call tostr
    mov ecx,eax
    call print

    mov ax,5
    mov dx,0
    mov bx,1
l1:
    mul bx
    inc bx
    cmp bx,ax
    jbe l1

    mov cx,ax
    call to64
    mov ecx,eax
    call print

    mov eax,1
    xor ebx,ebx
    int 0x80
