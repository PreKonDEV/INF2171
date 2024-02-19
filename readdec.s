#programme qui lit un nombre decimal et l affiche

#etiquettes utilise
	.eqv PrintInt, 1
	.eqv Exit, 10
	.eqv ReadChar,12
	
#lecture du chiffre :

	li s0,0

loop: 
	li a7, ReadChar
	ecall
	mv s1,a0
	
	li t0, '0'
	blt s1,t0,affiche
	li t0, '9'
	bgt s1, t0, affiche
	
	addi s1,s1, -0x30
	
	li t0,10
	mul s0,s0,t0
	add s0,s0,s1
	j loop
	
affiche:
	li a7, PrintInt
	mv a0, s0
	ecall

	li a7, Exit
	ecall


	
	

