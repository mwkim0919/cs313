Geon Young Park (22835136)
Minwoo Kim (66294083)

2.
test1) passed
expected = 0 stall, result = 0 stall
result: at the end: eax = 2, ecx = 2, edx = 3, edx = 3 as 

test2) passed
expected = 0 stall, result = 0 stall
result: at the end: eax = 1, ecx = 2, edx = 3, ebx = 6 as expected

test3) passed
expected = 0 stall, result = 0 stall
result: at the end: eax = 17, ecx = 18, edx = 19, ebx = 16 as expected

test4) passed
expected = 1 stall after each mrmovl, result = 1 stall after each mrmovl
result: at the end: eax = 10, ecx = 10, edx = 10, ebx = 30, edi = 4096 as expected

test5) passed
expected = 1 stall after each mrmovl, result = 1 stall after each mrmovl
result: at the end: eax = 26, ecx = 26, edx = 26, ebx = 16, edi = 4096 as expected

test6) passed
expected = 0 stall (especially after je), result = 0
result: successfully jumped to JT without any stall since we always predict that jumps are taken.
		ebx = 1, esp = 1 as expected

test7) passed
expected = 2 stalls after jne, result = 2 stalls after jne
result: successfully did not jump to JNT with 2 stalls since we always predict that jumps are taken
		ecx = 1, edx = 1 as expected

test8) passed
expected = 3 stalls after ret, result = 3 stalls after ret
result: successfully returned to the instruction irmovl $0x1, %ecx after three stalls
		eax = 1, ecx = 1 as expected

test9) passed
expected = 0 stall
result: successfully moved value of %eax into %ebx without any stall since we always predict that conditions are true
at the end: eax = 1, ecx = 0, ebx = 4 as expected


4.
PipeMinus
sum.s
cCnt = 117
iCnt = 45
CPI = 117 / 45 = 2.6

max.s
cCnt = 236
iCnt = 98
CPI = 236 / 98 = 2.408

mergesort-student.s
cCnt = 5035
iCnt = 2055
CPI = 5035 / 2055 = 2.450

Pipe
sum.s
cCnt = 57
iCnt = 45
CPI = 57 / 45 = 1.27

max.s
cCnt = 128
iCnt = 98
CPI = 128 / 98 = 1.31

mergesort-student.s
cCnt = 2756
iCnt = 2055
CPI = 2756 / 2055 = 1.34


6.
test 1,2,3,4,5,8,9 remained the same as the previous tests.

test6) passed
expected = 2 stall (especially after je), result = 2
result: successfully jumped to JT with 2 stall since we always predict that backward jumps are taken.
		ebx = 1, esp = 1 as expected

test7) passed
expected = 0 stalls after jne, result = 0 stalls after jne
result: successfully did not jump to JNT without any stalls since we always predict that backward jumps are taken
		ecx = 1, edx = 1 as expected

7.
Pipe (Advanced)
sum.s
cCnt = 57
iCnt = 45
CPI = 57 / 45 = 1.27

max.s
cCnt = 110
iCnt = 98
CPI = 110 / 98 = 1.12

mergesort-student.s
cCnt = 2562
iCnt = 2055
CPI = 2562 / 2055 = 1.25


Time Taken: 35hr