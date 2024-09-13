; integer1.asm
; Дано расстояние L в сантиметрах. Используя операцию деления
; нацело, найти количество полных метров в нем (1 метр = 100 см)

%include "xmm.asm"
%include "print.asm"

extern input_int
extern printf
section .data
    enter_msg   db "L (centimeters) = ",10,0
    result_msg  db "meters = %d",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg
    call input_int
    mov rdi, 100
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    mov rdi, result_msg
    mov rax, 0
    call printf
    leave
    ret