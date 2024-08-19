; begin1.asm
extern scanf
extern printf
section .data
    my_str  db  "14578",0
    fmt_str db  "%u",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, my_str
    call str_to_double
    mov rsi, rax
    mov rdi, fmt_str
    call printf
    leave
    ret
str_to_double:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14        
    mov r12, rdi    ; указатель на строку
    mov r13, 0      ; целая часть
    mov r14, 1      ; множитель
    cmp r12, 0
    je .incorect_number
    .int_loop:
        cmp byte[r12], 48
        jl .incorect_number
        cmp byte[r12], 57
        jg .incorect_number
        xor rax, rax
        mov al, byte[r12]
        sub rax, 48
        mul r14
        add r13, rax
        mov rax, 10
        mul r14
        mov r14, rax
        inc r12
        cmp byte[r12], 0
        jne .int_loop
    mov rax, r13
    pop r14
    pop r13
    pop r12
    jmp .return
    .incorect_number:
    mov rax, 0
    .return:
    leave
    ret