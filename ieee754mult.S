		;		ARM Programming Assignment #3: 32 bit IEEE 754 single-precision multiplier
		;
		;		Write a 32-bit floating point multiplier. The numbers will be represented
		;       in the single-precision IEEE 754 floating-point standard. The result should
		;       also be in IEEE 754 binary32. Assume you only have normalized numbers, i.e.
		;       the exponent is never 0b00000000.
		;		Write the result in the provided "fill" word.

		;		Your code here

floats	DCD		0xa0bcff0d, 0x13c0adea
result	FILL	8

		MOV		R0, #0
		MOV		R1, #0
		MOV		R3, #0
		ADR		R2, floats
		LDR		R2, [R2]
		ADR		R4, floats
		ADD		R4, R4, #4
		LDR		R4, [R4]
loop
		TST		R4, #1
		ADDSNE	R0, R0, R2
		TST		R4, #1
		ADCNE	R1, R1, R3
		LSLS		R2, R2, #1
		LSL		R3, R3, #1
		ADC		R3, R3, #0
		LSRS		R4, R4, #1
		BNE		loop
		B		endit
		
endit
		ADR		R3, result
		STR		R0, [R3]
		ADD		R3, R3, #4
		STR		R1, [R3]