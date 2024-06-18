.data
prompt_fib_30: .asciiz "O valor do 30° termo da Série de Fibonacci é: "
prompt_fib_41: .asciiz "O valor do 41° termo da Série de Fibonacci é: "
prompt_fib_40: .asciiz "O valor do 40° termo da Série de Fibonacci é: "
prompt_phi:    .asciiz "O valor da razão áurea (phi) é: "

.text
.globl main

main:
    li $a0, 30
    jal fibonacci
    move $s1, $v0

    li $a0, 41
    jal fibonacci
    move $s2, $v0

    li $a0, 40
    jal fibonacci
    move $s3, $v0

    move $a0, $s2
    move $a1, $s3
    jal golden_ratio

    li $v0, 4
    la $a0, prompt_fib_30
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, prompt_fib_41
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    li $v0, 4
    la $a0, prompt_fib_40
    syscall

    li $v0, 1
    move $a0, $s3
    syscall

    li $v0, 4
    la $a0, prompt_phi
    syscall

    li $v0, 2
    mov.s $f12, $f0
    syscall

    li $v0, 10
    syscall

fibonacci:
    li $t0, 0
    li $t1, 1
    move $t2, $a0
    li $t3, 2

    bgt $t2, 1, fib_loop
    move $v0, $t2
    jr $ra

fib_loop:
    add $t4, $t0, $t1
    move $t0, $t1
    move $t1, $t4
    addi $t3, $t3, 1
    ble $t3, $t2, fib_loop

    move $v0, $t1
    jr $ra

golden_ratio:
    mtc1 $a0, $f4
    mtc1 $a1, $f6
    div.s $f0, $f4, $f6
    jr $ra