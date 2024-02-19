#programme qui permet d afficher l element maximum d un tableau
	.data
tab: 	.word 10, 10, -6, 20, 1, 1, 999, 800, -800, -2
	.eqv tablen,10
	.eqv Exit,10
	.eqv PrintInt, 1

	.text
#prendre nombres dans tableau
	la s1, tab
	li s2, tablen
	lw s0, 0(s1)#valeur du maximum
	
loop:
	lw s3,0(s1)
	bge s0,s3, moins
	mv s0,s3

moins:
	addi s1,s1,4
	addi s2,s2,-1
	bgtz s2,loop
	
#print et fin
	mv a0,s0
	li ,a7,PrintInt
	ecall
	li,a7,Exit
	ecall
	
	
	


	
