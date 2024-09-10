; begin23.asm
; Даны переменные A, B, C. Изменить их значения, переместив 
; содержимое A в B, B — в C, C — в A, 
;и вывести новые значения переменных A, B, C

%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
section .data
    enter_msg1 db "a = ",10,0
    enter_msg2 db "b = ",10,0
    enter_msg3 db "c = ",10,0
    result_msg1 db "a = %f",10,0
    result_msg2 db "b = %f",10,0
    result_msg3 db "c = %f",10,0
section .bss
    a resq 1
    b resq 1
    c resq 1
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
    printmsg enter_msg3
    call input_double
    movsd [c], xmm0
    movsd xmm8, [a]
    movsd xmm9, [b]
    movsd xmm10, [c]
    movsd [b], xmm8
    movsd [c], xmm9
    movsd [a], xmm10
    mov rdi, result_msg1
    movsd xmm0, [a]
    mov rax, 1
    call printf
    mov rdi, result_msg2
    movsd xmm0, [b]
    mov rax, 1
    call printf
    mov rdi, result_msg3
    movsd xmm0, [c]
    mov rax, 1
    call printf
    leave
    ret