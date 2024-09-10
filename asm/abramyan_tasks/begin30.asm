; begin30.asm
; Дано значение угла α в радианах (0 < α < 2·π). Определить значение
; этого же угла в градусах, учитывая, что 180◦ = π радианов. 
; В качестве значения π использовать 3.14
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "enter the angle in radians: ",10,0
    result_msg1 db "angle in degrees: %f",10,0
    pi dq 3.14
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    int_to_double_via_rax xmm1, 180
    mulsd xmm0, xmm1
    divsd xmm0, [pi]
    mov rdi, result_msg1
    mov rax, 1
    call printf
    leave
    ret