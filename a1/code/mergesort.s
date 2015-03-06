	.file	"mergesort.c"
	.text
	.p2align 4,,15
	.globl	copy
	.type	copy, @function
copy:
.LFB11:
	.cfi_startproc
	cmpq	%rsi, %rdi
	movq	%rdx, %rax
	ja	.L2
	movq	%rdx, %r8
	movq	%rdi, %rcx
	.p2align 4,,10
	.p2align 3
.L4:
	addq	$4, %rcx
	movl	-4(%rcx), %r9d
	addq	$4, %r8
	cmpq	%rcx, %rsi
	movl	%r9d, -4(%r8)
	jae	.L4
	subq	%rdi, %rsi
	shrq	$2, %rsi
	leaq	4(%rax,%rsi,4), %rax
.L2:
	rep ret
	.cfi_endproc
.LFE11:
	.size	copy, .-copy
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.text
	.p2align 4,,15
	.globl	print
	.type	print, @function
print:
.LFB12:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$array, %ebx
	.p2align 4,,10
	.p2align 3
.L8:
	movl	(%rbx), %esi
	xorl	%eax, %eax
	movl	$.LC0, %edi
	addq	$4, %rbx
	call	printf
	cmpq	$array+52, %rbx
	jne	.L8
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	print, .-print
	.p2align 4,,15
	.globl	merge
	.type	merge, @function
merge:
.LFB13:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	4(%rsi), %rax
	movq	%rdi, %rcx
	movl	$temp, %r8d
	.p2align 4,,10
	.p2align 3
.L11:									# comment 
	cmpq	%rdx, %rax			# if (%rax > %rdx) go to next instruction     	// while loop - condition: (first > mid)
	ja	.L25							# go to L25													// go to else of while loop
.L31:
	cmpq	%rsi, %rcx				# if (%rcx > %rsi) go to next instruction		// while loop - condition (second > last)
	ja	.L25							# go to L25													// go to else of while loop
	movl	(%rcx), %r10d		# %r10d = value of %rcx  								// %rcx = second
	movl	(%rax), %r9d 		# %r9d = value of %rax 								// %rax = first
	cmpl	%r9d, %r10d			# %if (%r10d > %r9d) go to next instruction 	// if statement - condition: (first < second)
	jg	.L12							# go to L12													// go to then of if statement
	movl	%r10d, (%r8)		# %r8 = %r10d 											// *dest = *second
	addq	$4, %rcx				# add 4 to %rcx 											// *second++
	addq	$4, %r8					# add 4 to %r8 											// *dest++
	cmpq	%rdx, %rax			# if %rax <= %rdx go to next instruction 			// while loop - condition: (first <= mid)
	jbe	.L31						# go to L31													// go to then of while loop
.L25:
	cmpq	%rcx, %rsi
	movq	%r8, %r11
	movq	%rax, %r10
	movq	%rcx, %rbx
	jb	.L16
	.p2align 4,,10
	.p2align 3
.L18:
	addq	$4, %rcx
	movl	-4(%rcx), %r9d
	addq	$4, %r8
	cmpq	%rcx, %rsi
	movl	%r9d, -4(%r8)
	jae	.L18
	subq	%rbx, %rsi
	shrq	$2, %rsi
	leaq	4(%r11,%rsi,4), %r8
.L16:
	cmpq	%rax, %rdx
	jb	.L19
	movq	%r8, %rcx
	.p2align 4,,10
	.p2align 3
.L21:
	addq	$4, %rax
	movl	-4(%rax), %esi
	addq	$4, %rcx
	cmpq	%rax, %rdx
	movl	%esi, -4(%rcx)
	jae	.L21
	subq	%r10, %rdx
	shrq	$2, %rdx
	leaq	4(%r8,%rdx,4), %r8
.L19:
	subq	$4, %r8
	movl	$temp, %eax
	cmpq	%rax, %r8
	jb	.L10
	.p2align 4,,10
	.p2align 3
.L28:
	addq	$4, %rax
	movl	-4(%rax), %edx
	addq	$4, %rdi
	cmpq	%rax, %r8
	movl	%edx, -4(%rdi)
	jae	.L28
.L10:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L12:									
	.cfi_restore_state
	movl	%r9d, (%r8)			# %r8 = %r9d			// *dest = *first
	addq	$4, %rax				# add 4 to %rax		// *first++
	addq	$4, %r8					# add 4 to %r8		// *dest++
	jmp	.L11						# jump to L11			// return to while loop
	.cfi_endproc
.LFE13:								
	.size	merge, .-merge
	.p2align 4,,15
	.globl	mergesort
	.type	mergesort, @function
mergesort:
.LFB14:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	cmpq	%rsi, %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	jb	.L35
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L35:
	.cfi_restore_state
	movq	%rsi, %rax
	subq	%rdi, %rax
	sarq	$2, %rax
	movq	%rax, %rdx
	shrq	$63, %rdx
	addq	%rdx, %rax
	sarq	%rax
	leaq	(%rdi,%rax,4), %r12
	movq	%r12, %rsi
	call	mergesort
	leaq	4(%r12), %rdi
	movq	%rbp, %rsi
	call	mergesort
	movq	%rbx, %rdi
	movq	%rbp, %rdx
	movq	%r12, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	merge
	.cfi_endproc
.LFE14:
	.size	mergesort, .-mergesort
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$array+48, %esi
	movl	$array, %edi
	call	mergesort
	xorl	%eax, %eax
	call	print
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.comm	temp,52,32
	.globl	array
	.data
	.align 32
	.type	array, @object
	.size	array, 52
array:
	.long	4
	.long	15
	.long	6
	.long	2
	.long	21
	.long	17
	.long	11
	.long	16
	.long	8
	.long	13
	.long	14
	.long	1
	.long	9
	.ident	"GCC: (SUSE Linux) 4.8.1 20130909 [gcc-4_8-branch revision 202388]"
	.section	.note.GNU-stack,"",@progbits
