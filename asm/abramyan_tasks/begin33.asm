; begin33.asm
; Известно, что X кг конфет стоит A рублей. 
; Определить, сколько стоит 1 кг и Y кг этих же конфет.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "X = ",10,0
    enter_msg2 db "A = ",10,0
    enter_msg3 db "Y = ",10,0
    result_msg1 db "One kilogram of sweets costs: %f",10,0
    result_msg2 db "Y kilograms of sweets costs: %f",10,0
section .bss
    x_kg resq 1
    a_rub resq 1
    y resq 1
    one_kg resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [x_kg], xmm0
    printmsg enter_msg2
    call input_double
    movsd [a_rub], xmm0
    printmsg enter_msg3
    call input_double
    movsd [y], xmm0
    movsd xmm0, [a_rub]
    divsd xmm0, [x_kg]
    movsd [one_kg], xmm0
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [one_kg]
    mulsd xmm0, [y]
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret