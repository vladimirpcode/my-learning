; begin4.asm
extern input_double
extern printf
section .data
    enter_msg   db  "d = ",10,0
    result_msg  db  "L = %f",10,0
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
    mulsd xmm0, [pi]
    mov rdi, result_msg
    mov rax, 1
    call printf
    leave
    ret