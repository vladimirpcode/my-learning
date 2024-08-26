; begin3.asm
extern input_double
extern printf
section .data
    enter_msg1   db  "a = ",10,0
    enter_msg2   db  "b = ",10,0
    result_msg  db  "S = %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, enter_msg1
    mov rax, 0
    call printf
    call input_double
    movsd xmm8, xmm0
    mov rdi, enter_msg2
    mov rax, 0
    sub rsp, 16
    movsd  qword [rsp], xmm8
    call printf
    call input_double
    movsd  xmm8, qword [rsp]
    add rsp, 16
    mulsd xmm0, xmm8
    mov rdi, result_msg
    mov rax, 1
    call printf
    leave
    ret