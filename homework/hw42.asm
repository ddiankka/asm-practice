section .data
    obuf db 10 dup(0)
    rbuf db 14 dup(0)

section .text
    global _start

prt:
    mov edx,0
x0:
    cmp byte[ecx+edx],0
    je x1
    inc edx
    jmp x0
x1:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

itoa16:
    mov bx,ax
    mov edi,obuf+9
i0:
    mov dx,0
    mov ax,bx
    mov si,10
    div si
    add dl,'0'
    mov [edi],dl
    dec edi
    mov bx,ax
    test bx,bx
    jnz i0
    inc edi
    mov eax,edi
    ret

itoa64:
    mov esi,rbuf+13
j0:
    mov dx,0
    mov ax,cx
    mov bx,10
    div bx
    add dl,'0'
    mov [esi],dl
    dec esi
    mov cx,ax
    test cx,cx
    jnz j0
    inc esi
    mov eax,esi
    ret

fact:
    cmp ax,1
    jbe f1
    push ax
    dec ax
    call fact
    pop bx
    mul bx
    ret
f1:
    mov dx,0
    mov ax,1
    ret

_start:
    mov ax,6
    call itoa16
    mov ecx,eax
    call prt

    mov ax,6
    call fact
    mov cx,ax
    call itoa64
    mov ecx,eax
    call prt

    mov eax,1
    xor ebx,ebx
    int 0x80
