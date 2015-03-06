#
# Calling conventions:
#     %eax, %ebx, %ecx, %edx can be used by subroutines without saving.
#     %ebp, %esi, %edi must be saved and restored if they are used.
#     %esp can not be used except for its normal use as a stack pointer.
#
#
.pos 0x100

#
# Testing for the new instructions
# 
# 
#
randl %eax 			## generate a random 32-bit number to %eax
randl %ebx			## generate a random 32-bit number to %ebx
randl %ecx			## generate a random 32-bit number to %ecx
randl %edx			## generate a random 32-bit number to %edx
randl %ebp			## generate a random 32-bit number to %ebp
randl %esi			## generate a random 32-bit number to %esi
randl %edi			## generate a random 32-bit number to %edi
randl %esp			## generate a random 32-bit number to %esp

halt
