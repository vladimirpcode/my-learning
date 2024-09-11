; begin34.asm
; Известно, что X кг конфет стоит A рублей. 
; Определить, сколько стоит 1 кг и Y кг этих же конфет.

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "X kg = ",10,0
    enter_msg2 db "A rub = ",10,0
    enter_msg3 db "Y kg = ",10,0
    enter_msg4 db "B rub = ",10,0
    result_msg1 db "One kilogram of chocolates costs: %f",10,0
    result_msg2 db "One kilogram of toffee costs: %f",10,0
    result_msg3 db "Chocolates are %f times more expensive than toffees",10,0
section .bss
    x_kg resq 1
    a_rub resq 1
    y_kg resq 1
    b_rub resq 1
    x_one_kg resq 1
    y_one_kg resq 1
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
    movsd [y_kg], xmm0
    printmsg enter_msg4
    call input_double
    movsd [b_rub], xmm0
    movsd xmm0, [a_rub]
    divsd xmm0, [x_kg]
    movsd [x_one_kg], xmm0
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [b_rub]
    divsd xmm0, [y_kg]
    movsd [y_one_kg], xmm0
    mov rdi, result_msg2
    mov rax, 1
    call printf
    movsd xmm0, [x_one_kg]
    movsd xmm1, [y_one_kg]
    divsd xmm0, xmm1
    mov rdi, result_msg3
    mov rax, 1
    call printf
    leave
    ret