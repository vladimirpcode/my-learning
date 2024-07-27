;alive.asm
section .data
    msg1    db     "Hello, World!",10,0
    msg1Len equ     $-msg1-1                ; длина без 0
    msg2    db     "Alive and Kicking!",10,0
    msg2Len equ     $-msg2-1
    radius  dq      357
    pi      dq      3.14
section .bss
section .text
    global main
main:
    push    rbp         ; Пролог функции
    mov     rbp, rsp    ; Пролог функции
    mov     rax, 1      ; 1 = write
    mov     rdi, 1      ; 1 = stdout
    mov     rsi, msg1   ; 
    mov     rdx, msg1Len
    syscall
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, msg2
    mov     rdx, msg2Len
    syscall
    mov     rsp, rbp    ; Эпилог функции
    pop     rbp         ; Эпилог функции
    mov     rax, 60
    mov     rdi, 0
    syscall
