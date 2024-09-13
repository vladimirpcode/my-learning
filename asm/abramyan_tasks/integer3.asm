; integer3.asm
; Дан размер файла в байтах. Используя операцию деления нацело,
; найти количество полных килобайтов, которые занимает данный файл
; (1 килобайт = 1024 байта).

%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg   db "file size (bytes) = ",10,0
    result_msg  db "file size in KB = %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg
    call input_int
    mov rdi, 1024
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    mov rdi, result_msg
    mov rax, 0
    call printf
    leave
    ret