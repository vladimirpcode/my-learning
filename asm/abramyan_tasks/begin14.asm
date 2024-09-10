; begin14.asm
; Дана длина L окружности. Найти ее радиус R и площадь S круга,
; ограниченного этой окружностью, учитывая, что L = 2·π·R, S = π·R^2. В
; качестве значения π использовать 3.14

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "L = ",10,0
    result_msg1  db  "R = %f",10,0
    result_msg2  db  "S = %f",10,0
    pi           dq  3.14
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    int_to_double_via_rax xmm1, 2
    divsd xmm0, xmm1
    divsd xmm0, [pi]
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm0
    call printf
    popxmm xmm0
    mulsd xmm0, xmm0
    mulsd xmm0, [pi]
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret