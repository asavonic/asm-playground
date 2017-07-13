.text                                # section declaration

                                     # we must export the entry point to the ELF linker or
  .global main                       # loader. They conventionally recognize _start as their
                                     # entry point. Use ld -e foo to override the default.


        ## %rdi = i32 array ptr, %rsi = size
array_rand:
        pushq   %rbp
        movq    %rsp, %rbp

        pushq   %r12
        pushq   %r13

        movq    %rsi, %r12      # size
        movq    %rdi, %r13      # array

array_rand_body:
        cmp     $0, %r12
        jle     array_rand_exit

        call    rand
        movl    %eax, (%r13)
        addq    $4, %r13
        subq    $1, %r12
        jmp     array_rand_body

array_rand_exit:
        popq    %r13
        popq    %r12
        leave
        ret


        ## %rdi = i32 array ptr, %rsi = size
array_print:
        pushq   %rbp
        movq    %rsp, %rbp

        pushq   %r12
        pushq   %r13

        movq    %rsi, %r12      # size
        movq    %rdi, %r13      # array

array_print_body:
        cmp     $0, %r12
        jle     array_print_exit


        movl    (%r13), %esi
        movq    $format_single_int, %rdi
        xor     %rax, %rax
        call    printf

        addq    $4, %r13
        subq    $1, %r12
        jmp     array_print_body

array_print_exit:
        popq    %r13
        popq    %r12
        leave
        ret

bubble_sort:
        pushq   %rbp
        movq    %rsp, %rbp

        pushq   %r12
        pushq   %r13

        movq    %rsi, %r12     # size
        movq    %rdi, %r13     # array

bubble_sort_body_outer:
        movq    $0, %rax       # swapped
        movq    $1, %rbx       # i
bubble_sort_body_inner:
        imulq   $4, %rbx, %rdx
        addq    %r13, %rdx     # arr + i

        movl    (%rdx), %r8d   # arr[i]
        movl    -4(%rdx), %r9d # arr[i - 1]

        cmp     %r8d, %r9d
        jl      bubble_sort_body_inner_inc

        movl    %r8d, -4(%rdx) # swap arr[i - 1] and arr[i]
        movl    %r9d, (%rdx)
        movq    $1, %rax       # set swapped flag
bubble_sort_body_inner_inc:
        addq    $1, %rbx
        cmp     %r12, %rbx
        jl      bubble_sort_body_inner

        cmp     $0, %rax
        jne     bubble_sort_body_outer

        popq    %r13
        popq    %r12
        leave
        ret


main:
        pushq	%rbp
        movq	%rsp, %rbp

        movq    $10, %r12       # size
        movq    $4, %rax
        imul    %r12, %rax      # sizeof array

        subq    %rax, %rsp
        movq    %rsp, %r13      # array

        movq    %r12, %rsi
        movq    %r13, %rdi
        call    array_rand

        movq    %r12, %rsi
        movq    %r13, %rdi
        call    bubble_sort

        movq    %r12, %rsi
        movq    %r13, %rdi
        call    array_print

        movq  $0, %rdi               # flush all
        call  fflush

        movq  $1, %rax               # normal exit
        movq  $0, %rbx
        int   $0x80


.data                                # section declaration

format_single_int:
       .ascii    "%d\n" # our dear string
len = . - format_single_int                # length of our dear string
