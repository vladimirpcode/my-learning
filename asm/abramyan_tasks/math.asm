; math.asm
%include "xmm.asm"
section .data
section .bss
section .text
    global fpower

; power(xmm2, rdi)->xmm0
fpower:
    section .data
        power_counter dq -1
    section .bss
    section .text
        push rbp
        mov rbp, rsp
        .if_eq_minus_one:
            cmp rdi, -1
            jne .end_if_eq_minus_one
            int_to_double_via_rax xmm0, 1
            divsd xmm0, xmm2
            leave
            ret
        .end_if_eq_minus_one:
        .if_eq_null:
            cmp rdi, 0
            jne .end_if_eq_null
            int_to_double_via_rax xmm0, 1
            leave
            ret
        .end_if_eq_null:
        .if_eq_one:
            cmp rdi, 1
            jne .end_if_eq_one
            movsd xmm0, xmm2
            leave
            ret
        .end_if_eq_one:
        .if_gt_null:
            cmp rdi, 0
            jle .else
            mov [power_counter], rdi
            movsd xmm0, xmm2
            .while_power_counter_gt_one:
                mulsd xmm0, xmm2
                mov rax, [power_counter]
                dec rax
                mov [power_counter], rax
                cmp rax, 1
                jg .while_power_counter_gt_one
            .end_while1:
            leave
            ret
        .else:
            ; rdi < -1
            mov [power_counter], rdi
            movsd xmm1, xmm2
            .while_power_counter_lt_minus_one:
                mulsd xmm1, xmm2
                mov rax, [power_counter]
                inc rax
                mov [power_counter], rax
                cmp rax, -1
                jl .while_power_counter_lt_minus_one
            .end_while2:
            int_to_double_via_rax xmm0, 1
            divsd xmm0, xmm1
            leave
            ret
