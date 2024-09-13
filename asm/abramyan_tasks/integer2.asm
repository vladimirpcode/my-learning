; integer2.asm
; Дана масса M в килограммах. Используя операцию деления нацело,
; найти количество полных тонн в ней (1 тонна = 1000 кг). 

%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg   db "M (kilograms) = ",10,0
    result_msg  db "tons = %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg
    call input_int
    mov rdi, 1000
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    mov rdi, result_msg
    mov rax, 0
    call printf
    leave
    ret