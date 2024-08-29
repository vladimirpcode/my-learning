; begin7.asm
; Найти длину окружности L и площадь круга S заданного радиуса R:
; L = 2·π·R, S = π·R2. В качестве значения π использовать 3.14

%include "xmm.asm"

extern input_double
extern printf
section .data
    enter_msg   db  "R = ",10,0
    result_msg1  db  "L = %f",10,0
    result_msg2  db  "S = %f",10,0
    pi dq 3.14
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, enter_msg
    mov rax, 0
    call printf
    call input_double
    movsd xmm8, xmm0
    int_to_double_via_rax xmm0, 2
    mulsd xmm0, [pi]
    mulsd xmm0, xmm8
    mov rdi, result_msg1
    mov rax, 1
    pushxmm xmm8
    call printf
    popxmm xmm8
    movsd xmm0, [pi]
    mulsd xmm0, xmm8
    mulsd xmm0, xmm8
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret