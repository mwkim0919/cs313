.pos 0x100
testx4:
	irmovl $0x28, %eax				# %eax = 0x28
	irmovl $0x0, %ecx				# %ecx = 0x0
	irmovl $0x1, %edx				# %edx = 0x1
	irmovl $0x2, %ebx				# %ebx = 0x2
	rmmovl %eax, TheArray(%ecx,4)	# TheArray[0] = 0x28
	rmmovl %eax, TheArray(%edx,4)	# TheArray[1] = 0x28
	rmmovl %eax, TheArray(%ebx,4)	# TheArray[2] = 0x28
	
	irmovl $0x3, %ecx				# %ecx = 0x3
	irmovl $0x4, %edx				# %edx = 0x4
	irmovl $0x5, %ebx				# %ebx = 0x5
	mrmovl TheArray(%ecx,4), %esi	# %esi = TheArray[3]
	mrmovl TheArray(%edx,4), %esi	# %esi = TheArray[4]
	mrmovl TheArray(%ebx,4), %esi	# %esi = TheArray[5]

	irmovl $0x33, %eax				# %eax = 0x33
	irmovl $0x0, %ecx				# %ecx = 0x0
	irmovl $0x4, %edx				# %edx = 0x4
	rmmovl %eax, TheArray(%ecx)		# TheArray[0] = 0x33
	rmmovl %eax, TheArray(%edx)		# TheArray[1] = 0x33
	irmovl $0x8, %ecx				# %ecx = 0x8
	irmovl $0xc, %edx				# %edx = 0xc
	mrmovl TheArray(%ecx), %esi		# %esi = TheArray[2]
	mrmovl TheArray(%edx), %esi		# %esi = TheArray[3]
	halt
	
	

.align 4
.pos 0x1000
TheArray:	.long	7
	.long	7
	.long	7
	.long	1
	.long	2
	.long	3

