; console1.asm
section .data
    msg1        db  "Hello, World!",10,0
    msg1len     equ $-msg1
    msg2        db  "Your turn: ",0
    msg2len     equ $-msg2
    msg3        db  "You answered: ",0
    msg3len     equ $-msg3
    inputlen    equ 10      ;длина буфера ввода
section .bss
    input resb inputlen+1   ; Обеспечение места для завершающего 0
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rsi, msg1
    mov rdx, msg1len
    call prints
    mov rsi, msg2
    mov rdx, msg2len
    call prints
    mov rsi, input      ; адрес буфера ввода
    mov rdx, inputlen   ; длина буфера ввода
    call reads         ; ожидание ввода
    mov rsi, msg3
    mov rdx, msg3len
    call prints
    mov rsi, input      
    mov rdx, inputlen   
    call prints         
    leave   
    ret
prints:
    push rbp
    mov rbp, rsp
    ; rsi - адрес строки
    ; rdx - длина строки
    mov rax, 1          ; 1 - write
    mov rdi, 1          ; 1 = stdin
    syscall
    leave
    ret
reads:
    push rbp
    mov rbp, rsp
    ; rsi - адрес буфера ввода
    ; rdi - длина буфера ввода
    mov rax, 0      ; 0 - чтение
    mov rdi, 1      ; 1 - stdin
    syscall
    leave
    ret



