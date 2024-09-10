; begin22.asm
; Поменять местами содержимое переменных A и B и вывести новые
; значения A и B.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1 db "a = ",10,0
    enter_msg2 db "b = ",10,0
    result_msg1 db "a = %f",10,0
    result_msg2 db "b = %f",10,0
section .bss
    a resq 1
    b resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [a], xmm0
    printmsg enter_msg2
    call input_double
    movsd [b], xmm0
    movsd xmm0, [a]
    movsd xmm1, [b]
    movsd [a], xmm1
    movsd [b], xmm0
    movsd xmm0, [a]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [b]
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret