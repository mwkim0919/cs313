Name:		Minwoo Kim
Student #:	66294083

randl rB

Fetch:
	icode:ifun 	<- M1[PC]
	rA:rB 		<- M1[PC+1]
	valP 		<- PC + 2
Decode:
Execute:
	valE 		<- GENERATE A RANDOM 32-BIT NUMBER
Memory:
Write Back:
	R[rB] 		<- valE
PC update:
	PC 			<- valP


rmmovl rA, D(rB, 4)

Fetch:
	icode:ifun 	<- M1[PC]
	rA:rB 		<- M1[PC+1]
	valC 		<- M4[PC+2]
	valP 		<- PC + 6
Decode:
	valA 		<- R[rA]
	valB 		<- R[rB]
Execute:
	valE 		<- valC + (valB * 4)
Memory:
	M[valE] 	<- valA
Write back:
PC update:
	PC 			<- valP


mrmovl D(rB, 4), rA

Fetch:
	icode:ifun 	<- M1[PC]
	rA:rB 		<- M1[PC+1]
	valC 		<- M4[PC+2]
	valP 		<- PC + 6
Decode:
	valB 		<- R[rB]
Execute:
	valE 		<- valC + (valB * 4)
Memory:
	valM 		<- M4[valE]
Write back:
	R[rA] 		<- valM
PC update:
	PC 			<- valP


call *D(rB), rA

Fetch:
	icode:ifun 	<- M1[PC]
	rA:rB 		<- M1[PC+1]
	valC 		<- M4[PC+2]
	valP 		<- PC + 6
Decode:
	valB 		<- R[rB]
Execute:
	valE		<- valC + valB
Memory:
	valM 		<- M4[valE]
Write back:
	R[rA] 		<- valP
PC update:
	PC 			<- valM	

Test coverage

randl rB

The tests in randl.s cover all test cases as they cover all possible 
registers that a random 32-bit number can go into.

All test cases ared passed.

rmmovl rA, D(rB,4) & mrmovl D(rB, 4), rA

The tests in movl.s cover all cases as given the value of rB (0,1,2,...) rmmovl 
correctly writes the value of rA into the memory address of (D + R[rB]*4) and mrmovl 
correctly reads the elements in an array stored in memory with address of (D + R[rB]*4) 
and write the value to rA.

All test cases are passed.

call *D(rB), rA

The tests in jmp.s cover all cases as the instruction jumps to the value of address given
at the memory address of (D + R[rB]) where the value of R[rB] is 0,4,8,12,.....

All test cases are passed.

Time spent to do this assignment:
15 hours.
