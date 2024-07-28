; stack.asm
extern printf
section .data
    strng   db  "C++ - good programming language",0
    strngLen    equ $ - strng -1 ; len without 0
    fmt1    db  "The original string: %s",10,0
    fmt2    db  "The reversed string: %s",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    ; Вывод исходной строки
    mov rdi, fmt1
    mov rsi, strng
    mov rax, 0
    call printf
    ; проталкивание строки в стек
    xor rax, rax
    mov rbx, strng
    mov rcx, strngLen
    mov r12, 0              ; как указатель
    pushLoop:
        mov al, byte[rbx+r12]   ; Запись символа в rax
        push rax
        inc r12
        loop pushLoop
    ; выталкивание строки из стека
    mov rbx, strng
    mov rcx, strngLen
    mov r12, 0
    popLoop:
        pop rax
        mov byte[rbx+r12], al   ; Запись символа в строку strng
        inc r12
        loop popLoop
    mov byte[rbx+r12], 0    ; нуль терминирование строки
    ; Вывод реверсированной строки
    mov rdi, fmt2
    mov rsi, strng
    mov rax, 0
    call printf
    mov rsp, rbp
    pop rbp
    ret
    