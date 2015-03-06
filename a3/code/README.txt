Names:		Minwoo Kim
			Geon Young Park

Student #:	66294083
			22835136

Question 1:

First bug:
For test case sBHazard, the expected register values, after all the 
instructions, are:
	%eax = 17
	%ecx = 18
	%edx = 19
	%ebx = 16
However, the outputs were:
 	%eax = 16
	%ecx = 16
	%edx = 16
	%ebx = 16
The problem was that the CPU was not inserting bubbles until the values of %eax, 
%ecx, and %edx have changed to 1, 2, and 3 respectively (not putting bubbles until 
the irmovls instructions finish their write back stage). This caused the addl instructions
to move forward to Execute stages before irmovls instructions have written their new values. 
This problem occured because CPU.java was not checking srcB is data hazard or not in Execute stage. 
This can be fixed by adding an additional condition isDataHaardOnReg (d.srcB.getValueProduced()) 
to make the CPU to check both srcA and srcB's data hazards.

if (isDataHazardOnReg (d.srcA.getValueProduced()) 
	/* Code Added */ || isDataHazardOnReg (d.srcB.getValueProduced())) {
      F.stall  = true;
      D.stall  = true;
      E.bubble = true;
    }

Second bug:
In the test case aLoadUse, the expected value of %ebx at the end of the program 
must be 30. However, the real output was 10. This is because the CPU puts addl
instructions into Execute stage before the mrmovl has finished to write a new value 
to a target register. This means that the CPU is not checking if Write Back stage is
writing values from memory to registers srcA or srcB. This problem can be solved by
stalling the CPU if dstM in Execute, Memory or Write Back stage is equal to srcA
or srcB.

private boolean isDataHazardOnReg (int reg)
  {
    return reg != R_NONE && (E.dstE.get() == reg || 
    						/* Change M.dstE to E.dstM */ E.dstM.get() == reg
    						/* Code Added */
    						|| M.dstE.get() == reg || M.dstM.get() == reg
    						|| W.dstE.get() == reg || W.dstM.get() == reg);
  }

Third bug:
In the test case notTKJmp, the first line of JNT, irmovl $0x1, %ebx, was being
executed which should not be. This is due to the CPU passing an instruction in
predicted PC to decode and executing the instruction before finishing the conditional 
jump instruction. This problem can be fixed by applying one more condition for control
hazard which is inserting a stall if Execute stage is handling a conditional jump.

else if ((D.iCd.get()==I_JXX && D.iFn.get()!=C_NC)
    	/* Code Added */
    	|| (E.iCd.get() == I_JXX && E.iFn.get() != C_NC)) {
      F.stall  = true;
      D.bubble = true;
    }

Question 2:

sum.s
cCnt = 117
iCnt = 45
CPI = 117/45 = 2.6

max.s
cCnt = 236
iCnt = 98
CPI = 236 / 98 = 2.408

mergesort-student.s
cCnt = 5035
iCnt = 2055
CPI = 5035 / 2055 = 2.450


Amount of Time Spent = 10hrs
