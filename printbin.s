#programme qui lit un nombre et affiche sa representation binaire sur 64 bits

#etiquette utilisee
	.eqv ReadInt,5
	.eqv PrintInt, 1
	.eqv Exit, 10
	
#Lecture du nombre

	li a7, ReadInt
	ecall
	mv s0, a0
	
#interpretation du nombre en bit
	li s1, 63
loop:
	srl  s2, s0, s1
	andi  a0,s2, 1
	li a7, PrintInt
	ecall
	addi, s1, s1, -1
	bgez s1, loop
	
	li a7, Exit
	ecall
	
	
	
	
	