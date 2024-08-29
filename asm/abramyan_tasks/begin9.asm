; begin9.asm
; Даны два неотрицательных числа a и b. 
; Найти их среднее геометрическое, то есть квадратный корень из их произведения: √a·b.
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "a = ",10,0
    enter_msg2   db  "b = ",10,0
    result_msg  db  "geometric mean = %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd xmm8, xmm0
    pushxmm xmm8
    printmsg enter_msg2
    call input_double
    popxmm xmm8
    mulsd xmm0, xmm8
    sqrtsd xmm0, xmm0
    mov rdi, result_msg
    mov rax, 1
    call printf
    leave
    ret