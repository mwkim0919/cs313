.pos 0x100
irmovl ESP_bot, %esp 		# %esp = ESP_bot
jmp 0x200 					# jump to 0x200

.pos 0x200
irmovl 0x50, %eax			# %eax = 0x50
irmovl 0x0, %ecx			# %ecx = 0x0
irmovl 0x4, %edx			# %edx = 0x4
irmovl 0x8, %ebx			# %ebx = 0x8
irmovl 0xc, %ebp			# %ebp = 0xc
irmovl 0x10, %esi			# %esi = 0x10

call *Array(%ecx), %edi		# jump to the value of M[Array + value of %ecx]
call *Array(%edx), %edi		# jump to the value of M[Array + value of %edx]
call *Array(%ebx), %edi		# jump to the value of M[Array + value of %ebx]
call *Array(%ebp), %edi		# jump to the value of M[Array + value of %ebp]
call *Array(%esi), %edi		# jump to the value of M[Array + value of %esi]
halt

.pos 0x300
pushl %edi					# save the value of %edi to stack
ret							# return

.pos 0x400
pushl %edi					# save the value of %edi to stack
ret							# return

.pos 0x500
pushl %edi					# save the value of %edi to stack
ret							# return

.pos 0x600
pushl %edi					# save the value of %edi to stack
ret							# return

.pos 0x700
pushl %edi					# save the value of %edi to stack
ret							# return



.pos 0x1000
Array:		.long 0x300
			.long 0x400
			.long 0x500
			.long 0x600
			.long 0x700

.pos 0x2000
ESP_top:	.long 0
			.long 0
			.long 0
			.long 0
			.long 0
			.long 0
			.long 0
			.long 0
			.long 0
			.long 0
ESP_bot:	.long 0