section .data
    buffer db 20 dup(0)      ; буфер для результата

section .text
    global _start
    global int2str

; -------------------------------------------
; Функция int2str
; Вход:
;   eax — число
;   esi — адрес буфера
; Выход:
;   esi — указатель на строку
; -------------------------------------------

int2str:
    mov ecx, 0          ; счётчик цифр

.convert_loop:
    mov edx, 0
    mov ebx, 10
    div ebx             ; eax = eax/10, edx = остаток

    add dl, '0'         ; превращаем цифру в символ
    dec esi
    mov [esi], dl       ; кладём символ в буфер

    inc ecx             ; увеличиваем длину строки
    test eax, eax
    jnz .convert_loop

    ; вернуть указатель на строку
    mov eax, esi
    ret

; -------------------------------------------
; Точка входа
; -------------------------------------------

_start:
    mov eax, 1234567     ; число для конвертации
    mov esi, buffer+20   ; указываем на конец буфера
    call int2str         ; вызываем функцию int2str

    ; напечатать строку в stdout
    mov edx, 20          ; макс длина
    mov ecx, eax         ; указатель на строку
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; выход
    mov eax, 1
    xor ebx, ebx
    int 0x80
