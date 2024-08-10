; function6.asm
extern printf
section .data
    first   db  "A"
    second  db  "B"
    third   db  "C"
    fourth  db  "D"
    fifth   db  "E"
    sixth   db  "F"
    seventh db  "G"
    eighth  db  "H"
    ninth   db  "I"
    tenth   db  "J"
    fmt     db  "The string is: %s",10,0
section .bss
    flist   resb    11  ; Длина строки + 0
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, flist      ; Длина
    mov rsi, first
    mov rdx, second     ; Заполнение регистров
    mov rcx, third      
    mov r8, fourth
    mov r9, fifth
    push tenth          ; Теперь начинается запись в стек
    push ninth          ; в обратном порядке
    push eighth
    push seventh
    push sixth
    call lfunc
    ; вывод результата
    mov rdi, fmt
    mov rsi, flist
    mov rax, 0
    call printf
    leave
    ret
lfunc:
    push rbp
    mov rbp, rsp
    xor rax, rax        ; очистка rax (особенно старшие биты)
    mov al, byte[rsi]   ; запись 1-ого аргумента в al
    mov [rdi], al       ; Сохранение al в памяти
    mov al, byte[rdx]   ; Запись значения 2-го аргумента в al
    mov [rdi+1], al     ; Сохранение al в памяти
    mov al, byte[rcx]   ; И т.д. для всех прочих аргументов
    mov [rdi+2], al
    mov al, byte[r8]
    mov [rdi+3], al
    mov al, byte[r9]
    mov [rdi+4], al
    ; Теперь извлечение аргументов из стека
    push rbx            ; Сохраняемый вызываемой функцией
    xor rbx, rbx
    mov rax, qword[rbp+16]  ; Первое значение: начальный указатель стека
                            ; + rip + rbp
    mov bl, byte[rax]       ; Извлечение символа
    mov [rdi+5], bl         ; Сохранение символа в памяти
    mov rax, qword[rbp+24]  ; Продолжение обработки следующего значений
    mov bl, byte[rax]
    mov [rdi+6], bl
    mov rax, qword[rbp+32]
    mov bl, byte[rax]
    mov [rdi+7], bl
    mov rax, qword[rbp+40]
    mov bl, byte[rax]
    mov [rdi+8], bl
    mov rax, qword[rbp+48]
    mov bl, byte[rax]
    mov [rdi+9], bl
    mov bl, 0
    mov [rdi+10], bl
    pop rbx                 ; Сохраняемый вызываемой функцией
    mov rsp, rbp
    pop rbp
    ret
