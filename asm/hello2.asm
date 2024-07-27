;hello2.asm
section .data
    msg db  "hello, world",0
    NL  db  0xa ; Код ASCII для перехода на новую строку
section .bss
section .text
    global main
main:
    mov rax, 1      ; 1 = write
    mov rdi, 1      ; 1 = stdout
    mov rsi, msg    ; Выводимая строка
    mov rdx, 12     ; Длина строки без завершающего 0
    syscall
    mov rax, 1      ; 1 = write
    mov rdi, 1      ; 1 = stdout
    mov rsi, NL     ; Вывод символа перевода на новую строку
    mov rdx, 1      ; Длина строки
    syscall
    mov rax, 60     ; 60 = exit
    mov rdi, 0      ; 0 = код успешного завершения программы
    syscall