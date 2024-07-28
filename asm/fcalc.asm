; fcalc.asm
extern printf
section .data
    number1     dq  9.0
    number2     dq  73.0
    fmt         db  "The numbers are %f and %f",10,0
    fmtfloat    db  "%s %f",10,0
    f_sum       db  "The float sum of %f and %f is %f",10,0
    f_dif       db  "The float difference of %f and %f is %f",10,0
    f_mul       db  "The float product of %f and %f is %f",10,0
    f_div       db  "The float division of %f by %f is %f",10,0
    f_sqrt      db  "The float square of %f is %f",10,0
section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    ; Вывод чисел
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi,fmt
    mov rax,2               ; два числа с плавающей точкой
    call printf
    ; Вычисление суммы
    movsd xmm2, [number1]
    addsd xmm2, [number2]
    ; Вывод результата
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, f_sum
    mov rax, 3              ; три числа с плавающей точкой
    call printf
    ; Вычисление разности
    movsd xmm2, [number1]
    subsd xmm2, [number2]
    ; Вывод результата
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rdi, f_dif
    mov rax, 3
    call printf
    ; Умножение
    movsd xmm2, [number1]
    mulsd xmm2, [number2]
    ; Вывод результата
    mov rdi, f_mul
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rax, 3
    call printf
    ; Деление
    movsd xmm2, [number1]
    divsd xmm2, [number2]
    ; Вывод результата
    mov rdi, f_div
    movsd xmm0, [number1]
    movsd xmm1, [number2]
    mov rax, 3
    call printf
    ; Вычисление квадратного корня
    sqrtsd xmm1, [number1]
    ; Вывод результата
    mov rdi, f_sqrt
    movsd xmm0, [number1]
    mov rax, 2
    call printf
    ; exit
    mov rsp, rbp
    pop rbp
    ret

