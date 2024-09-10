; str_to_num.asm
%include "xmm.asm"
section .data
    float_str   db  "14578.321",0
    int_str     db  "578",0
    fmt_str db  "%f",10,0
section .bss

section .text
    global input_int
    global input_double
    global str_to_double
    global str_to_int
    extern printf
    ;global main
main:
    section .data
        .inputlen    equ 50  ; длина буфера ввода
        .msg db "result: %d",10,0
    section .bss
        .input resb .inputlen+1   ; for /0
    section .text
        push rbp
        mov rbp, rsp
        mov rdi, .input
        mov rsi, .inputlen
        call reads
        mov rdi, .input
        mov rsi, .inputlen
        call str_to_int
        mov rsi, rax
        mov rdi, .msg
        mov rax, 0
        call printf
        leave
        ret

; str_to_int(rdi)->rax
str_to_int:
    push rbp
    mov rbp, rsp
    push r12
    push r13   
    push r14
    mov r12, rdi    ; указатель на строку
    mov r13, 0      ; целая часть
    mov r14, 1      ; множитель для отрицательных чисел
    .ifminus:
        cmp byte[r12], 45                   ; byte[r12] == '-'
        jne .endifminus
        inc r12
        mov r14, -1
    .endifminus:
    cmp byte[r12], 0
    je .incorect_number
    .int_loop:
        mov rax, 10
        mul r13
        mov r13, rax
        cmp byte[r12], 48
        jl .incorect_number
        cmp byte[r12], 57
        jg .incorect_number
        xor rax, rax
        mov al, byte[r12]
        sub rax, 48
        add r13, rax
        inc r12
        cmp byte[r12], 0
        jne .int_loop
    mov rax, r13
    imul rax, r14
    pop r14
    pop r13
    pop r12
    jmp .return
    .incorect_number:
    mov rax, 0
    .return:
    leave
    ret

; str_to_double(rdi)->xmm0
str_to_double:
    section .data
        .null dq 0.0
    section .text
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    mov r12, rdi    ; указатель на строку
    mov r13, 0      ; целая часть
    mov r14, 0      ; дробная часть
    mov r15, 1      ; на что потом поделить дробную часть
    int_to_double_via_rax xmm11, 1      ; множитель (для отрицательных чисел)
    .ifminus:
        cmp byte[r12], 45                   ; byte[r12] == '-'
        jne .endifminus
        inc r12
        int_to_double_via_rax xmm11, -1
    .endifminus:
    cmp byte[r12], 48
    jl .incorect_number
    cmp byte[r12], 57
    jg .incorect_number
    .int_loop:
        mov rax, 10
        mul r13
        mov r13, rax
        xor rax, rax
        mov al, byte[r12]
        sub rax, 48
        add r13, rax
        inc r12
        cmp byte[r12], 48
        jl .end_int_loop
        cmp byte[r12], 57
        jl .int_loop
    .end_int_loop:
    .if_dot:
        cmp byte[r12], 46
        jne .end_if_dot
        inc r12
        cmp byte[r12], 48
        jl .incorect_number
        cmp byte[r12], 57
        jg .incorect_number
        .drob_loop:
            mov rax, 10
            mul r14
            mov r14, rax
            xor rax, rax
            mov al, byte[r12]
            sub rax, 48
            add r14, rax
            mov rax, 10
            mul r15
            mov r15, rax
            inc r12
            cmp byte[r12], 48
            jl .end_drob_loop
            cmp byte[r12], 57
            jl .drob_loop
        .end_drob_loop:
    .end_if_dot:
    cmp byte[r12], 0
    jne .incorect_number
    cvtsi2sd xmm8, r13      ; целая часть -> float
    cvtsi2sd xmm9, r14      ; дробная часть -> float
    cvtsi2sd xmm10, r15     ; на что дробную часть делить, чтобы стала дробной
    divsd xmm9, xmm10
    addsd xmm8, xmm9
    movsd xmm0, xmm8
    mulsd xmm0, xmm11
    jmp .return
    .incorect_number:
    movsd xmm0, [.null]
    .return:
    pop r15
    pop r14
    pop r13
    pop r12
    leave
    ret
input_int:
    section .data
        .inputlen    equ 50  ; длина буфера ввода
    section .bss
        .input resb .inputlen+1   ; for /0
    section .text
        push rbp
        mov rbp, rsp
        mov rdi, .input
        mov rsi, .inputlen
        call reads
        mov rdi, .input
        call str_to_int
        leave
        ret
input_double:
    section .data
        .inputlen    equ 50  ; длина буфера ввода
    section .bss
        .input resb .inputlen+1   ; for /0
    section .text
        push rbp
        mov rbp, rsp
        mov rdi, .input
        mov rsi, .inputlen
        call reads
        mov rdi, .input
        call str_to_double
        leave
        ret
reads:
    section .data
        .NL  db  0xa
    section .bss
        .inputchar resb 1
    section .text
        push rbp
        mov rbp, rsp
        push r12        ; Регистр, сохраняемый вызываемой функцией
        push r13        ; Регистр, сохраняемый вызываемой функцией
        push r14        ; Регистр, сохраняемый вызываемой функцией
        mov r12, rdi    ; адрес буфера ввода
        mov r13, rsi    ; Максимальная длина в r13
        xor r14, r14    ; Счетчик символов
        .readc:
            mov rax, 0  ; read
            mov rdi, 1  ; stdin
            lea rsi, .inputchar   ; куда
            mov rdx, 1              ; сколько
            syscall
            mov al, [.inputchar]    ; Введен символ NL (0xa)?
            cmp al, byte[.NL]
            je .done
            inc r14     ; увеличить счетчик символов
            cmp r14, r13
            ja .readc   ; максимальное заполнение буфера, отбросить лишнее
            mov byte[r12], al ; сохранить символ в буфере
            inc r12     ; переместить указатель на следующий символ в буфере
            jmp .readc
        .done:
        mov byte [r12], 0
        pop r14
        pop r13
        pop r12
        leave 
        ret