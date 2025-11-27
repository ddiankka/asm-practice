section .text
global sort

sort:
    push si
    push di
    push cx
    push bx

    mov dx,cx
    mov ax,bx
    mov cx,dx
copy_loop:
    cmp cx,0
    je copy_end
    mov dl,[si]
    mov [di],dl
    inc si
    inc di
    dec cx
    jmp copy_loop
copy_end:

    pop bx
    pop cx
    pop di
    pop si

    mov bp,cx
    mov dx,bp

outer:
    cmp dx,bx
    jbe done
    mov si,di
    mov ax,dx
    sub ax,bx
    mov cx,ax

inner:
    cmp cx,0
    je next_outer
    push cx

    mov bx,[si]
    mov ax,[si+1]

    cmp bx,ax
    jbe ok

    mov [si],ax
    mov [si+1],bx

ok:
    inc si
    pop cx
    dec cx
    jmp inner

next_outer:
    dec dx
    jmp outer

done:
    ret
