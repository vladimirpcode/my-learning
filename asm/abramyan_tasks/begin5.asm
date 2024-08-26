; begin4.asm
extern input_double
extern printf
section .data
    enter_msg   db  "a = ",10,0
    result_msg1  db  "V = %f",10,0
    result_msg2  db  "S = %f",10,0
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
    mulsd xmm0, xmm8
    mulsd xmm0, xmm8
    sub rsp, 16
    movsd  qword [rsp], xmm8
    mov rdi, result_msg1
    mov rax, 1
    call printf
    movsd  xmm8, qword [rsp]
    add rsp, 16
    movsd xmm0, xmm8
    mulsd xmm0, xmm0
    mov rax, 6
    cvtsi2sd xmm8, rax
    mulsd xmm0, xmm8
    mov rdi, result_msg2
    mov rax, 1
    call printf
    leave
    ret