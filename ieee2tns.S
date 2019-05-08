		;		ARM Programming Assignment #3: IEEE 754 to TNS bit-level marshaller
		;
		;		Write a program to convert a 32-bit single-precision IEEE 754 floating-point
		;       number to the Tandem Non-stop Series (TNS) format. Refer to the README for a
		;       description of the format. Convert the numbers in `floats` and write the TNS
		;       equivalents into the `tns` area, one after the other.
		;
		;       Bonus:
		;       1. (30 extra points) Implement the reverse conversion, from TNS to IEEE.
		;       2. (50 extra points) Organize the code into two subroutines, with stack
		;          support.
		;       3. (10 extra points) In the main program, implement a round-trip conversion
		;          and prove the results match the initial values in 'floats'.  Define a
		;          `FILL` region to hold the IEEE 754 results.
		;

		;		Your code here

floats	     DCD	0xa0bcff0d, 0x13c0adea
tns	          FILL	16
mask 		DCD 	&80000000
Iexpo       	DCD 	&7F800000           
Ifrac		DCD 	&007FFFFF
Texpo       	DCD 	&000001FF           
Tfrac		DCD  &7FFFFE00
			ADR  R0, floats
			MOV  R1, #0
			LDR  R3, [R0, R1]  
			MOV  R1, #4
			LDR  R10, [R0, R1]  
			MOV  R1, #0	
			B    TNScon
			B    IEEEcon		



TNScon
			ADR R0,mask
			LDR R1, [R0, R1]
			ADR R0, Tfrac		
			LDR R3, [R0, R1]
			ADR R0, Texpo		
			LDR R5, [R0, R1]	
			MOV R0, #0	

			AND R2,R10,R1   	  
			AND R4,R10,R2  		
			AND R6,R10,R3		
			MOV R6,R6, LSR #8			
			AND R6,R10,R5   	 
			SUB R6,R6,#129		
			ADD R6,R6,LSL #23	
			CMP R6,R10
			BEQ Done

IEEEcon		
			ADR R0,mask
			LDR R1,[R0, R1]	
			AND R2,R0,R1	
			ADR R0, Iexpo		 
			LDR R3,[R0, R1]		
			AND R4,R0,R3		
			MOV R4,R4,LSR #23	
			ADD R4,R4,#129	
			ADR R0, Ifrac		
			LDR R5,[R0, R1]
			AND R6,R0,R5
			ADD R7,R6, LSL #8		
			ORR R0,R7,R4
			CMP R0,R10
			BEQ done		 



Done			ADR R0, tns
			STR R, [R0, R1]
		     MOV R1, #16
			STR R10, [R0, R1]
			END