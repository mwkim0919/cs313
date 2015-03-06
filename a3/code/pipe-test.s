.pos 0x100
fwdOrder:        irmovl $0x1, %eax        # %eax = 1
                 irmovl $0x2, %eax        # %eax = 2
                 rrmovl %eax, %ecx        # data-forwarding order (1) %ecx = 2
                 irmovl $0x1, %edx        # %edx = 1
                 irmovl $0x2, %edx        # %edx = 2
                 irmovl $0x3, %edx        # %edx = 3
                 rrmovl %edx, %ebx        # data-forwarding order (2) %ebx = 3
                 halt                     
.pos 0x200
srcAHzd:         irmovl $0x0, %eax        # %eax = 0
                 irmovl $0x0, %ecx        # %ecx = 0
                 irmovl $0x0, %edx        # %edx = 0
                 irmovl $0x0, %ebx        # %ebx = 0
                 irmovl $0x1, %eax        # r-r data hazard on srcA (1) %eax = 1
                 addl   %eax, %ebx        # %ebx = 1
                 irmovl $0x2, %ecx        # r-r data hazard on srcA (2) %ecx = 2
                 nop                      
                 addl   %ecx, %ebx        # %ebx = 3
                 irmovl $0x3, %edx        # r-r data hazard on srcA (3) %edx = 3
                 nop                      
                 nop                      
                 addl   %edx, %ebx        # %ebx = 3 + 3 = 6
                 halt                     
.pos 0x300
sBHazard:        irmovl $0x0, %eax        # %eax = 0
                 irmovl $0x0, %ecx        # %ecx = 0
                 irmovl $0x0, %edx        # %edx = 0
                 irmovl $0x10, %ebx       # %ebx = 16
                 irmovl $0x1, %eax        # r-r data hazard on srcB (1) %eax = 1 add 1 additional bubble
                 addl   %ebx, %eax        # %eax = 16 + 1 = 17
                 irmovl $0x2, %ecx        # r-r data hazard on srcB (2) %ecx = 2 add 2 additional bubble
                 nop                      
                 addl   %ebx, %ecx        # %ecx = 16 + 2 = 18
                 irmovl $0x3, %edx        # r-r data hazard on srcB (3) %edx = 3 
                 nop                      
                 nop                      
                 addl   %ebx, %edx        # %edx = 16 + 3 = 19
                 halt                     
.pos 0x400
aLoadUse:        irmovl $0x0, %eax        # %eax = 0
                 irmovl $0x0, %ecx        # %ecx = 0
                 irmovl $0x0, %edx        # %edx = 0
                 irmovl $0x0, %ebx        # %ebx = 0
                 irmovl $x, %edi          # %edi = 0x1000
                 mrmovl 0x0(%edi), %eax   # load-use data hazard on srcA (1) %eax = 10
                 addl   %eax, %ebx        # %ebx = 10
                 mrmovl 0x0(%edi), %ecx   # load-use data hazard on srcA (2) %ecx = 10
                 nop                      
                 addl   %ecx, %ebx        # %ebx = 20
                 mrmovl 0x0(%edi), %edx   # load-use data hazard on srcA (3) %edx = 10
                 nop                      
                 nop                      
                 addl   %edx, %ebx        # %ebx = 30
                 halt                     
.pos 0x500
bLoadUse:        irmovl $0x0, %eax        # %eax = 0
                 irmovl $0x0, %ecx        # %ecx = 0
                 irmovl $0x0, %edx        # %edx = 0
                 irmovl $0x10, %ebx       # %ebx = 16
                 irmovl $x, %edi          # %edi = 0x1000
                 mrmovl 0x0(%edi), %eax   # load-use data hazard on srcB (1) %eax = 10
                 addl   %ebx, %eax        # %eax = 26
                 mrmovl 0x0(%edi), %ecx   # load-use data hazard on srcB (2) %ecx = 10
                 nop                      
                 addl   %ebx, %ecx        # %ecx = 26
                 mrmovl 0x0(%edi), %edx   # load-use data hazard on srcB (3) %edx = 10
                 nop                      
                 nop                      
                 addl   %ebx, %edx        # %edx = 26
                 halt                     
.pos 0x600
takenJmp:        irmovl $0x0, %eax        # %eax = 0
                 irmovl $0x0, %ecx        # %eacx = 0
                 irmovl $0x0, %edx        # %edx = 0
                 irmovl $0x0, %ebx        # %ebx = 0
                 irmovl $0x0, %esp        # %esp = 0
                 andl   %eax, %eax        # %eax = 0 ^ 0 = 0
                 je     JT                # taken jump
                 irmovl $0x1, %ecx        # should not execute
                 irmovl $0x1, %edx        # should not execute
                 nop                      
                 halt                     
JT:              irmovl $0x1, %ebx        # should execute
                 irmovl $0x1, %esp        # should execute
                 halt                     
.pos 0x700
notTkJmp:        irmovl $0x0, %eax        
                 irmovl $0x0, %ecx        
                 irmovl $0x0, %edx        
                 irmovl $0x0, %ebx        
                 irmovl $0x0, %esp        
                 andl   %eax, %eax        
                 jne    JNT               # not-taken jump
                 irmovl $0x1, %ecx        # should execute
                 irmovl $0x1, %edx        # should execute
                 halt                     
JNT:             irmovl $0x1, %ebx        # should not execute
                 irmovl $0x1, %esp        # should not execute
                 halt                     
.pos 0x800
callRtn:         irmovl $stack, %esp      
                 irmovl $0x0, %eax        
                 irmovl $0x0, %ecx        
                 irmovl $0x0, %edx        
                 call   CR                
                 irmovl $0x1, %ecx        # should execute
                 halt                     
CR:              irmovl $0x1, %eax        
                 ret                      # return
                 irmovl $0x1, %edx        # should not execute
                 halt   
.pos 0x900
cmov:            irmovl $1, %eax
                 irmovl $2, %ebx
                 xorl   %ecx, %ecx
                 cmovne %eax, %ebx
                 addl   %ebx, %ebx
                 halt                  
.pos 0x1000
x:               .long 0x0000000a         
.pos 0xf000
                 .long 0x00000000         # runtime stack
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
stack:           .long 0x00000000         
