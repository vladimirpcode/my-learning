; begin25.asm
; Найти значение функции y = 3x^6 − 6x^2 − 7 
; при данном значении x.
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "x = ",10,0
    result_msg1 db "y = %f",10,0
    kof1        dq 3.0
    power1      dq 6
    kof2        dq 6.0
    kof3        dq 7.0
section .bss
    x resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [x], xmm0
    mov rdi, [power1]
    movsd xmm2, [x]
    call fpower
    mulsd xmm0, [kof1]
    movsd xmm1, [x]
    mulsd xmm1, xmm1
    mulsd xmm1, [kof2]
    subsd xmm0, xmm1
    subsd xmm0, [kof3]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret