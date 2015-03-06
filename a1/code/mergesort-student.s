#
# Calling conventions:
#     %eax, %ebx, %ecx, %edx can be used by subroutines without saving.
#     %ebp, %esi, %edi must be saved and restored if they are used.
#     %esp can not be used except for its normal use as a stack pointer.
#
# Argument are passed through the registers indicated in the comments. None
# of the 
#
.pos 0x100

main:	irmovl bottom,  %esp     # initialize stack
	irmovl array, %esi       # %esi = pointer to first element of the array
	xorl   %eax, %eax        # %edi = size
	mrmovl size(%eax), %edi
	irmovl $1, %eax          # %edi = size - 1
	subl   %eax, %edi
	addl   %edi, %edi        # %edi = 4 * (size - 1)
	addl   %edi, %edi
	addl   %esi, %edi        # %edi = pointer to last element of the array.
	call   mergesort
	halt

#
# Mergesort
#    %esi: pointer to the first element of the range to sort.
#    %edi: pointer to the last element of the range to sort.
#

mergesort:
	pushl  %ebp             # save %ebp before using it.

	rrmovl %edi, %eax	# is first < last ?
	subl   %esi, %eax
	jle    done             # if not, done.

	rrmovl %esi, %ebp       # %ebp = mid. Note the use  of ANDL.
	addl   %edi, %ebp       # Since we're doing arithmetic  with
	irmovl $2,   %eax       # pointers, we can not rely only  on
	divl   %eax, %ebp       # integer division to ensure  we get
	irmovl $0xfffffffc, %eax# a valid pointer.
	andl   %eax, %ebp       

	pushl  %edi             # mergesort(first, mid)
	rrmovl %ebp, %edi
	call   mergesort
	popl   %edi

	pushl  %esi             # mergesort(mid+1, last)
	rrmovl %ebp, %esi
	irmovl $4, %eax
	addl   %eax, %esi
        call   mergesort
	popl   %esi

	call   merge            # merge(first, mid, last)

done:	popl   %ebp             # restore saved value of %ebp
	ret

#
# Merge
#    %esi: pointer to the first element of the range to merge.
#    %ebp: pointer to the middle element of the range to merge.
#    %edi: pointer to the last element of the range to merge.
#

merge:
	pushl  %esi	           # %esi is the pointer "first"
	rrmovl %ebp, %edx          # %edx is the pointer "second"
	irmovl $4,   %eax
	addl   %eax, %edx
	irmovl temp, %ecx          # %ecx is pointer "dest"

mergeloop1:	
	rrmovl %ebp, %eax		# %eax = mid
	subl %esi, %eax			# %eax = %eax - %esi = mid -first
	jl mergeloop2				# if (mid < first) go to mergeloop2
	
	rrmovl %edi, %ebx		# %ebx = last
	subl %edx, %ebx			# %ebx = %ebx - %edx = last - second
	jl mergeloop2				# if (last < second)go to mergeloop2
	
	mrmovl (%edx), %eax	# %eax = *second
	mrmovl (%esi), %ebx	# %ebx = *first
	subl %ebx, %eax				# %eax = %eax - %ebx = *second - *first
	jge then							# if (*first <= *second) go to then

	mrmovl (%edx), %eax	# %eax = *second
	rmmovl %eax, (%ecx)	# *dest = *second
	irmovl $4, %ebx				# %ebx = 4
	addl %ebx, %edx				# %esi = %esi + 4 = *second++
	addl %ebx, %ecx				# %ecx = %ecx + 4 = *dest++
	jmp mergeloop1				# go to mergeloop1 = go back to while loop
	
then:	
	mrmovl (%esi), %eax	# %eax = *first
	rmmovl %eax, (%ecx)	# *dest = *first
	irmovl $4, %ebx				# %ebx = 4
	addl %ebx, %esi				# %esi = %esi + 4 = *first++
	addl %ebx, %ecx				# %ecx = %ecx + 4 = *dest++
	jmp mergeloop1				# go to mergeloop1 = go back to while loop
	
	
mergeloop2:
	pushl  %ebp
	pushl  %edi

	rrmovl %ebp, %edi         # Copy A[i] ... A[mid] to temp.
	rrmovl %ecx, %ebp
	call   copy

	popl   %edi               # Copy A[j] ... A[last] to temp.
	rrmovl %edx, %esi
	call   copy
	
	pushl  %edi	          # Copy temp back to A[first] ... A[last]
	irmovl temp, %esi
	rrmovl %ebp, %edi
	irmovl $4, %eax
	subl   %eax, %edi
	mrmovl 8(%esp), %ebp     # Move value of %esi saved on the stack to %ebp
        call   copy

	popl   %edi
	popl   %ebp
	popl   %esi
	ret

#
# Copy helper.
#    %esi [input]: pointer to the first element to copy.
#    %edi [input]: pointer to the last element to copy.
#    %ebp [input & output]: pointer to where the elements go.
#	
copy:
	pushl  %esi

copyloop:	
	rrmovl %edi, %eax
	subl   %esi, %eax
	jl     copyend

	mrmovl 0(%esi), %eax
	rmmovl %eax, 0(%ebp)

	irmovl $4, %eax
	addl   %eax, %esi
	addl   %eax, %ebp
	jmp    copyloop

copyend:
	popl   %esi
	ret

#
# Array to sort
#
.pos 0x1000
array:	.long 4
        .long 15
        .long 6
        .long 2
        .long 21
	.long 17
	.long 11
	.long 16
	.long 8
	.long 13
	.long 14
	.long 1
	.long 9

#
# Temporary array.
#
temp:   .long 0,13

#	
# Array size.
#	
size:   .long 13
	
#
# Stack (32 thirty-two bit words is more than enough here).
#
.pos 0x3000
top:	            .long 0x00000000,0x20     # top of stack.
bottom:             .long 0x00000000          # bottom of stack.
