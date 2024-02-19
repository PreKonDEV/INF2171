#Programme qui permet de load et store 2 donnee

#etiquettes utilisee
	.eqv ReadInt, 5
	.eqv PrintInt, 1
	.eqv Exit, 10
	.eqv PrintChar, 12
	
#lecture et storage du premier nombre
	li a7, ReadInt
	ecall
	sw a0, n1,t0
	
#lecture et storage du deuxieme nombre
	li a7, ReadInt
	ecall
	sw a0, n2,t0
	
#affichage des deux nombres
	lw a0,n1
	li a7, PrintInt
	ecall
	li a0, '\n'
	li a7,PrintChar
	ecall
	li a7,PrintInt
	lw a0,n2
	ecall

#exit
	li a7, Exit
	ecall




	.data
n1:	.word 0		# premier nombre (32 bits signé)
n2:	.word 0		# second nombre (32 bits signé)
