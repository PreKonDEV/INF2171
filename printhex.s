#programme qui lit un nombre et affiche sa representation en hexadecimal

#etiquette utilise
	.eqv ReadInt,5
	.eqv Exit, 10
	.eqv PrintChar,11
	
#lecture du nombre
	li a7, ReadInt
	ecall
	mv s0,a0
	
#transformation hexadecimal
	li s1, 60
loop:
	srl s2, s0, s1
	andi a0,s2,0xF
	li t0,10
	bge a0, t0, lettre
	addi a0,a0,'0'
	j affiche
	
lettre:
	addi a0,a0, 55
affiche:
	li a7, PrintChar
	ecall
	addi s1,s1, -4
	bgez s1, loop
	
	li a7, Exit
	ecall
	
	