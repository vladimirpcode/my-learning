; begin27.asm
; Дано число A. Вычислить A^8, используя вспомогательную 
; переменную и три операции умножения. 
; Для этого последовательно находить A^2, A^4, A^8. 
; Вывести все найденные степени числа A
%include "xmm.asm"
%include "print.asm"

extern input_double
extern printf
extern fpower
section .data
    enter_msg1 db "a = ",10,0
    result_msg1 db "A^2 = %f",10,0
    result_msg2 db "A^4 = %f",10,0
    result_msg3 db "A^8 = %f",10,0
section .bss
    a resq 1
    temp resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    printmsg enter_msg1
    call input_double
    movsd [a], xmm0
    movsd [temp], xmm0
    mulsd xmm0, xmm0
    movsd [temp], xmm0
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd xmm0, [temp]
    mulsd xmm0, xmm0
    movsd [temp], xmm0
    mov rdi, result_msg2
    mov rax, 1
    call printf
    movsd xmm0, [temp]
    mulsd xmm0, xmm0
    mov rdi, result_msg3
    mov rax, 1
    call printf
    leave
    ret