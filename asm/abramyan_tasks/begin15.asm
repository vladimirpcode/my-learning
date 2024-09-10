; begin15.asm
; Дана площадь S круга. Найти его диаметр D и длину L окружности,
; ограничивающей этот круг, учитывая, что L = 2·π·R, S = π·R^2. В качестве
; значения π использовать 3.14

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1   db  "S = ",10,0
    result_msg1  db  "D = %f",10,0
    result_msg2  db  "L = %f",10,0
    pi           dq  3.14
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    divsd xmm0, [pi]
    sqrtsd xmm0, xmm0
    movsd xmm8, xmm0         ; R
    int_to_double_via_rax xmm1, 2
    mulsd xmm0, xmm1
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm8
    call printf
    popxmm xmm8
    int_to_double_via_rax xmm1, 2
    movsd xmm0, xmm8
    mulsd xmm0, xmm1
    mulsd xmm0, [pi]
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret