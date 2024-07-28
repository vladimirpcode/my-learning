; icalc.asm
extern printf
section .data
    number1 dq  128
    number2 dq  19
    neg_num dq  -12
    fmt     db  "The numbers are %ld and %ld",10,0
    fmtint  db  "%s %ld",10,0
    sumi    db  "The sum is",0
    difi    db  "The difference is",0
    inci    db  "Number 1 Incrementer:",0
    deci    db  "Number 1 Decrementer:",0
    sali    db  "Number 1 Shift left 2 (x4):",0
    sari    db  "Number 1 Shift right 2 (/4):",0
    sariex  db  "Number 1 Shift right 2 (/4) with "
            db  "sign extension:",0
    multi   db  "The product is",0
    divi    db  "The integer quotient is",0
    remi    db  "The modulo is",0
section .bss
    resulti resq 1
    modulo  resq 1
section .text
    global main
main:
    push rbp
    mov rbp, rsp
; Вывод чисел
    mov rdi, fmt
    mov rsi, [number1]
    mov rdx, [number2]
    mov rax, 0
    call printf
; Сложение
    mov rax, [number1]
    add rax, [number2]
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, sumi
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Вычитание
    mov rax, [number1]
    sub rax, [number2]
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, difi
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Инкремент
    mov rax, [number1]
    inc rax
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, inci
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Декремент
    mov rax, [number1]
    dec rax
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, deci
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Арифметический сдвиг влево
    mov rax, [number1]
    sal rax, 2              ;умножение rax на 4
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, sali
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Арифметический сдвиг вправо
    mov rax, [number1]
    sar rax, 2              ;деление rax на 4
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, sari
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Арифметический сдвиг вправо с распрстранением знакового разряда
    mov rax, [neg_num]
    sar rax, 2              ;деление rax на 4
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, sariex
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Умножение
    mov rax, [number1]
    imul qword [number2]    ;умножение rax на number2
    mov [resulti], rax
    ; вывести результат
    mov rdi, fmtint
    mov rsi, multi
    mov rdx, [resulti]
    mov rax, 0
    call printf
; Деление
    mov rax, [number1]
    mov rdx, 0              ;rdx должен содержать 0 перед idiv
    idiv qword [number2]    ;деление rax на number2, остаток в rdx
    mov [resulti], rax
    mov [modulo], rdx
    ; вывести результат
    mov rdi, fmtint
    mov rsi, divi
    mov rdx, [resulti]
    mov rax, 0
    call printf
    mov rdi, fmtint
    mov rsi, remi
    mov rdx, [modulo]
    mov rax, 0
    call printf
    ; выход
    mov rsp, rbp
    pop rbp
    ret
