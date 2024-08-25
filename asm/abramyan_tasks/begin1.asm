; begin1.asm
extern input_double
extern printf
section .data
    enter_msg   db  "a = ",10,0
    result_msg  db  "P = %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, enter_msg
    mov rax, 0
    call printf
    mov rax, 4
    cvtsi2sd xmm8, rax
    call input_double
    ; mulsd xmm0, xmm8
    mov rdi, result_msg
    mov rax, 1
    call printf
    leave
    ret